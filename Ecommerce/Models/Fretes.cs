using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Fretes
    {
        public Frete PAC { get; set; }
        public Frete SEDEX { get; set; }
        public string PACValor { get; set; }
        public string PACPrazo { get; set; }
        public string SEDEXValor { get; set; }
        public string SEDEXPrazo { get; set; }
        public class Frete
        {
            public string name { get; set; }
            public string price { get; set; }
            public string discount { get; set; }
            public string delivery_time { get; set; }
            public string error { get; set; }
        }
    }
}
