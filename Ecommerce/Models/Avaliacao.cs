using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Avaliacao
    {
        public int CodAvaliacao { get; set; }
        public int CodUsuario { get; set; }
        public int CodProduto { get; set; }
        public int Estrelas { get; set; }
        public string Comentario { get; set; }
        public DateTime Data { get; set; }
        public Usuario Usuario { get; set; }
    }
}
