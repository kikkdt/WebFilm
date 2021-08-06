using System;
using System.Data;
using System.Web.UI;
using WebFilm_DAL;

namespace WebFilm
{
    public partial class QuocGia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MovieListControl.DataSource = clsMovie.GetMoviesList();

            if (!IsPostBack && Request["page"] == null)
            {
                if (Request["quoc-gia"] != null)
                {
                    try
                    {
                        int idQuocGia = int.Parse(Request["quoc-gia"].ToString());
                        DataRow[] dataRows = clsNation.GetNation().Select("ID=" + idQuocGia);
                        bool checkID = dataRows.Length > 0;
                        if (checkID)
                        {
                            Session["drpTheLoai"] = null;
                            Session["drpQuocGia"] = idQuocGia;
                            Session["drpNam"] = null;
                            Page.Title = "Phim " + dataRows[0]["QuocGia"];
                            MovieListControl.Title += "Phim " + dataRows[0]["QuocGia"];
                            return;
                        }
                    }
                    catch (FormatException)
                    {
                        ModalFailure.Message = "Quốc gia cần tìm không đúng.";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showFailureModal", "showFailureModal()", true);
                    }
                }
                ModalFailure.Message = "Không tìm thấy quốc gia cần tìm...";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showFailureModal", "showFailureModal()", true);
            }
        }
    }
}