<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InformationControl.ascx.cs" Inherits="WebFilm.Controls.User.Account.InformationControl" %>
<%@ Register Src="~/Controls/Utilities/Modal/ModalFailure.ascx" TagPrefix="uc1" TagName="ModalFailure" %>
<%@ Register Src="~/Controls/Utilities/Modal/ModalSuccess.ascx" TagPrefix="uc1" TagName="ModalSuccess" %>

<uc1:ModalFailure runat="server" ID="ModalFailure" />
<uc1:ModalSuccess runat="server" ID="ModalSuccess" />
<asp:MultiView ID="MultiView1" runat="server">
    <asp:View ID="View1" runat="server">
        <div class="layout-spacing row justify-content-center">
            <h3 class="row justify-content-center" style="font-size: 2rem; font-weight: 700;">Thông tin tài khoản</h3>
            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
                <div class="form-floating mb-3 has-invalid">
                    <asp:TextBox ID="TxtUsername" runat="server" CssClass="form-control is-invalid"
                        placeholder="Tên đăng nhập *" />
                    <label for="TxtUsername">Tên đăng nhập *</label>
                </div>
                <div class="form-floating mb-3">
                    <asp:TextBox ID="TxtFullname" runat="server" CssClass="form-control"
                        placeholder="Họ và Tên" />
                    <label for="TxtFullname">Họ và Tên</label>
                </div>
                <div class="form-floating mb-3 has-invalid">
                    <asp:TextBox ID="TxtEmail" runat="server" CssClass="form-control is-invalid" placeholder="Email" />
                    <label for="<%=TxtEmail.ClientID %>">Email</label>
                    <asp:CustomValidator ID="ValidEmail" runat="server" ValidateEmptyText="true" ControlToValidate="TxtEmail" Enabled="true" OnServerValidate="ValidEmail_ServerValidate" ClientValidationFunction="validEmail_ClientValidate" ValidationGroup="validGroupInfor" CssClass="invalid-tooltip"></asp:CustomValidator>
                </div>
                <div class="form-floating mb-3 has-invalid">
                    <asp:TextBox ID="TxtPhone" runat="server" TextMode="Phone" CssClass="form-control is-invalid" placeholder="Số điện thoại" />
                    <label for="<%=TxtPhone.ClientID %>">Số điện thoại</label>
                    <asp:CustomValidator ID="ValidPhone" runat="server" ValidateEmptyText="true" ControlToValidate="TxtPhone" Enabled="true" OnServerValidate="ValidPhone_ServerValidate" ClientValidationFunction="validPhone_ClientValidate" ValidationGroup="validGroupInfor" CssClass="invalid-tooltip"></asp:CustomValidator>
                </div>
                <div class="mb-3">
                    <asp:LinkButton ID="LnkBtnChangePassword" runat="server" OnClick="LnkBtnChangePassword_Click">Thay đổi mật khẩu?</asp:LinkButton>
                </div>
                <div class="mb-5 row justify-content-around" runat="server">
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-secondary col-xl-5 col-lg-5 col-md-5 col-sm-5 col-5" Text="Cancel" OnClientClick="JavaScript:window.history.back(1); return false;" />
                    <asp:Button ID="btnInsert" runat="server" CssClass="btn btn-primary col-xl-5 col-lg-5 col-md-5 col-sm-5 col-5" Text="Cập nhật" OnClick="btnInsert_Click" UseSubmitBehavior="False" ValidationGroup="validGroupInfor" />
                </div>
            </div>
        </div>

        <script type="text/javascript">

            var strRegexEmpty = /^\s*$/gm;

            function validEmail_ClientValidate(source, args) {
                var value = document.getElementById('<%=TxtEmail.ClientID%>').value;
                var strRegexEmail = /^\w+([\.\-]\w+)*@([\w\-]+)((\.(\w){2,})+)$/gm;

                if (!strRegexEmail.test(value) && !strRegexEmpty.test(value)) {
                    source.innerHTML = "Email không hợp lệ";
                    args.IsValid = false;
                    return;
                }
            }

            function validPhone_ClientValidate(source, args) {
                var value = document.getElementById('<%=TxtPhone.ClientID%>').value;
                var strRegexPhone = /^0([0-9]){9}$/gm;

                if (!strRegexPhone.test(value) && !strRegexEmpty.test(value)) {
                    source.innerHTML = "Số điện thoại không hợp lệ";
                    args.IsValid = false;
                    return;
                }
            }
        </script>
    </asp:View>
    <asp:View ID="View2" runat="server">
        <div class="layout-spacing row justify-content-center">
            <h3 class="row justify-content-center" style="font-size: 2rem; font-weight: 700;">Thay đổi mật khẩu</h3>
            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
                <div class="form-floating mb-3 has-invalid">
                    <asp:TextBox ID="TxtPasswordCurrent" runat="server" TextMode="Password" CssClass="form-control is-invalid" placeholder="Mật khẩu hiện tại *" />
                    <label for="<%=TxtPasswordCurrent.ClientID %>">Mật khẩu hiện tại *</label>
                    <asp:CustomValidator ID="ValidPasswordCurrent" runat="server" ValidateEmptyText="true" ControlToValidate="TxtPasswordCurrent" Enabled="true" OnServerValidate="ValidPasswordCurrent_ServerValidate" ClientValidationFunction="validPasswordCurrent_ClientValidate" CssClass="invalid-tooltip" ValidationGroup="validGroupChangePassword"></asp:CustomValidator>
                </div>
                <div class="form-floating mb-3 has-invalid">
                    <asp:TextBox ID="TxtPasswordNew" runat="server" TextMode="Password" CssClass="form-control is-invalid" placeholder="Mật khẩu mới *" />
                    <label for="<%=TxtPasswordNew.ClientID %>">Mật khẩu mới *</label>
                    <asp:CustomValidator ID="ValidPasswordNew" runat="server" ValidateEmptyText="true" ControlToValidate="TxtPasswordNew" Enabled="true" OnServerValidate="ValidPasswordNew_ServerValidate" ClientValidationFunction="validPasswordNew_ClientValidate" CssClass="invalid-tooltip" ValidationGroup="validGroupChangePassword"></asp:CustomValidator>
                </div>
                <div class="form-floating mb-3 has-invalid">
                    <asp:TextBox ID="TxtRepassword" runat="server" TextMode="Password" CssClass="form-control is-invalid" placeholder="Nhập lại mật khẩu" />
                    <label for="<%=TxtRepassword.ClientID %>">Nhập lại mật khẩu</label>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="TxtPasswordNew" ControlToCompare="TxtRepassword" ErrorMessage="Mật khẩu không khớp" CssClass="invalid-tooltip" ValidationGroup="validGroupChangePassword"></asp:CompareValidator>
                </div>
                <div class="mb-5 row justify-content-around" runat="server">
                    <asp:Button ID="Button2" runat="server" CssClass="btn btn-secondary col-xl-5 col-lg-5 col-md-5 col-sm-5 col-5" Text="Cancel" OnClientClick="JavaScript:window.history.back(1); return false;" />
                    <asp:Button ID="BtnChangePassword" runat="server" CssClass="btn btn-primary col-xl-5 col-lg-5 col-md-5 col-sm-5 col-5" Text="Cập nhật" OnClick="BtnChangePassword_Click" ValidationGroup="validGroupChangePassword" />
                </div>
            </div>
        </div>

        <script type="text/javascript">

            var strRegexEmpty = /^\s*$/gm;

            function validPasswordCurrent_ClientValidate(source, args) {
                var value = document.getElementById('<%=TxtPasswordCurrent.ClientID%>').value;

                if (strRegexEmpty.test(value)) {
                    source.innerHTML = "Nhập mật khẩu hiện tại";
                    args.IsValid = false;
                    return;
                }
            }

            function validPasswordNew_ClientValidate(source, args) {
                var value = document.getElementById('<%=TxtPasswordNew.ClientID%>').value;

                if (strRegexEmpty.test(value)) {
                    source.innerHTML = "Nhập mật khẩu mới";
                    args.IsValid = false;
                    return;
                }
            }
        </script>
    </asp:View>
</asp:MultiView>