using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SampleCode.Models
{
    /// <summary>
    /// 台鐵車站基本資料
    /// </summary>
    public class RailStation
    {
        /// <summary>
        /// 車站代碼
        /// </summary>
        public string StationID { get; set; }
        /// <summary>
        /// 車站中文
        /// </summary>
        public string StationNameZh { get; set; }
        /// <summary>
        /// 車站英文
        /// </summary>
        public string StationNameEn { get; set; }
        /// <summary>
        /// 經度
        /// </summary>
        public long StationLon { get; set; }
        /// <summary>
        /// 緯度
        /// </summary>
        public long StationLat { get; set; }
        /// <summary>
        /// 車站地址
        /// </summary>
        public string StationAddress { get; set; }
        /// <summary>
        /// 聯繫電話
        /// </summary>
        public string StationPhone { get; set; }
        /// <summary>
        /// 車站級別定義
        /// </summary>
        public string StationClass { get; set; }
    }
}