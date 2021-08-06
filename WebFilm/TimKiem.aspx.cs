using System;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.UI;
using WebFilm_DAL;

namespace WebFilm
{
    public partial class TimKiem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request["page"] == null)
            {
                Session["drpTheLoai"] = null;
                Session["drpQuocGia"] = null;
                Session["drpNam"] = null;
            }

            if (Session["search"] == null)
                MovieListControl.Title = "Nhập từ khóa tìm kiếm";

            Page.Title = "Tìm kiếm";
            string strSearch = Session["search"].ToString();
            Regex regexSearch = new Regex(@"^.*" + strSearch + ".*$", RegexOptions.IgnoreCase);
            try
            {
                DataTable dtSearch = clsMovie.GetMoviesList().AsEnumerable().Where(movie => regexSearch.IsMatch(movie.Field<string>("TenPhim_en")) || regexSearch.IsMatch(movie.Field<string>("TenPhim_vi"))).CopyToDataTable();

                if (dtSearch.Rows.Count > 0)
                {
                    MovieListControl.DataSource = dtSearch;
                    MovieListControl.Title = "Tìm kiếm với từ khóa: " + strSearch;
                }
                else
                {
                    MovieListControl.DataSource = new DataTable();
                    MovieListControl.Title = "Không tìm thấy dữ liệu...";
                }
            }
            catch (Exception)
            {
                MovieListControl.DataSource = new DataTable();
                MovieListControl.Title = "Không tìm thấy dữ liệu...";
            }
        }
    }
}