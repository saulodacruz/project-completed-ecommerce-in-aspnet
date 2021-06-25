using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Wirecard.Models;

namespace Ecommerce.Models
{
    public class ViewModelPedido
    {
        public Pedido Pedido { get; set; }
        public OrderResponse PedidoWirecard { get; set; }
    }
}