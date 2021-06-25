using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Cupom
    {
        public int CodCupom { get; set; }
        public decimal Valor { get; set; }
        public DateTime Data { get; set; }
        public DateTime? DataDesabilitado { get; set; }
        public string Codigo { get; set; }
    }
}
