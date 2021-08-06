using System;
using System.Data;
using System.Web.UI;
using WebFilm_DAL;

namespace WebFilm
{
    public partial class TheLoai : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MovieListControl.DataSource = clsMovie.GetMoviesList();

            if (!IsPostBack && Request["page"] == null)
            {
                if (Request["the-loai"] != null)
                {
                    try
                    {
                        int idTheLoai = int.Parse(Request["the-loai"].ToString());
                        DataRow[] dataRows = clsCategories.GetCategories().Select("ID=" + idTheLoai);
                        bool checkID = dataRows.Length > 0;
                        if (checkID)
                        {
                            Session["drpTheLoai"] = idTheLoai;
                            Session["drpQuocGia"] = null;
                            Session["drpNam"] = null;
                            Page.Title = "Phim " + dataRows[0]["TheLoai"];
                            MovieListControl.Title += "Phim " + dataRows[0]["TheLoai"];
                            return;
                        }
                    }
                    catch (FormatException)
                    {
                        ModalFailure.Message = "Thể loại phim cần tìm không đúng.";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showFailureModal", "showFailureModal()", true);
                    }
                }
                ModalFailure.Message = "Không tìm thấy thể loại phim cần tìm...";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showFailureModal", "showFailureModal()", true);
            }
        }
    }
}