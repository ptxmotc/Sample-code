using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace SampleCode.Security
{
    public class HMAC_SHA1
    {
        public static string Signature(string xDate, string AppKey, string inputCharset = "utf-8")
        {
            Encoding _encode = Encoding.GetEncoding(inputCharset);
            byte[] _byteData = Encoding.GetEncoding(inputCharset).GetBytes(xDate);
            HMACSHA1 _hmac = new HMACSHA1(_encode.GetBytes(AppKey));

            using (CryptoStream _cs = new CryptoStream(Stream.Null, _hmac, CryptoStreamMode.Write))
            {
                _cs.Write(_byteData, 0, _byteData.Length);
            }
            return Convert.ToBase64String(_hmac.Hash);
        }
    }
}