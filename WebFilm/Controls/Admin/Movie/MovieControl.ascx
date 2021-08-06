﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MovieControl.ascx.cs" Inherits="WebFilm.Controls.Admin.Movie.MovieControl" %>
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
                        <th>ID</th>
                        <th>Tên phim EN</th>
                        <th>Tên phim VI</th>
                        <th>Danh mục</th>
                        <th>Quốc gia</th>
                        <th>Năm phát hành</th>
                        <th>Cập nhật lần cuối</th>
                        <th class="no-content">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptMovieList" runat="server" OnItemCommand="rptMovieList_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td><%#:Eval("ID") %></td>
                                <td><%#:Eval("TenPhim_en") %></td>
                                <td><%#:Eval("TenPhim_vi") %></td>
                                <td><%#:Eval("DanhMuc") %></td>
                                <td><%#:Eval("QuocGia") %></td>
                                <td><%#:Eval("NamPhatHanh") %></td>
                                <td><%#:Eval("TgianCapNhat") %></td>
                                <td>
                                    <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CommandArgument='<%#:Eval("ID") %>'><i class="fas fa-edit"></i></asp:LinkButton>
                                    <asp:LinkButton ID="btnNextToConfirm" runat="server" CommandName="Delete" CommandArgument='<%#:Eval("ID") %>'><i class="far fa-trash-alt"></i></asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
                <tfoot>
                    <tr>
                        <th>ID</th>
                        <th>Tên phim EN</th>
                        <th>Tên phim VI</th>
                        <th>Danh mục</th>
                        <th>Quốc gia</th>
                        <th>Năm phát hành</th>
                        <th>Cập nhật lần cuối</th>
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
                        Bạn có chắc chắn muốn xóa phim này?
                    </div>
                    <div class="modal-footer d-flex justify-content-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <asp:Button ID="Button2" runat="server" CssClass="btn btn-danger" Text="Xác nhận xoá" OnClientClick="disposeConfirmDeleteModal()" OnClick="btnConfirmDelete_Click" />
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
        <script src="../../../Content/summernote/summernote-lite.js"></script>
        <link href="../../../Content/summernote/summernote-lite.css" rel="stylesheet" />

        <asp:HiddenField ID="hdMovieID" runat="server" />
        <asp:HiddenField ID="hdIsUpdate" runat="server" />
        <div class="col-lg-12 layout-spacing  px-3">
            <div class="row">
                <div class="col-xl-12 col-md-12 col-sm-12 col-12">
                    <h3 style="font-size: 2rem; font-weight: 700;"><%=this.TitleForm %></h3>
                </div>
            </div>
            <div runat="server">
                <div class="form-floating mb-3 col-xl-12 col-md-12 col-sm-12 col-12 has-valid">
                    <asp:TextBox ID="txtTenPhimEn" runat="server" CssClass="form-control is-invalid"
                        placeholder="Tên phim EN *" />
                    <label for="<%=txtTenPhimEn.ClientID %>">Tên phim EN *</label>
                    <asp:CustomValidator ID="validTxtTenPhimEn" runat="server" ValidateEmptyText="true" ControlToValidate="txtTenPhimEn" Enabled="true" OnServerValidate="validTxtTenPhimEn_ServerValidate" ClientValidationFunction="validTxtTenPhimEn_ClientValidate" CssClass="invalid-tooltip" ValidationGroup="validGroupAdminMovie"></asp:CustomValidator>
                </div>
                <div class="form-floating mb-3 col-xl-12 col-md-12 col-sm-12 col-12 has-valid">
                    <asp:TextBox ID="txtTenPhimVi" runat="server" CssClass="form-control is-invalid"
                        placeholder="Tên phim VI *" />
                    <label for="<%=txtTenPhimVi.ClientID %>">Tên phim VI *</label>
                    <asp:CustomValidator ID="validTxtTenPhimVi" runat="server" ValidateEmptyText="true" ControlToValidate="txtTenPhimVi" Enabled="true" OnServerValidate="validTxtTenPhimVi_ServerValidate" ClientValidationFunction="validTxtTenPhimVi_ClientValidate" CssClass="invalid-tooltip" ValidationGroup="validGroupAdminMovie"></asp:CustomValidator>
                </div>
                <div class="row mb-3">
                    <div class="form-floating col-xl-3 col-md-3 col-sm-3 col-3 has-valid">
                        <asp:DropDownList ID="drpDanhMuc" runat="server" CssClass="form-select is-invalid" placeholder="Danh mục *">
                            <asp:ListItem Value="">-- Chọn Danh mục --</asp:ListItem>
                        </asp:DropDownList>
                        <label for="<%=drpDanhMuc.ClientID %>">Danh mục *</label>
                        <asp:CustomValidator ID="validDrpDanhMuc" runat="server" ValidateEmptyText="true" ControlToValidate="drpDanhMuc" Enabled="true" OnServerValidate="validDrpDanhMuc_ServerValidate" ClientValidationFunction="validDrpDanhMuc_ClientValidate" CssClass="invalid-tooltip" ValidationGroup="validGroupAdminMovie"></asp:CustomValidator>
                    </div>
                    <div class="form-floating col-xl-3 col-md-3 col-sm-3 col-3 has-valid">
                        <asp:DropDownList ID="drpQuocGia" runat="server" CssClass="form-select is-invalid" placeholder="Quốc gia *">
                            <asp:ListItem Value="">-- Chọn Quốc gia --</asp:ListItem>
                        </asp:DropDownList>
                        <label for="<%=drpQuocGia.ClientID %>">Quốc gia *</label>
                        <asp:CustomValidator ID="validDrpQuocGia" runat="server" ValidateEmptyText="true" ControlToValidate="drpQuocGia" Enabled="true" OnServerValidate="validDrpQuocGia_ServerValidate" ClientValidationFunction="validDrpQuocGia_ClientValidate" CssClass="invalid-tooltip" ValidationGroup="validGroupAdminMovie"></asp:CustomValidator>
                    </div>
                    <div class="form-floating col-xl-3 col-md-3 col-sm-3 col-3 has-valid">
                        <asp:DropDownList ID="drpNamPhatHanh" runat="server" CssClass="form-select is-invalid" placeholder="Năm phát hành *">
                            <asp:ListItem Value="">-- Chọn năm phát hành --</asp:ListItem>
                        </asp:DropDownList>
                        <label for="<%=drpNamPhatHanh.ClientID %>">Năm phát hành *</label>
                        <asp:CustomValidator ID="validDrpNamPhatHanh" runat="server" ValidateEmptyText="true" ControlToValidate="drpNamPhatHanh" Enabled="true" OnServerValidate="validDrpNamPhatHanh_ServerValidate" ClientValidationFunction="validDrpNamPhatHanh_ClientValidate" CssClass="invalid-tooltip" ValidationGroup="validGroupAdminMovie"></asp:CustomValidator>
                    </div>
                    <div class="form-floating col-xl-3 col-md-3 col-sm-3 col-3 has-valid">
                        <asp:TextBox ID="txtThoiLuong" runat="server" CssClass="form-control is-invalid" placeholder="Thời lượng *" />
                        <label for="<%=txtThoiLuong.ClientID %>">Thời lượng *</label>
                        <asp:CustomValidator ID="validTxtThoiLuong" runat="server" ValidateEmptyText="true" ControlToValidate="txtThoiLuong" Enabled="true" OnServerValidate="validTxtThoiLuong_ServerValidate" ClientValidationFunction="validTxtThoiLuong_ClientValidate" CssClass="invalid-tooltip" ValidationGroup="validGroupAdminMovie"></asp:CustomValidator>
                    </div>
                </div>
            </div>
            <div class="form-group mb-3 col-xl-12 col-md-12 col-sm-12 col-12 has-valid">
                <label for="<%=chkTheLoai.ClientID %>">Thể loại</label>
                <asp:CheckBoxList ID="chkTheLoai" runat="server" RepeatDirection="Vertical" CssClass="is-invalid checkbox__the-loai"></asp:CheckBoxList>
                <asp:CustomValidator ID="validChkTheLoai" runat="server" EnableClientScript="true" OnServerValidate="validChkTheLoai_ServerValidate" ClientValidationFunction="validChkTheLoai_ClientValidate" ErrorMessage="Vui lòng chọn ít nhất 1 thể loại phim" CssClass="invalid-feedback" ValidationGroup="validGroupAdminMovie"></asp:CustomValidator>
            </div>
            <div class="form-floating mb-3 col-xl-12 col-md-12 col-sm-12 col-12 has-valid">
                <asp:TextBox ID="txtUrlPhim" runat="server" CssClass="form-control is-invalid"
                    placeholder="Url phim *" />
                <label for="<%=txtUrlPhim.ClientID %>">Url phim *</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtUrlPhim" ErrorMessage="Url phim là bắt buộc" CssClass="invalid-tooltip" ValidationGroup="validGroupAdminMovie"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group mb-3 col-xl-12 col-md-12 col-sm-12 col-12 has-valid">
                <label for="<%=uploadHinh.ClientID %>">Hình ảnh</label>
                <asp:FileUpload ID="uploadHinh" runat="server" CssClass="form-control is-invalid"
                    placeholder="Hình ảnh" />
                <asp:CustomValidator ID="validUploadHinh" runat="server" ValidateEmptyText="true" ControlToValidate="uploadHinh" Enabled="true" OnServerValidate="validUploadHinh_ServerValidate" CssClass="invalid-feedback" ValidationGroup="validGroupAdminMovie"></asp:CustomValidator>
                <%if (hdIsUpdate.Value == "Update")
                    { %>
                <div class="col-xl-3 col-md-3 col-sm-3 col-3">
                    <img src="/Upload/Image/<%=this.UrlImage %>" alt="Hình ảnh phim" style="width: 100%; height: auto;" />
                </div>
                <%} %>
            </div>
            <div class="input-group mb-3 col-xl-12 col-md-12 col-sm-12 col-12 has-valid">
                <asp:TextBox ID="txtDaoDien" runat="server" CssClass="form-control is-invalid"
                    placeholder="Đạo diễn" aria-label="Đạo diễn" aria-describedby="<%#btnInsertDirector.ClientID%>" />
                <asp:Button ID="btnInsertDirector" runat="server" CssClass="btn btn-primary" Text="Thêm mới" Enabled="False" OnClick="btnInsertDirector_Click" UseSubmitBehavior="False" CausesValidation="False" />
                <asp:CustomValidator ID="validTxtDaoDien" runat="server" ValidateEmptyText="true" ControlToValidate="txtDaoDien" Enabled="true" OnServerValidate="validTxtDaoDien_ServerValidate" ClientValidationFunction="validTxtDaoDien_ClientValidate" CssClass="invalid-tooltip" ValidationGroup="validGroupAdminMovie"></asp:CustomValidator>
            </div>
            <div class="input-group mb-3 col-xl-12 col-md-12 col-sm-12 col-12 has-valid">
                <asp:TextBox ID="txtDienVien" runat="server" CssClass="form-control is-invalid"
                    placeholder="Diễn viên" aria-label="Diễn viên" aria-describedby="<%#btnInsertActor.ClientID %>" />
                <asp:Button ID="btnInsertActor" runat="server" CssClass="btn btn-primary" Text="Thêm mới" Enabled="False" OnClick="btnInsertActor_Click" UseSubmitBehavior="False" CausesValidation="False" />
                <asp:CustomValidator ID="validTxtDienVien" runat="server" ValidateEmptyText="true" ControlToValidate="txtDienVien" Enabled="true" OnServerValidate="validTxtDienVien_ServerValidate" ClientValidationFunction="validTxtDienVien_ClientValidate" CssClass="invalid-tooltip" ValidationGroup="validGroupAdminMovie"></asp:CustomValidator>
            </div>
            <div class="form-group mb-3 col-xl-12 col-md-12 col-sm-12 col-12">
                <label for="<%=txtEditorContent.ClientID %>">Nội dung phim</label>
                <asp:TextBox ID="txtEditorContent" runat="server" TextMode="MultiLine" CssClass="form-control" />
            </div>
            <div class="mt-3" runat="server">
                <asp:Button ID="Button1" runat="server" CssClass="btn btn-secondary mr-3" Text="Cancel" OnClientClick="JavaScript:window.history.back(1); return false;" />
                <asp:Button ID="btnInsert" runat="server" CssClass="btn btn-primary" Text="Cập nhật" OnClick="btnInsert_Click" ValidationGroup="validGroupAdminMovie" UseSubmitBehavior="False" />
            </div>
        </div>

        <script type="text/javascript">
            //Initial SummerNote
            $('#<%=txtEditorContent.ClientID%>').summernote({
                placeholder: 'Nội dung phim',
                height: 600,
                toolbar: [
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['font', ['strikethrough', 'superscript', 'subscript']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['insert', ['link', 'picture', 'video']],
                    ['height', ['height']]
                ]
            });

            $('#<%=txtEditorContent.ClientID%>').summernote('foreColor', 'white');

            function validDrpDanhMuc_ClientValidate(source, args) {
                args.IsValid = true;
                var value = document.getElementById('<%=drpDanhMuc.ClientID%>').value;
                if (value == '') {
                    args.IsValid = false;
                    source.innerHTML = "Chọn danh mục";
                    return;
                }
            }

            var strRegexEmpty = /^\s*$/gm;
            function validTxtTenPhimEn_ClientValidate(source, args) {
                args.IsValid = true;
                var value = document.getElementById('<%=txtTenPhimEn.ClientID%>').value;

                if (strRegexEmpty.test(value)) {
                    source.innerHTML = "Nhập tên phim (En)";
                    args.IsValid = false;
                    return;
                }
            }

            function validTxtTenPhimVi_ClientValidate(source, args) {
                args.IsValid = true;
                var value = document.getElementById('<%=txtTenPhimVi.ClientID%>').value;

                if (strRegexEmpty.test(value)) {
                    source.innerHTML = "Nhập tên phim (Vi)";
                    args.IsValid = false;
                    return;
                }
            }

            function validDrpQuocGia_ClientValidate(source, args) {
                args.IsValid = true;
                var value = document.getElementById('<%=drpQuocGia.ClientID%>').value;
                if (value == '') {
                    args.IsValid = false;
                    source.innerHTML = "Chọn quốc gia";
                    return;
                }
            }

            function validDrpNamPhatHanh_ClientValidate(source, args) {
                args.IsValid = true;
                var value = document.getElementById('<%=drpNamPhatHanh.ClientID%>').value;
                if (value == '') {
                    args.IsValid = false;
                    source.innerHTML = "Chọn năm phát hành";
                    return;
                }
            }

            function validTxtThoiLuong_ClientValidate(source, args) {
                args.IsValid = true;
                var value = document.getElementById('<%=txtThoiLuong.ClientID%>').value;

                if (strRegexEmpty.test(value)) {
                    source.innerHTML = "Nhập thời lượng phim";
                    args.IsValid = false;
                    return;
                }

                strRegex = /^\d+$/gm;
                if (!strRegex.test(value)) {
                    source.innerHTML = "Thời lượng phải là số nguyên";
                    args.IsValid = false;
                    return;
                }

                if (value < 0) {
                    source.innerHTML = "Thời lượng phải >=0";
                    args.IsValid = false;
                    return;
                }

            }

            function validChkTheLoai_ClientValidate(source, args) {
                var chkList = document.getElementById("<%= chkTheLoai.ClientID %>").getElementsByTagName("input");
                for (var i = 0; i < chkList.length; i++) {
                    if (chkList[i].checked) {
                        args.IsValid = true;
                        return;
                    }
                }
                args.IsValid = false;
            }

            $('#<%=chkTheLoai.ClientID%> label').addClass('form-check-label');
            $('#<%=chkTheLoai.ClientID%> input').addClass('form-check-input mr-3');

            function removeUnicode(str) {
                if (str === null || str === undefined) return str;
                str = str.toLowerCase();
                str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
                str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
                str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
                str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
                str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
                str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
                str = str.replace(/đ/g, "d");
                return str;
            }

            var strRegexFormatField = /^((\w+\s*;*)(\s*\w+)*)+$/gm;
            function validTxtDaoDien_ClientValidate(source, args) {
                args.IsValid = true;
                var value = document.getElementById('<%=txtDaoDien.ClientID%>').value;

                if (strRegexEmpty.test(value)) {
                    args.IsValid = false;
                    source.innerHTML = "Nhập tên đạo diễn";
                    return;
                }

                //if (!strRegexFormatField.test(removeUnicode(value))) {
                //    args.IsValid = false;
                //    source.innerHTML = "Vui lòng nhập theo dạng: đạo diễn 1; đạo diễn 2;...";
                //    return;
                //}
            }

            function validTxtDienVien_ClientValidate(source, args) {
                args.IsValid = true;
                var value = document.getElementById('<%=txtDienVien.ClientID%>').value;

                if (strRegexEmpty.test(value)) {
                    args.IsValid = false;
                    source.innerHTML = "Nhập tên diễn viên";
                    return;
                }

                //if (!strRegexFormatField.test(removeUnicode(value))) {
                //    args.IsValid = false;
                //    source.innerHTML = "Vui lòng nhập theo dạng: diễn viên 1; diễn viên 2;...";
                //    return;
                //}
            }
        </script>
    </asp:View>
</asp:MultiView>