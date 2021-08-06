<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AccountControl.ascx.cs" Inherits="WebFilm.Controls.Admin.Account.AccountControl" %>
<%@ Register Src="~/Controls/Utilities/Modal/ModalSuccess.ascx" TagPrefix="uc1" TagName="ModalSuccess" %>
<%@ Register Src="~/Controls/Utilities/Modal/ModalFailure.ascx" TagPrefix="uc1" TagName="ModalFailure" %>

<uc1:ModalFailure runat="server" ID="ModalFailure" />
<uc1:ModalSuccess runat="server" ID="ModalSuccess" />
<asp:MultiView ID="MultiView1" runat="server">
    <asp:View ID="View1" runat="server">
        <div class="table-responsive table-container">
            <div class="d-flex align-items-center justify-content-between">
                <h3 style="font-size: 2rem; font-weight: 700;"><%=this.TitleForm %></h3>
                <asp:LinkButton ID="btnNextToInsert" runat="server" OnClick="btnNextToInsert_Click"><i class="fas fa-plus fa-2x"></i></asp:LinkButton>
            </div>

            <table
                id="datatable"
                class="table dt-table-hover"
                style="width: 100%">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Họ Tên</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Loại tài khoản</th>
                        <th class="no-content">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptAccountList" OnItemCommand="rptAccountList_ItemCommand" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%#:Eval("Username") %></td>
                                <td><%#:Eval("Password") %></td>
                                <td><%#:Eval("HoTen") %></td>
                                <td><%#:Eval("Email") %></td>
                                <td><%#:Eval("SDT") %></td>
                                <td><%#:Eval("LoaiTK").ToString()=="True"?"Quản trị viên":"Người dùng" %>
                                <td>
                                    <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CommandArgument='<%#:Eval("Username") %>'><i class="fas fa-edit"></i></asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%#:Eval("Username") %>'><i class="far fa-trash-alt"></i></asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
                <tfoot>
                    <tr>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Họ Tên</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Loại tài khoản</th>
                        <th></th>
                    </tr>
                </tfoot>
            </table>
        </div>

        <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
            <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
                <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
            </symbol>
        </svg>
        <div class="modal fade" id="confirmDeleteModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="confirm-delete-modal-label"
            aria-hidden="true">
            <div class="modal-dialog modal-fullscreen-md-down">
                <div class="modal-content">
                    <div class="modal-header">
                        <a href="#" class="btn-close" data-bs-dismiss="modal" aria-label="Close"><i
                            class="fas fa-times"></i></a>
                        <h5 class="modal-title">Xác nhận xóa</h5>
                    </div>
                    <div class="modal-body alert alert-danger" role="alert">
                        <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:">
                            <use xlink:href="#exclamation-triangle-fill" />
                        </svg>
                        Bạn có chắn chắn muốn xoá tài khoản này?
                    </div>
                    <div class="modal-footer d-flex justify-content-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <asp:Button ID="btnConfirmDelete" runat="server" CssClass="btn btn-danger" Text="Xác nhận xoá" OnClientClick="disposeConfirmDeleteModal()" OnClick="btnConfirmDelete_Click" />
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var confirmDeleteModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'), {});
            function showConfirmDeleteModal() {
                confirmDeleteModal.toggle();
            }

            function disposeConfirmDeleteModal() {
                confirmDeleteModal.dispose();
            }
        </script>
    </asp:View>

    <asp:View ID="View2" runat="server">
        <asp:HiddenField ID="hdUsername" runat="server" />
        <asp:HiddenField ID="hdIsUpdate" runat="server" />
        <div class="layout-spacing row justify-content-center">
            <h3 class="row justify-content-center" style="font-size: 2rem; font-weight: 700;"><%=this.TitleForm %></h3>
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
                    <asp:CustomValidator ID="ValidEmail" runat="server" ValidateEmptyText="true" ControlToValidate="TxtEmail" Enabled="true" OnServerValidate="ValidEmail_ServerValidate" ClientValidationFunction="validEmail_ClientValidate" ValidationGroup="validGroupAdminAccount" CssClass="invalid-tooltip"></asp:CustomValidator>
                </div>
                <div class="form-floating mb-3 has-invalid">
                    <asp:TextBox ID="TxtPhone" runat="server" TextMode="Phone" CssClass="form-control is-invalid" placeholder="Số điện thoại" />
                    <label for="<%=TxtPhone.ClientID %>">Số điện thoại</label>
                    <asp:CustomValidator ID="ValidPhone" runat="server" ValidateEmptyText="true" ControlToValidate="TxtPhone" Enabled="true" OnServerValidate="ValidPhone_ServerValidate" ClientValidationFunction="validPhone_ClientValidate" ValidationGroup="validGroupAdminAccount" CssClass="invalid-tooltip"></asp:CustomValidator>
                </div>
                <div class="form-floating mb-3 has-invalid">
                    <asp:TextBox ID="TxtPasswordNew" runat="server" TextMode="Password" CssClass="form-control is-invalid" placeholder="Mật khẩu mới *" />
                    <label for="<%=TxtPasswordNew.ClientID %>">Mật khẩu mới *</label>
                    <asp:CustomValidator ID="ValidPasswordNew" runat="server" ValidateEmptyText="true" ControlToValidate="TxtPasswordNew" Enabled="true" OnServerValidate="ValidPasswordNew_ServerValidate" ClientValidationFunction="validPasswordNew_ClientValidate" CssClass="invalid-tooltip" ValidationGroup="validGroupAdminChangePassword"></asp:CustomValidator>
                </div>
                <div class="form-floating mb-3 has-invalid">
                    <asp:TextBox ID="TxtRepassword" runat="server" TextMode="Password" CssClass="form-control is-invalid" placeholder="Nhập lại mật khẩu" />
                    <label for="<%=TxtRepassword.ClientID %>">Nhập lại mật khẩu</label>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="TxtPasswordNew" ControlToCompare="TxtRepassword" ErrorMessage="Mật khẩu không khớp" CssClass="invalid-tooltip" ValidationGroup="validGroupAdminChangePassword"></asp:CompareValidator>
                </div>
                <div class="d-flex align-item-center mb-3">
                    <label for="chkTypeAcc" style="margin-right: .5rem;">
                        Tài khoản Quản trị
                    </label>
                    <asp:CheckBox ID="chkTypeAcc" runat="server" />
                </div>
                <div class="mb-5 row justify-content-around" runat="server">
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-secondary col-xl-5 col-lg-5 col-md-5 col-sm-5 col-5" Text="Cancel" OnClientClick="JavaScript:window.history.back(1); return false;" />
                    <asp:Button ID="btnInsert" runat="server" CssClass="btn btn-primary col-xl-5 col-lg-5 col-md-5 col-sm-5 col-5" Text="Cập nhật" OnClick="btnInsert_Click" UseSubmitBehavior="False" ValidationGroup="validGroupAdminAccount" />
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