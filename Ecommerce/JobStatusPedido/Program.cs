using Models;
using Newtonsoft.Json;
using Repositorios;
using Servicos;
using Servicos.Wirecard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using Wirecard.Models;

namespace JobStatusPedido
{
    class Program
    {            
        static void Main(string[] args)
        {
            new SerAtualizacaoStatusPedidos().Executar();
        }
    }
}
