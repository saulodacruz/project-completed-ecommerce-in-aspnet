using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class JsonItemCarrinho
    {
        public int cod { get; set; }
        public string nome { get; set; }
        public decimal valor { get; set; }
        public int qtd { get; set; }
        public string urlImg { get; set; }
        public string url { get; set; }
        public string obs { get; set; }
    }
}
