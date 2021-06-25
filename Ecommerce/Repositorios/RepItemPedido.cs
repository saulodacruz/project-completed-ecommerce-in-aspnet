using Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepItemPedido
    {
        public List<ItemPedido> ObterPorPedido(long codPedido)
        {
            var list = new List<ItemPedido>();
            using (var dados = RepUtil.ExecuteReader(@"SELECT * FROM ItemPedido ic
                                                    JOIN Produto p ON ic.CodProduto = p.CodProduto
                                                    WHERE CodPedido = @codPedido",
                                                    new[] { new SqlParameter("@codPedido", codPedido) }))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados));
            }
            return list;
        }
        public bool Cadastrar(ItemPedido ic)
        {
            try
            {
                return RepUtil.ExecutaSQL(@"INSERT INTO ItemPedido (CodProduto, CodPedido, Quantidade, Observacao) 
                                            VALUES (@codProduto, @codPedido, @quantidade, @observacao)",
                                            new[] {
                                                new SqlParameter("@codProduto", ic.CodProduto),
                                                new SqlParameter("@codPedido", ic.CodPedido),
                                                new SqlParameter("@quantidade", ic.Quantidade),
                                                new SqlParameter("@observacao", ic.Observacao ?? string.Empty),
                                            }) > 0;
            }
            catch
            {
                return false;
            }
        }
        public bool Remover(int codProduto, long codPedido)
        {
            return RepUtil.ExecutaSQL("DELETE FROM ItemPedido WHERE CodProduto = @codProduto AND CodPedido = @codPedido",
                                    new[] {
                                        new SqlParameter("@codProduto", codProduto),
                                        new SqlParameter("@codPedido", codPedido)
                                    }) > 0;
        }
        public ItemPedido PopularObjeto(SqlDataReader sql)
        {
            return new ItemPedido
            {
                CodProduto = Convert.ToInt32(sql["CodProduto"]),
                CodPedido = Convert.ToInt64(sql["CodPedido"]),
                Quantidade = Convert.ToInt32(sql["Quantidade"]),
                Observacao = sql["Observacao"].ToString(),
                Produto = new RepProduto().PopularObjeto(sql)
            };
        }
    }
}
