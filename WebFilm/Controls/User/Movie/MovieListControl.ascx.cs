using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFilm_DAL;

namespace WebFilm.Controls.User.Movie
{
    public partial class MovieListControl : System.Web.UI.UserControl
    {
        private string title;
        private DataTable dataSource;

        public string Title { get => title; set => title = value; }
        public DataTable DataSource { get => dataSource; set => dataSource = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            FillDrpTheLoai();
            FillDrpQuocGia();
            FillDrpNam();

            if (!IsPostBack)
            {
                LoadData();
            }
        }

        #region initial data

        private void LoadData()
        {
            try
            {
                if (Session["drpTheLoai"] != null) //Filter by Category
                {
                    if (!Session["drpTheLoai"].Equals(""))
                    {
                        //SELECT ... WHERE ID IN (SELECT idPhim WHERE idTheLoai=DrpTheLoai.SelectedValue)
                        IEnumerable<DataRow> dtFilterMovieByCategory = clsMovie_Categories.GetMovies(int.Parse(Session["drpTheLoai"].ToString())).AsEnumerable();
                        dataSource = dataSource.AsEnumerable().Where(row => dtFilterMovieByCategory.Any(rowFilter => rowFilter.Field<int>("idPhim") == row.Field<int>("ID"))).CopyToDataTable();
                    }
                }
                if (Session["drpQuocGia"] != null) //Filter by Nation
                {
                    if (!Session["drpQuocGia"].ToString().Equals(""))
                    {
                        dataSource = dataSource.AsEnumerable().Where(row => row.Field<int>("QuocGia") == int.Parse(Session["drpQuocGia"].ToString())).CopyToDataTable();
                    }
                }
                if (Session["drpNam"] != null) //Filter by Year
                {
                    if (!Session["drpNam"].ToString().Equals(""))
                    {
                        dataSource = dataSource.AsEnumerable().Where(row => row.Field<int>("NamPhatHanh") == int.Parse(Session["drpNam"].ToString())).CopyToDataTable();
                    }
                }

                ListViewMovie.DataSource = dataSource;
                ListViewMovie.DataBind();
            }
            catch (Exception)
            {
                ListViewMovie.DataSource = new DataTable();
                ListViewMovie.DataBind();
                Title = "đang cập nhật dữ liệu";
            }
        }

        protected void FillDrpTheLoai()
        {
            if (!IsPostBack)
            {
                foreach (DataRow row in clsCategories.GetCategories().Select("ThuTu IS NOT NULL", "ThuTu"))
                    DrpTheLoai.Items.Add(new ListItem(row["TheLoai"].ToString(), row["ID"].ToString()));
                if (Session["drpTheLoai"] != null)
                {
                    DrpTheLoai.SelectedValue = Session["drpTheLoai"].ToString();
                }
            }
        }

        protected void FillDrpQuocGia()
        {
            if (!IsPostBack)
            {
                foreach (DataRow row in clsNation.GetNation().Select("ThuTu IS NOT NULL", "ThuTu"))
                    DrpQuocGia.Items.Add(new ListItem(row["QuocGia"].ToString(), row["ID"].ToString()));
                if (Session["drpQuocGia"] != null)
                {
                    DrpQuocGia.SelectedValue = Session["drpQuocGia"].ToString();
                }
            }
        }

        protected void FillDrpNam()
        {
            if (!IsPostBack)
            {
                for (int i = DateTime.Now.Year; i >= 1990; i--)
                    DrpNam.Items.Add(new ListItem(i + "", i + ""));
                if (Session["drpNam"] != null)
                {
                    DrpNam.SelectedValue = Session["drpNam"].ToString();
                }
            }
        }

        #endregion initial data

        #region event

        protected void DrpTheLoai_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["drpTheLoai"] = DrpTheLoai.SelectedValue;
            LoadData();
        }

        protected void DrpQuocGia_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["drpQuocGia"] = DrpQuocGia.SelectedValue;
            LoadData();
        }

        protected void DrpNam_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["drpNam"] = DrpNam.SelectedValue;
            LoadData();
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

        #endregion event
    }
}