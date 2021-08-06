using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFilm_DAL;

namespace WebFilm.Controls.User.Movie
{
    public partial class MovieListSwiperControl : System.Web.UI.UserControl
    {
        private string title;
        private string idTheLoai;

        public string Title { get => title; set => title = value; }
        public string IdTheLoai { get => idTheLoai; set => idTheLoai = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadData();
        }

        private void LoadData()
        {
            DataTable dt = clsMovie.GetTop10ByCategory(int.Parse(IdTheLoai));

            Repeater1.DataSource = dt;
            Repeater1.DataBind();
        }

        protected void ButtonBookmark_Click(object sender, EventArgs e)
        {
            LinkButton linkButton = (LinkButton)(sender);
            if (Session["bookmark"] == null)
            {
                DataTable dataTable = clsMovie.GetMovie(int.Parse(linkButton.CommandArgument));
                Session["bookmark"] = dataTable;
            }
            else
            {
                DataTable dataTable = (DataTable)Session["bookmark"];
                DataRow dataRow = clsMovie.GetMovie(int.Parse(linkButton.CommandArgument)).Rows[0];

                // Check if exist, remove it
                foreach (DataRow rowItem in dataTable.Rows)
                    if (DataRowComparer.Default.Equals(rowItem, dataRow))
                    {
                        dataTable.Rows.Remove(rowItem);
                        ((SiteMaster)Page.Master).NumberBookmark = ((DataTable)Session["bookmark"]).Rows.Count;
                        return;
                    }

                dataTable.ImportRow(dataRow);
                Session["bookmark"] = dataTable;
            }
            ((SiteMaster)Page.Master).NumberBookmark = ((DataTable)Session["bookmark"]).Rows.Count;
        }
    }
}