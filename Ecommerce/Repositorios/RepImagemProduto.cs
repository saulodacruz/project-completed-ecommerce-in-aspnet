using Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepImagemProduto
    {
        public List<ImagemProduto> Obter()
        {
            return Listar("SELECT * FROM ImagemProduto");
        }
        public List<ImagemProduto> ObterPorProduto(int codProduto)
        {
            return Listar("SELECT * FROM ImagemProduto WHERE CodProduto = @codProduto",
                            new[] { new SqlParameter("@codProduto", codProduto)});
        }
        public ImagemProduto Obter(int codImagemProduto)
        {
            return Obter("SELECT * FROM ImagemProduto WHERE CodImagemProduto = @codImagemProduto",
                            new[] { new SqlParameter("@codImagemProduto", codImagemProduto) });
        }
        public ImagemProduto Cadastrar(ImagemProduto i)
        {
            try
            {
                using (var dados = RepUtil.ExecuteReader(@"INSERT INTO ImagemProduto(CodProduto,Url,Ordem,Miniatura)
                                                            VALUES(@codProduto,@url,@ordem,@miniatura)",
                                                            new[] {
                                                                new SqlParameter("@codProduto", i.CodProduto),
                                                                new SqlParameter("@url", i.Url ?? string.Empty),
                                                                new SqlParameter("@ordem", i.Ordem),
                                                                new SqlParameter("@miniatura", (i.Miniatura ? 1 : 0)),
                                                            }))
                {
                    while (dados.Read())
                        i.CodImagemProduto = Convert.ToInt32(dados["CodImagemProduto"]);

                    return i;
                }
            }
            catch
            {
                return null;
            }
        }
        public ImagemProduto Editar(ImagemProduto i)
        {
            try
            {
                return RepUtil.ExecutaSQL(@"UPDATE ImagemProduto SET 
                                          CodProduto = @codProduto,
                                          Url = @url,
                                          Ordem = @ordem,
                                          Miniatura = @miniatura
                                          WHERE CodImagemProduto = @codImagemProduto",
                                          new[] {
                                              new SqlParameter("@codProduto", i.CodProduto),
                                              new SqlParameter("@url", i.Url ?? string.Empty),
                                              new SqlParameter("@ordem", i.Ordem),
                                              new SqlParameter("@miniatura", i.Miniatura),
                                              new SqlParameter("@codImagemProduto", i.CodImagemProduto),
                                          }) > 0 ? i : null;
            }
            catch
            {
                return null;
            }
        }
        public bool Remover(int codImagemProduto)
        {
            return RepUtil.ExecutaSQL($"DELETE FROM ImagemProduto WHERE CodImagemProduto = @codImagemProduto",
                                        new[] { new SqlParameter("@codImagemProduto", codImagemProduto) }) > 0;
        }
        private ImagemProduto Obter(string command, SqlParameter[] parameters = null)
        {
            var item = new ImagemProduto();
            using (var dados = RepUtil.ExecuteReader(command))
            {
                while (dados.Read())
                    item = PopularObjeto(dados);
            }
            return item;
        }
        private List<ImagemProduto> Listar(string command, SqlParameter[] parameters = null)
        {
            var list = new List<ImagemProduto>();
            using (var dados = RepUtil.ExecuteReader(command))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados));
            }
            return list;
        }
        public ImagemProduto PopularObjeto(SqlDataReader sql)
        {
            return new ImagemProduto
            {
                CodImagemProduto = Convert.ToInt32(sql["CodImagemProduto"]),
                CodProduto = Convert.ToInt32(sql["CodProduto"]),
                Url = sql["CodProduto"].ToString(),
                Ordem = Convert.ToInt32(sql["Ordem"]),
                Miniatura = Convert.ToBoolean(sql["Miniatura"])
            };
        }
    }
}
