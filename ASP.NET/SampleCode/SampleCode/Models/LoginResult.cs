using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SampleCode.Models
{
    public class LoginResult
    {
        public bool status { get; set; }
        public string message { get; set; }
        public Guid? ticket { get; set; }
    }
}