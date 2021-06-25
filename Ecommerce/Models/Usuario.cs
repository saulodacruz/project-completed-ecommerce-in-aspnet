using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Usuario : Pessoa
    {
        public int CodUsuario { get; set; }
        public string Email { get; set; }
        public string Senha { get; set; }
        public List<Permissao> Permissoes { get; set; }
        public DateTime DataCadastro { get; set; }
        public string IdWirecard { get; set; }
        public List<Pedido> Pedidos { get; set; }
    }
}
