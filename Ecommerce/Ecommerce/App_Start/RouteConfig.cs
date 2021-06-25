using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Ecommerce
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapRoute(
              "Produto",
              "Produto/{nomeProduto}",
              new { controller = "Home", action = "Produto" }
            );
            routes.MapRoute(
              "Pedido",
              "Pedido/{codPedido}",
              new { controller = "Pedidos", action = "Pedido" }
            );
            routes.MapRoute(
             "Carrinho",
             "Carrinho",
             new { controller = "Pedidos", action = "Carrinho" }
            );
            routes.MapRoute(
            "Pagamento",
            "Pagamento/Pedido/{codPedido}",
            new { controller = "Pagamento", action = "Pagamento" }
            );
            routes.MapRoute(
            "Produtos",
            "Produtos/{categoria}",
            new { controller = "Produtos", action = "Categoria" }
            );
            routes.MapRoute(
            "ObterProdutosPorCategoria",
            "Produtos/ObterProdutosPorCategoria/{categoria}/{maisCaros}/{maisBaratos}",
            new { controller = "Produtos", action = "ObterProdutosPorCategoria" }
            );
            routes.MapRoute(
            "BuscarProduto",
            "Produtos/BuscarProduto/{texto}",
            new { controller = "Produtos", action = "BuscarProduto" }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
