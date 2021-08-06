using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebFilm
{
    public partial class YeuThich : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "showLoginModal", "showLoginModal()", true);
                return;
            }

            if (!IsPostBack && Request["page"] == null)
            {
                Session["drpTheLoai"] = null;
                Session["drpQuocGia"] = null;
                Session["drpNam"] = null;

                Page.Title = "Phim Yêu thích";

                SqlConnection conn = null;
                DataSet ds = new DataSet();
                try
                {
                    conn = new SqlConnection
                    {
                        ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString
                    };
                    conn.Open();

                    SqlCommand sqlCommand = new SqlCommand(" SELECT * FROM uf_GetMovieLiked(@Username)", conn) { CommandType = CommandType.Text };

                    sqlCommand.Parameters.AddWithValue("@Username", Session["username"].ToString());

                    SqlDataAdapter sda = new SqlDataAdapter(sqlCommand);
                    sda.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        MovieListControl.DataSource = ds.Tables[0];
                        MovieListControl.Title = "Phim Yêu thích";
                    }
                    else
                    {
                        MovieListControl.DataSource = new DataTable();
                        MovieListControl.Title = "Không tìm thấy dữ liệu...";
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    if (conn != null)
                        conn.Close();
                }
            }
        }
    }
}