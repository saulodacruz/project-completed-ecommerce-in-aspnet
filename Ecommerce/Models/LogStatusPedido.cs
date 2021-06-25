using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class LogStatusPedido
    {
        public long CodLogStatusPedido { get; set; }
        public long CodPedido { get; set; }
        public int CodStatusPedido { get; set; }
        public DateTime Data { get; set; }
        public StatusPedido StatusPedido { get; set; }
        public string Observacao { get; set; }
    }
}
