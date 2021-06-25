using System.Web;
using System.Web.Optimization;

namespace Ecommerce
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new StyleBundle("~/bundles/css").Include(
                      "~/Content/Template/vendor/bootstrap/css/bootstrap.min.css",
                      "~/Content/Template/fonts/font-awesome-4.7.0/css/font-awesome.min.css",
                      "~/Content/Template/fonts/iconic/css/material-design-iconic-font.min.css",
                      "~/Content/Template/fonts/linearicons-v1.0.0/icon-font.min.css",
                      "~/Content/Template/vendor/animate/animate.css",
                      "~/Content/Template/vendor/css-hamburgers/hamburgers.min.css",
                      "~/Content/Template/vendor/animsition/css/animsition.min.css",
                      //"~/Content/Template/vendor/select2/select2.min.css",
                      //"~/Content/Template/vendor/daterangepicker/daterangepicker.css",
                      "~/Content/Template/vendor/slick/slick.css",
                      "~/Content/Template/vendor/MagnificPopup/magnific-popup.css",//
                      "~/Content/Template/vendor/perfect-scrollbar/perfect-scrollbar.css",
                      "~/Content/Template/css/util.min.css",
                      "~/Content/Template/css/main.min.css",
                      "~/Content/spinner.min.css"
                      ));

            bundles.Add(new ScriptBundle("~/bundles/script").Include(
                      "~/Content/Template/vendor/jquery/jquery-3.2.1.min.js",
                      "~/Content/Template/vendor/animsition/js/animsition.min.js",
                      "~/Content/Template/vendor/bootstrap/js/popper.min.js",
                      "~/Content/Template/vendor/bootstrap/js/bootstrap.min.js",
                      //"~/Content/Template/vendor/select2/select2.min.js",
                      //"~/Content/Template/vendor/daterangepicker/moment.min.js",
                      //"~/Content/Template/vendor/daterangepicker/daterangepicker.js",
                      "~/Content/Template/vendor/slick/slick.min.js",
                      "~/Content/Template/js/slick-custom.js",
                      "~/Content/Template/vendor/parallax100/parallax100.min.js",
                      "~/Content/Template/vendor/MagnificPopup/jquery.magnific-popup.min.js",//
                      "~/Content/Template/vendor/isotope/isotope.pkgd.min.js",
                      "~/Content/Template/vendor/sweetalert/sweetalert.min.js",
                      "~/Content/Template/vendor/perfect-scrollbar/perfect-scrollbar.min.js",
                      "~/Content/Template/js/main.min.js",
                      "~/Scripts/jquery.mask.min.js",
                      //"~/Scripts/jquery.inputmask.min.js",
                      "~/Content/Sidebar/js/main.min.js",
                      "~/Scripts/CarrinhoAndDesejo.min.js",
                      "~/Scripts/_Layout.min.js"
                      ));
        }
    }
}
