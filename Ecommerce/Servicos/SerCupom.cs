using Models;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerCupom
    {
        public List<Cupom> Obter()
        {
            var list = new RepCupom().Obter();
            return list;
        }
        public Cupom Obter(int codCupom)
        {
            var item = new RepCupom().Obter(codCupom);
            return item;
        }
        public JsonObject Obter(string codigo)
        {
            var item = new RepCupom().Obter(codigo);
            if (item.CodCupom > 0)
                return new JsonObject { sucesso = true, obj = item };
            return new JsonObject { sucesso = false, mensagem = "Cupom inválido ou vencido." }; ;
        }
        public Cupom Cadastrar(Cupom c)
        {
            if (Validar(c))
                return new RepCupom().Cadastrar(c);
            return null;
        }
        public Cupom Editar(Cupom c)
        {
            if (Validar(c) && c.CodCupom > 0)
                return new RepCupom().Editar(c);
            return null;
        }
        public bool Desabilitar(int codCupom)
        {
            return new RepCupom().Desabilitar(codCupom);
        }
        public bool Remover(int codCupom)
        {
            return new RepCupom().Remover(codCupom);
        }
        private bool Validar(Cupom c)
        {
            if (c.Valor <= 0)
                return false;

            if (c.Data == null)
                return false;

            if (c.Codigo == null)
                return false;
            else if (c.Codigo.Trim().Length == 0 && c.Codigo.Length > 50)
                return false;

            return true;
        }
    }
}
