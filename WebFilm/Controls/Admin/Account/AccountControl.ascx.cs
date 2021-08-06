using System;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.UI;
using WebFilm_DAL;

namespace WebFilm.Controls.Admin.Account
{
    public partial class AccountControl : System.Web.UI.UserControl
    {
        private string titleForm;
        private Regex regexEmpty = new Regex(@"^\s*$");

        public string TitleForm { get => titleForm; set => titleForm = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MultiView1.ActiveViewIndex = 0;
                LoadData();
            }
        }

        #region initial data

        private void LoadData()
        {
            DataTable dt = clsAccount.GetAccount();
            rptAccountList.DataSource = clsAccount.GetAccount();
            rptAccountList.DataBind();
            if (dt.Rows.Count > 0)
                TitleForm = "Quản trị Tài khoản";
            else
                TitleForm = "Chưa có dữ liệu";
        }

        #endregion initial data

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

        protected void ValidPasswordNew_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
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

        protected void rptAccountList_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            switch (e.CommandName.ToString())
            {
                case "Update":
                    {
                        TitleForm = "Cập nhật Tài khoản";
                        MultiView1.ActiveViewIndex = 1;

                        DataTable dt = new DataTable();
                        dt = clsAccount.GetAccount(e.CommandArgument.ToString());

                        if (dt.Rows.Count > 0)
                        {
                            TxtFullname.Text = dt.Rows[0]["HoTen"].ToString();
                            TxtEmail.Text = dt.Rows[0]["Email"].ToString();
                            TxtPhone.Text = dt.Rows[0]["SDT"].ToString();
                            TxtUsername.Text = dt.Rows[0]["Username"].ToString();
                            TxtUsername.ReadOnly = true;

                            hdUsername.Value = e.CommandArgument.ToString();
                            hdIsUpdate.Value = "Update";
                        }
                    }
                    break;

                case "Delete":
                    {
                        hdUsername.Value = e.CommandArgument.ToString();
                        hdIsUpdate.Value = "Delete";

                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "confirmDeleteModal", "showConfirmDeleteModal()", true);
                    }
                    break;
            }
        }

        protected void btnNextToInsert_Click(object sender, EventArgs e)
        {
            TitleForm = "Thêm mới Tài khoản";
            MultiView1.ActiveViewIndex = 1;
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                bool typeAcc = chkTypeAcc.Checked ? true : false;

                if (hdIsUpdate.Value.Equals("Update")) //Update account
                {
                    int rowAffected = clsAccount.Update(TxtUsername.Text, TxtPasswordNew.Text, TxtFullname.Text, TxtEmail.Text, TxtPhone.Text, typeAcc);

                    if (rowAffected > 0)
                    {
                        ModalSuccess.Message = "Cập nhật tài khoản thành công";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "messageSuccess", " showSuccessModal();", true);
                    }
                    else
                    {
                        ModalFailure.Message = "Cập nhật tài khoản thất bại";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "messageFailure", " showFailureModal();", true);
                    }
                }
                else //Insert account
                {
                    int rowAffected = clsAccount.Register(TxtUsername.Text, TxtPasswordNew.Text, TxtFullname.Text, TxtEmail.Text, TxtPhone.Text, typeAcc);

                    if (rowAffected > 0)
                    {
                        ModalSuccess.Message = "Thêm mới tài khoản thành công";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "messageSuccess", " showSuccessModal();", true);
                    }
                    else
                    {
                        ModalFailure.Message = "Thêm mới tài khoản thất bại";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "messageFailure", " showFailureModal();", true);
                    }
                }
            }
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            int res = clsAccount.Delete(hdUsername.Value);

            if (res > 0)
            {
                ModalSuccess.Message = "Xóa tài khoản thành công";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "messageSuccess", " showSuccessModal();", true);
            }
            else
            {
                ModalFailure.Message = "Xóa tài khoản thất bại";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "messageFailure", " showFailureModal();", true);
            }
        }

        #endregion event
    }
}