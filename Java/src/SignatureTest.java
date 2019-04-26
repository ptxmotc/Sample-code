import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;
import java.security.SignatureException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.zip.GZIPInputStream;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class SignatureTest {

	public static void main(String[] args) {
		HttpURLConnection connection=null;
		String APIUrl = "https://ptx.transportdata.tw/MOTC/v2/Bus/RealTimeByFrequency/City/Chiayi?$top=1&$format=JSON";
	    //申請的APPID
        //（FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF 為 Guest 帳號，以IP作為API呼叫限制，請替換為註冊的APPID & APPKey）
        String APPID = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF";
        //申請的APPKey
        String APPKey = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF";

        //取得當下的UTC時間，Java8有提供時間格式DateTimeFormatter.RFC_1123_DATE_TIME
        //但是格式與C#有一點不同，所以只能自行定義
        String xdate = getServerTime();
        String SignDate = "x-date: " + xdate;
        
        
        String Signature="";
		try {
			//取得加密簽章
			Signature = HMAC_SHA1.Signature(SignDate, APPKey);
		} catch (SignatureException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		System.out.println("Signature :" + Signature);
        String sAuth = "hmac username=\"" + APPID + "\", algorithm=\"hmac-sha1\", headers=\"x-date\", signature=\"" + Signature + "\"";
        System.out.println(sAuth);
		   try{  
		      URL url=new URL(APIUrl);
		      if("https".equalsIgnoreCase(url.getProtocol())){
		            SslUtils.ignoreSsl();
		        }
		      connection=(HttpURLConnection)url.openConnection();
		      connection.setRequestMethod("GET");
		      connection.setRequestProperty("Authorization", sAuth);
		      connection.setRequestProperty("x-date", xdate);
		      connection.setRequestProperty("Accept-Encoding", "gzip");
		      connection.setDoInput(true);
		      connection.setDoOutput(true);
		      
		      //返回的數據已經過解壓
		      InputStream inputStream = connection.getInputStream();
		      InputStreamReader reader = new InputStreamReader(inputStream,"UTF-8");
		      BufferedReader in = new BufferedReader(reader);
		      
		      //讀取回傳資料
		      String line, response="";
		      while ((line = in.readLine()) != null) {
		          response+=(line+"\n");
		      }
		      
		      Type RailStationListType = new TypeToken<ArrayList<RailStation>>(){}.getType();
		      Gson gsonReceiver = new Gson();
		      List<RailStation> obj = gsonReceiver.fromJson(response, RailStationListType);
		      System.out.println(response);
		      
		   }catch(ProtocolException e){
			   e.printStackTrace();
		   }
		   
		   catch(Exception e){
			   e.printStackTrace();
		   }
		 
		  
	}
	
    //取得當下UTC時間
	public static String getServerTime() {
	    Calendar calendar = Calendar.getInstance();
	    SimpleDateFormat dateFormat = new SimpleDateFormat(
	        "EEE, dd MMM yyyy HH:mm:ss z", Locale.US);
	    dateFormat.setTimeZone(TimeZone.getTimeZone("GMT"));
	    return dateFormat.format(calendar.getTime());
	}

}
