using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Pessoa : Endereco
    {
        public int CodPessoa { get; set; }
        public string Nome { get; set; }
        public string Sobrenome { get; set; }
        public string CPF { get; set; }
        public DateTime DataNascimento { get; set; }
        public string Telefone { get; set; }
        public int CodEnderecoCobranca { get; set; }
        public Endereco EnderecoCobranca { get; set; }
    }
}
