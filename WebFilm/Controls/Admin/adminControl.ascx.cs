using System;

namespace WebFilm.Controls.Admin
{
    public partial class adminControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                switch (Request["dashboard"])
                {
                    case "tai-khoan":
                        MultiView1.ActiveViewIndex = 0;
                        Page.Title = "Quản trị Tài khoản - 123 Play";
                        break;

                    case "danh-muc":
                        MultiView1.ActiveViewIndex = 1;
                        Page.Title = "Quản trị Danh mục - 123 Play";
                        break;

                    case "phim":
                        MultiView1.ActiveViewIndex = 2;
                        Page.Title = "Quản trị Phim - 123 Play";
                        break;

                    case "the-loai":
                        MultiView1.ActiveViewIndex = 3;
                        Page.Title = "Quản trị Thể loại - 123 Play";
                        break;

                    case "quoc-gia":
                        MultiView1.ActiveViewIndex = 4;
                        Page.Title = "Quản trị Quốc gia - 123 Play";
                        break;

                    case "dao-dien":
                        MultiView1.ActiveViewIndex = 5;
                        Page.Title = "Quản trị Đạo diễn - 123 Play";
                        break;

                    case "dien-vien":
                        MultiView1.ActiveViewIndex = 6;
                        Page.Title = "Quản trị Diễn viên - 123 Play";
                        break;

                    default:
                        break;
                }
            }
        }
    }
}