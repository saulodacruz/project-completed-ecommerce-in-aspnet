using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Pagamento
    {
        public string IdWirecardPagamento { get; set; }
        public int Parcelas { get; set; }
        public bool Boleto { get; set; }
        public long CodPedido { get; set; }
        public string IdWirecardPedido { get; set; }
        public DateTime Data { get; set; }

        //not DB
        public string Nome { get; set; }
        public DateTime DataNascimento { get; set; }
        public string CPF { get; set; }
        public string Hash { get; set; }
        public string CodPedidoCripto { get; set; }
        public string IdWirecardPedidoCripto { get; set; }
    }
}
