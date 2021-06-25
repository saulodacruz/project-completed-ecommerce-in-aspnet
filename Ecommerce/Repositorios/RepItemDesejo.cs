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
    public class RepItemDesejo
    {
        public List<ItemDesejo> Obter(int codUsuario, bool incluirProduto)
        {
            var list = new List<ItemDesejo>();
            using (var dados = RepUtil.ExecuteReader(@"SELECT * FROM ItemDesejo id
                                                    JOIN Produto p ON id.CodProduto = p.CodProduto
                                                    WHERE CodUsuario = @codUsuario",
                                                    new[]{ new SqlParameter("@codUsuario", codUsuario) }))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados, incluirProduto));
            }
            return list;
        }
        public bool Cadastrar(ItemDesejo id)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"INSERT INTO ItemDesejo (CodProduto, CodUsuario) 
                                             VALUES (@codProduto, @codUsuario)",
                                             new[] {
                                                 new SqlParameter("@codProduto", id.CodProduto),
                                                 new SqlParameter("@codUsuario", id.CodUsuario)
                                             }) > 0;
            }
            catch
            {
                return false;
            }
        }
        public bool Remover(int codProduto, int codUsuario)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM ItemDesejo WHERE CodProduto = @codProduto AND CodUsuario = @codUsuario",
                                        new[] {
                                            new SqlParameter("@codProduto", codProduto),
                                            new SqlParameter("@codUsuario", codUsuario)
                                        }) > 0;
        }
        private ItemDesejo PopularObjeto(SqlDataReader sql, bool incluirProduto = false)
        {
            return new ItemDesejo
            {
                CodProduto = Convert.ToInt32(sql["CodProduto"]),
                CodUsuario = Convert.ToInt32(sql["CodUsuario"]),
                Produto = incluirProduto ? new RepProduto().PopularObjeto(sql) : null
            };
        }
        public bool AtualizarCarrinho(List<ItemDesejo> ics, int codUsuario)
        {
            try
            {
                using (SqlConnection cnn = new SqlConnection(RepUtil.ConnectionStrings))
                {
                    cnn.Open();
                    using (SqlCommand cmd = new SqlCommand($"DELETE FROM ItemDesejo WHERE CodUsuario = @codUsuario", cnn))
                    {
                        cmd.Parameters.Add(new SqlParameter("@codUsuario", codUsuario));
                        cmd.ExecuteNonQuery();
                    }

                    var dt = new DataTable();
                    dt.Columns.Add(new DataColumn("CodProduto", typeof(int)));
                    dt.Columns.Add(new DataColumn("CodUsuario", typeof(int)));

                    ics.ForEach(x =>
                    {
                        DataRow dr = dt.NewRow();
                        dr["CodProduto"] = x.CodProduto;
                        dr["CodUsuario"] = x.CodUsuario;
                        dt.Rows.Add(dr);
                    });
                    var objbulk = new SqlBulkCopy(cnn)
                    {
                        DestinationTableName = "ItemDesejo"
                    };
                    objbulk.ColumnMappings.Add("CodProduto", "CodProduto");
                    objbulk.ColumnMappings.Add("CodUsuario", "CodUsuario");
                    objbulk.WriteToServer(dt);
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool RemoverItemDesejo(int codProduto, int codUsuario)
        {
            return RepUtil.ExecutaSQL("DELETE FROM ItemDesejo WHERE CodProduto = @codProduto AND CodUsuario = @codUsuario",
                                        new[] {
                                            new SqlParameter("@codProduto", codProduto),
                                            new SqlParameter("@codUsuario", codUsuario),
                                        }) > 0;
        }

        public bool AdicionarItemDesejo(int codUsuario, int codProduto)
        {
                return RepUtil.ExecutaSQL($@"INSERT INTO ItemDesejo (CodProduto, CodUsuario)
                                            VALUES(@codProduto,@codUsuario)",
                                            new[] {
                                                new SqlParameter("@codProduto", codProduto),
                                                new SqlParameter("@codUsuario", codUsuario),
                                            }) > 0;
        }
    }
}
