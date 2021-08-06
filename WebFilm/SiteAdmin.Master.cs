using System;

namespace WebFilm
{
    public partial class SiteAdmin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LinkButtonSignout_Click(object sender, EventArgs e)
        {
            Session.Clear();
        }
    }
}