using Newtonsoft.Json;
using SampleCode.Models;
using SampleCode.Security;
using System;
using System.Collections.Generic;
using System.Net;
using System.Text;
using System.Web.Mvc;

namespace SampleCode.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
           return CallAPIByHMAC();
           //return CallAPIByTicket();
        }
        /// <summary>
        /// HMAC 取得API
        /// </summary>
        /// <returns></returns>
        private ActionResult CallAPIByHMAC()
        {
            WebClient wc = new WebClient();
            wc.Encoding = Encoding.UTF8;
            //申請的APPID
            //（FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF 為 Guest 帳號，以IP作為API呼叫限制，請替換為註冊的APPID & APPKey）
            string APPID = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF";
            //申請的APPKey
            string APPKey = @"FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF";

            //取得當下UTC時間
            string xdate = DateTime.Now.ToUniversalTime().ToString("r");
            string SignDate = "x-date: " + xdate;
            //取得加密簽章
            string Signature = HMAC_SHA1.Signature(SignDate, APPKey);
            string sAuth = "hmac username=\"" + APPID + "\", algorithm=\"hmac-sha1\", headers=\"x-date\", signature=\"" + Signature + "\"";
            //簽章資訊加入Headers
            wc.Headers.Add("Authorization", sAuth);
            wc.Headers.Add("x-date", xdate);

            List<RailStation> Data = new List<RailStation>();
            //欲呼叫之API網址(此範例為台鐵車站資料)  
            var APIUrl = "http://ptx.transportdata.tw/MOTC/v2/Rail/TRA/Station?$top=10&$format=JSON";
            string result = wc.DownloadString(APIUrl);
            Data = JsonConvert.DeserializeObject<List<RailStation>>(result);
            ViewBag.ticket = Signature;
            return View(Data);
        }

        /// <summary>
        /// 舊版-Ticket 取得API
        /// </summary>
        /// <returns></returns>
        private ActionResult CallAPIByTicket()
        {
            WebClient wc = new WebClient();
            wc.Encoding = Encoding.UTF8;
            //申請的帳號
            string account = "申請的帳號";
            //註冊時的密碼
            string password = "註冊時的密碼";
            //本平台主要服務API均為免申請、免綁IP 使用者可直接透過公用帳號使用
            //登入取得憑證網址
            var LoginUrl = "https://ptx.transportdata.tw/MOTC/Account/Login?account=" + account + "&password=" + password;
            //登入取得憑證
            byte[] bResult = wc.DownloadData(LoginUrl);
            string str = System.Text.Encoding.UTF8.GetString(bResult);
            LoginResult UserData = JsonConvert.DeserializeObject<LoginResult>(str);
            List<RailStation> Data = new List<RailStation>();
            //若登入成功
            if (UserData.status)
            {
                //取得憑證  ps.憑證有時效性,判斷憑證是否過期需重新取得請自行加值處理
                var ticket = UserData.ticket;
                ViewBag.ticket = ticket;
                //欲呼叫之API網址(此範例為台鐵車站資料)
                var APIUrl = "http://ptx.transportdata.tw:80/MOTC/Rail/TRA/Station?ticket=" + ticket;
                string result = wc.DownloadString(APIUrl);
                Data = JsonConvert.DeserializeObject<List<RailStation>>(result);
                return View(Data);
            };
            //若失敗
            ViewBag.message = UserData.message;
            return View(Data);
        }

        public ActionResult About()
        {
            ViewBag.Message = "您的應用程式描述頁面。";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "您的連絡頁面。";

            return View();
        }
    }
}
