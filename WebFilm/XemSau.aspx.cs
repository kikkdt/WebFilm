using System;
using System.Data;
using System.Web.UI;

namespace WebFilm
{
    public partial class XemSau : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["bookmark"] == null)
                MovieListControl.DataSource = new DataTable();
            else
                MovieListControl.DataSource = (DataTable)Session["bookmark"];

            if (!IsPostBack)
            {
                Session["drpTheLoai"] = null;
                Session["drpQuocGia"] = null;
                Session["drpNam"] = null;
                Page.Title = "Xem sau";
                MovieListControl.Title += "Xem sau";
            }
        }
    }
}