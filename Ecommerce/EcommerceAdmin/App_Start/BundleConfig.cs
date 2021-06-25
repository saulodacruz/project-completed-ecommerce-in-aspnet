using System.Web;
using System.Web.Optimization;

namespace EcommerceAdmin
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css",
                      "~/Content/Fontes/font-awesome-4.7.0/css/font-awesome.min.css",
                      "~/Content/DataTable/datatables.min.css"
                      ));

            bundles.Add(new ScriptBundle("~/bundles/script").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/jquery.mask.min.js",
                        "~/Scripts/jquery.inputmask.min.js",
                        "~/Scripts/jquery.validate*",
                        "~/Scripts/bootstrap.js",
                        "~/Scripts/modernizr-*",
                        "~/Content/DataTable/datatables.min.js",
                        "~/Scripts/jquery.mask.js"));
        }
    }
}
