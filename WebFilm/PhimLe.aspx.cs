using System;
using WebFilm_DAL;

namespace WebFilm
{
    public partial class PhimLe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MovieListControl.DataSource = clsMovie.GetMoviesByCatalogue(2);
            if (!IsPostBack && Request["page"] == null)
            {
                Session["drpTheLoai"] = null;
                Session["drpQuocGia"] = null;
                Session["drpNam"] = null;
                Page.Title = "Phim Lẻ";
                MovieListControl.Title += "Phim Lẻ";
            }
        }
    }
}