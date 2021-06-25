using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepItemCarrinho
    {
        public List<ItemCarrinho> Obter(int codUsuario, bool incluirProduto)
        {
            var list = new List<ItemCarrinho>();
            using (var dados = RepUtil.ExecuteReader(@"SELECT *, te.CodTipoEmbalagem TipCodTipoEmbalagem, te.Altura TipAltura, te.Largura TipLargura, te.Comprimento TipComprimento, te.Diametro TipDiametro, te.Peso TipPeso
                                                    FROM ItemCarrinho ic
                                                    JOIN Produto p ON ic.CodProduto = p.CodProduto
                                                    JOIN TipoEmbalagem te ON p.CodTipoEmbalagem = te.CodTipoEmbalagem
                                                    WHERE CodUsuario = @codUsuario",
                                                    new[]{ new SqlParameter("@codUsuario", codUsuario) }))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados));
            }
            return list;
        }
        public bool Cadastrar(ItemCarrinho ic)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"INSERT INTO ItemCarrinho (CodProduto, CodUsuario, Quantidade, Observacao) 
                                             VALUES (@codProduto, @codUsuario, @quantidade, @observacao)",
                                             new[] {
                                                 new SqlParameter("@codProduto", ic.CodProduto),
                                                 new SqlParameter("@codUsuario", ic.CodUsuario),
                                                 new SqlParameter("@quantidade", ic.Quantidade),
                                                 new SqlParameter("@observacao", ic.Observacao ?? string.Empty),
                                             }) > 0;
            }
            catch
            {
                return false;
            }
        }
        public bool Remover(int codProduto, int codUsuario)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM ItemCarrinho WHERE CodProduto = @codProduto AND CodUsuario = @codUsuario",
                                        new[] {
                                            new SqlParameter("@codProduto", codProduto),
                                            new SqlParameter("@codUsuario", codUsuario)
                                        }) > 0;
        }
        private ItemCarrinho PopularObjeto(SqlDataReader sql)
        {
            var item = new ItemCarrinho
            {
                CodProduto = Convert.ToInt32(sql["CodProduto"]),
                CodUsuario = Convert.ToInt32(sql["CodUsuario"]),
                Quantidade = Convert.ToInt32(sql["Quantidade"]),
                Observacao = sql["Observacao"].ToString(),
                Produto = new RepProduto().PopularObjeto(sql)
            };
            item.Produto.TipoEmbalagem = new RepTipoEmbalagem().PopularObjetoAlias(sql);
            return item;
        }
        public bool AtualizarCarrinho(List<ItemCarrinho> ics, int codUsuario)
        {
            try
            {
                using (SqlConnection cnn = new SqlConnection(RepUtil.ConnectionStrings))
                {
                    cnn.Open();
                    using (SqlCommand cmd = new SqlCommand($"DELETE FROM ItemCarrinho WHERE CodUsuario = @codUsuario", cnn))
                    {
                        cmd.Parameters.Add(new SqlParameter("@codUsuario", codUsuario));
                        cmd.ExecuteNonQuery();
                    }

                    var dt = new DataTable();
                    dt.Columns.Add(new DataColumn("CodProduto", typeof(int)));
                    dt.Columns.Add(new DataColumn("CodUsuario", typeof(int)));
                    dt.Columns.Add(new DataColumn("Quantidade", typeof(int)));
                    dt.Columns.Add(new DataColumn("Observacao", typeof(string)));

                    ics.ForEach(x =>
                    {
                        DataRow dr = dt.NewRow();
                        dr["CodProduto"] = x.CodProduto;
                        dr["CodUsuario"] = x.CodUsuario;
                        dr["Quantidade"] = x.Quantidade;
                        dr["Observacao"] = x.Observacao;
                        dt.Rows.Add(dr);
                    });
                    var objbulk = new SqlBulkCopy(cnn)
                    {
                        DestinationTableName = "ItemCarrinho"
                    };
                    objbulk.ColumnMappings.Add("CodProduto", "CodProduto");
                    objbulk.ColumnMappings.Add("CodUsuario", "CodUsuario");
                    objbulk.ColumnMappings.Add("Quantidade", "Quantidade");
                    objbulk.ColumnMappings.Add("Observacao", "Observacao");
                    objbulk.WriteToServer(dt);
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool RemoverItemCarrinho(int codProduto, string observacao, int codUsuario, int qtd)
        {
            qtd--;
            if(qtd <= 0)
                return RepUtil.ExecutaSQL("DELETE FROM ItemCarrinho WHERE CodProduto = @codProduto AND CodUsuario = @codUsuario AND Observacao = @observacao",
                                            new[] {
                                                new SqlParameter("@codProduto", codProduto),
                                                new SqlParameter("@codUsuario", codUsuario),
                                                new SqlParameter("@observacao", observacao)
                                            }) > 0;
            else
                return RepUtil.ExecutaSQL("UPDATE ItemCarrinho SET Quantidade = @quantidade WHERE CodProduto = @codProduto AND CodUsuario = @codUsuario AND Observacao = @observacao",
                                            new[] {
                                                new SqlParameter("@quantidade", qtd),
                                                new SqlParameter("@codProduto", codProduto),
                                                new SqlParameter("@codUsuario", codUsuario),
                                                new SqlParameter("@observacao", observacao),
                                            }) > 0;
        }
        public bool AdicionarItemCarrinho(int codUsuario, JsonItemCarrinho item, bool update)
        {
            if (update)
                return RepUtil.ExecutaSQL(@"UPDATE ItemCarrinho SET Quantidade = @quantidade
                                             WHERE CodProduto = @codProduto AND CodUsuario = @codUsuario AND Observacao = @observacao",
                                            new[] {
                                                new SqlParameter("@quantidade", item.qtd),
                                                new SqlParameter("@codProduto", item.cod),
                                                new SqlParameter("@codUsuario", codUsuario),
                                                new SqlParameter("@observacao", item.obs),
                                            }) > 0;
            else
                return RepUtil.ExecutaSQL($@"INSERT INTO ItemCarrinho (CodProduto, CodUsuario, Quantidade, Observacao)
                                            VALUES(@codProduto,@codUsuario,@quantidade,@observacao)",
                                            new[] {
                                                new SqlParameter("@codProduto", item.cod),
                                                new SqlParameter("@codUsuario", codUsuario),
                                                new SqlParameter("@quantidade", item.qtd),
                                                new SqlParameter("@observacao", item.obs),
                                            }) > 0;
        }
    }
}
