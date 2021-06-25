using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class TipoEmbalagem
    {
        public char CodTipoEmbalagem { get; set; }
        public decimal Altura { get; set; }
        public decimal Largura { get; set; }
        public decimal Comprimento { get; set; }
        public decimal Diametro { get; set; }
        public decimal Peso { get; set; }
    }
}
