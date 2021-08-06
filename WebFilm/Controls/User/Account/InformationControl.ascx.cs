using System;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFilm_DAL;

namespace WebFilm.Controls.User.Account
{
    public partial class InformationControl : System.Web.UI.UserControl
    {
        private Regex regexEmpty = new Regex(@"^\s*$");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MultiView1.ActiveViewIndex = 0;
                LoadData();
            }
        }

        protected void LoadData()
        {
            if (Session["username"] == null)
            {
                ModalFailure.Message = "Vui lòng đăng nhập.";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "messageFailure", "showFailureModal();", true);
                return;
            }
            DataTable dtAccount = clsAccount.GetAccount(Session["username"].ToString());
            TxtUsername.Text = dtAccount.Rows[0]["Username"] == null ? "" : dtAccount.Rows[0]["Username"].ToString();
            TxtUsername.Enabled = false;
            TxtFullname.Text = dtAccount.Rows[0]["HoTen"] == null ? "" : dtAccount.Rows[0]["HoTen"].ToString();
            TxtEmail.Text = dtAccount.Rows[0]["Email"] == null ? "" : dtAccount.Rows[0]["Email"].ToString();
            TxtPhone.Text = dtAccount.Rows[0]["Username"] == null ? "" : dtAccount.Rows[0]["SDT"].ToString();
        }

        #region server validate

        protected void ValidEmail_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = true;
            Regex regexEmail = new Regex(@"^\w+([\.\-]\w+)*@([\w\-]+)((\.(\w){2,})+)$");

            if (!regexEmail.IsMatch(TxtEmail.Text) && !regexEmpty.IsMatch(TxtEmail.Text))
            {
                args.IsValid = false;
                ValidEmail.ErrorMessage = "Email không hợp lệ";
                return;
            }
        }

        protected void ValidPhone_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            args.IsValid = true;
            Regex regexPhone = new Regex(@"^0([0-9]){9}$");

            if (!regexPhone.IsMatch(TxtPhone.Text) && !regexEmpty.IsMatch(TxtPhone.Text))
            {
                args.IsValid = false;
                ValidPhone.ErrorMessage = "Số điện thoại không hợp lệ";
                return;
            }
        }

        protected void ValidPasswordCurrent_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = true;

            if (regexEmpty.IsMatch(TxtPasswordCurrent.Text))
            {
                args.IsValid = false;
                ValidPasswordCurrent.ErrorMessage = "Nhập mật khẩu hiện tại";
                return;
            }
        }

        protected void ValidPasswordNew_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = true;

            if (regexEmpty.IsMatch(TxtPasswordNew.Text))
            {
                args.IsValid = false;
                ValidPasswordNew.ErrorMessage = "Nhập mật khẩu mới";
                return;
            }
        }

        #endregion server validate

        #region event

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            if (clsAccount.UpdateInforByUser(TxtUsername.Text, TxtFullname.Text, TxtEmail.Text, TxtPhone.Text) > 0)
            {
                ModalSuccess.Message = "Cập nhật thông tin tài khoản thành công.";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "messageSuccess", "showSuccessModal();", true);
            }
            else
            {
                ModalFailure.Message = "Cập nhât thông tin tài khoản thất bại.";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "messageFailure", "showFailureModal();", true);
            }
        }

        protected void LnkBtnChangePassword_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;
        }

        protected void BtnChangePassword_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string username = TxtUsername.Text;
            if (clsAccount.Login(username, TxtPasswordCurrent.Text).Rows.Count > 0)
            {
                if (clsAccount.UpdatePassword(username, TxtPasswordNew.Text) > 0)
                {
                    ModalSuccess.Message = "Cập nhật mật khẩu thành công.";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "messageSuccess", "showSuccessModal();", true);
                }
                else
                {
                    ModalFailure.Message = "Cập nhât mật khẩu thất bại.";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "messageFailure", "showFailureModal();", true);
                }
            }
            else
            {
                ValidPasswordCurrent.IsValid = false;
                ValidPasswordCurrent.ErrorMessage = "Mật khẩu hiện tại không đúng";
            }
        }

        #endregion event
    }
}