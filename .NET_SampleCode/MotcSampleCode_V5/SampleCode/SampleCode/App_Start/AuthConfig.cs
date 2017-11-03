using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Web.WebPages.OAuth;
using SampleCode.Models;

namespace SampleCode
{
    public static class AuthConfig
    {
        public static void RegisterAuth()
        {
            // 若要讓此網站的使用者使用其他網站 (如 Microsoft、Facebook 和 Twitter) 的帳戶登入，
            // 您必須更新此網站。如需詳細資訊，請造訪 http://go.microsoft.com/fwlink/?LinkID=252166

            //OAuthWebSecurity.RegisterMicrosoftClient(
            //    clientId: "",
            //    clientSecret: "");

            //OAuthWebSecurity.RegisterTwitterClient(
            //    consumerKey: "",
            //    consumerSecret: "");

            //OAuthWebSecurity.RegisterFacebookClient(
            //    appId: "",
            //    appSecret: "");

            //OAuthWebSecurity.RegisterGoogleClient();
        }
    }
}
