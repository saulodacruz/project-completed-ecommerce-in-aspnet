using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class JsonObject
    {
        public bool sucesso { get; set; }
        public string mensagem { get; set; }
        public dynamic obj { get; set; }
    }
}
