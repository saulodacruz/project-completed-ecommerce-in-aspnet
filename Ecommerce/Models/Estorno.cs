using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Estorno
    {
        public long CodEstorno { get; set; }
        public long CodPedido { get; set; }
        public string TipoPagamento { get; set; }
        public string NumeroBanco { get; set; }
        public string Agencia { get; set; }
        public string Conta { get; set; }
        public string CPF { get; set; }
        public string NomeDeposito { get; set; }
        public string Observacao { get; set; }
        public string IdWirecard { get; set; }
        public DateTime DataSolicitacao { get; set; }
        public DateTime? Data { get; set; }
        public Pedido Pedido { get; set; }
    }
}
