//
//  main.swift
//  HMAC-Signature
//
//  Created by Talka_Ying on 2018/9/27.
//  Copyright © 2018年 Talka_Ying. All rights reserved.
//

import Foundation
import CommonCrypto

enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

extension String {
    
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        
        let cKey = key.cString(using: String.Encoding.utf8)
        let cData = self.cString(using: String.Encoding.utf8)
        let digestLen = algorithm.digestLength
        var result = [CUnsignedChar](repeating: 0, count: digestLen)
        CCHmac(algorithm.HMACAlgorithm, cKey!, strlen(cKey!), cData!, strlen(cData!), &result)
        let hmacData:Data = Data(bytes: result, count: digestLen)
        let hmacBase64 = hmacData.base64EncodedString(options: .lineLength64Characters)
        
        return String(hmacBase64)
    }
}

func getServerTime() -> String {
    
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "EEE, dd MMM yyyy HH:mm:ww zzz"
    dateFormater.locale = Locale(identifier: "en_US")
    dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
    
    return dateFormater.string(from: Date())
}

let APIUrl = "https://ptx.transportdata.tw/MOTC/v2/Rail/TRA/Station?$top=10&$format=JSON";
let APP_ID = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF"
let APP_KEY = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF"

let xdate:String = getServerTime();
let signDate = "x-date: " + xdate;

let base64HmacStr = signDate.hmac(algorithm: .SHA1, key: APP_KEY)
let authorization:String = "hmac username=\""+APP_ID+"\", algorithm=\"hmac-sha1\", headers=\"x-date\", signature=\""+base64HmacStr+"\""

let url = URL(string: APIUrl)

let sema = DispatchSemaphore( value: 0)

var request = URLRequest(url: url!)

request.setValue(xdate, forHTTPHeaderField: "x-date")
request.setValue(authorization, forHTTPHeaderField: "Authorization")
request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")

let completionHandler = {(data: Data?, response: URLResponse?, error: Error?) -> Void in
    
    let content = String(data: data!, encoding: String.Encoding.utf8)!
    print(content)
    sema.signal();
}

URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
sema.wait();
