using System;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFilm
{
    public partial class SiteMaster : MasterPage
    {
        private int numberBookmark;

        public int NumberBookmark { get => numberBookmark; set => numberBookmark = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["bookmark"] != null)
                numberBookmark = ((DataTable)Session["bookmark"]).Rows.Count;
        }

        protected void LinkButtonSignout_Click(object sender, EventArgs e)
        {
            Session.Clear();
        }

        protected void LinkButtonSearch_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);

            if (btn.CommandArgument.Equals("desktop"))
            {
                if (new Regex(@"^\s*$").IsMatch(TxtSearch.Text)) return;
                Session["search"] = TxtSearch.Text;
            }
            else
            {
                if (new Regex(@"^\s*$").IsMatch(TxtSearchMobile.Text)) return;
                Session["search"] = TxtSearchMobile.Text;
            }
            Response.Redirect("TimKiem.aspx");
        }
    }
}