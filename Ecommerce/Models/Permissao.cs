using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Permissao
    {
        public int CodPermissao { get; set; }
        public string Nome { get; set; }
        public IList<Usuario> Usuarios { get; set; }
    }
}
