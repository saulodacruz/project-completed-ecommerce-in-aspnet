using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EcommerceAdmin.Models
{
    public class ViewModelProduto
    {
        public Produto Produto { get; set; }
        public HttpPostedFileBase FileImagemA { get; set; }
        public HttpPostedFileBase FileImagemB { get; set; }
        public HttpPostedFileBase FileImagemC { get; set; }
        public HttpPostedFileBase FileImagemD { get; set; }
        public HttpPostedFileBase FileImagemASmall { get; set; }
        public HttpPostedFileBase FileImagemBSmall { get; set; }
    }
}