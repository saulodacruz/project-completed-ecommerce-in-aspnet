using Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepProdutoObservacoes
    {
        public ProdutoObservacoes Obter(int codProdutoObservacoes)
        {
            return Obter("SELECT * FROM ProdutoObservacoes WHERE CodProdutoObservacoes = @codProdutoObservacoes",
                        new[] { new SqlParameter("@codProdutoObservacoes", codProdutoObservacoes) });
        }
        public List<ProdutoObservacoes> ObterPorProduto(int codProduto)
        {
            return Listar("SELECT * FROM ProdutoObservacoes WHERE CodProduto = @codProduto",
                new[] { new SqlParameter("@codProduto", codProduto) });
        }
        public ProdutoObservacoes Cadastrar(ProdutoObservacoes i)
        {
            try
            {
                using (var dados = RepUtil.ExecuteReader($@"INSERT INTO ProdutoObservacoes(CodProduto,Nome,Tipo,OpcoesCombo,Obrigatorio)
                                                            VALUES(@codProduto,@nome,@tipo,@opcoesCombo,@obrigatorio)
                                                            SELECT SCOPE_IDENTITY() CodProdutoObservacoes;",
                                                            new[] {
                                                                new SqlParameter("@codProduto", i.CodProduto),
                                                                new SqlParameter("@nome", i.Nome ?? string.Empty),
                                                                new SqlParameter("@tipo", i.Tipo ?? string.Empty),
                                                                new SqlParameter("@opcoesCombo", i.OpcoesCombo ?? string.Empty),
                                                                new SqlParameter("@obrigatorio", i.Obrigatorio)
                                                            }))
                {
                    while (dados.Read())
                        i.CodProdutoObservacoes = Convert.ToInt32(dados["CodProdutoObservacoes"]);

                    return i;
                }
            }
            catch
            {
                return null;
            }
        }
        public ProdutoObservacoes Editar(ProdutoObservacoes i)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"UPDATE ProdutoObservacoes SET 
                                          CodProduto = @codProduto,
                                          Nome = @nome,
                                          Tipo = @tipo,
                                          OpcoesCombo = @opcoesCombo,
                                          Obrigatorio = @obrigatorio
                                          WHERE CodProdutoObservacoes = @codProdutoObservacoes",
                                          new[] {
                                              new SqlParameter("@codProduto", i.CodProduto),
                                              new SqlParameter("@nome", i.Nome ?? string.Empty),
                                              new SqlParameter("@tipo", i.Tipo ?? string.Empty),
                                              new SqlParameter("@opcoesCombo", i.OpcoesCombo ?? string.Empty),
                                              new SqlParameter("@obrigatorio", (i.Obrigatorio ? 1 : 0)),
                                              new SqlParameter("@codProdutoObservacoes", i.CodProdutoObservacoes),
                                          }) > 0 ? i : null;
            }
            catch
            {
                return null;
            }
        }
        public bool Remover(int codProdutoObservacoes)
        {
            return RepUtil.ExecutaSQL("DELETE FROM ProdutoObservacoes WHERE CodProdutoObservacoes = @codProdutoObservacoes",
                                      new[] { new SqlParameter("@codProdutoObservacoes", codProdutoObservacoes) }) > 0;
        }
        private ProdutoObservacoes Obter(string command, SqlParameter[] parameters = null)
        {
            var item = new ProdutoObservacoes();
            using (var dados = RepUtil.ExecuteReader(command, parameters))
            {
                while (dados.Read())
                    item = PopularObjeto(dados);
            }
            return item;
        }
        private List<ProdutoObservacoes> Listar(string command, SqlParameter[] parameters = null)
        {
            var list = new List<ProdutoObservacoes>();
            using (var dados = RepUtil.ExecuteReader(command, parameters))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados));
            }
            return list;
        }
        public ProdutoObservacoes PopularObjeto(SqlDataReader sql)
        {
            return new ProdutoObservacoes
            {
                CodProdutoObservacoes = Convert.ToInt32(sql["CodProdutoObservacoes"]),
                CodProduto = Convert.ToInt32(sql["CodProduto"]),
                Nome = sql["Nome"].ToString(),
                Tipo = sql["Tipo"].ToString(),
                OpcoesCombo = sql["OpcoesCombo"].ToString(),
                Obrigatorio = Convert.ToBoolean(sql["Obrigatorio"])
            };
        }
    }
}
