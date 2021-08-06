<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MovieListControl.ascx.cs" Inherits="WebFilm.Controls.User.Movie.MovieListControl" %>
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <div class="list-movie__container">
            <div class="filter row mb-3">
                <div class="col-md-4 col-12 mb-3">
                    <asp:DropDownList ID="DrpTheLoai" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="DrpTheLoai_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Text="Thể loại" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-4 col-12 mb-3">
                    <asp:DropDownList ID="DrpQuocGia" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="DrpQuocGia_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Text="Quốc Gia" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-4 col-12 mb-3">
                    <asp:DropDownList ID="DrpNam" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="DrpNam_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Text="Năm" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <h4 class="list-movie__title"><%=this.Title %></h4>
            <div class="list-movie__grid">
                <asp:ListView ID="ListViewMovie" runat="server">
                    <ItemTemplate>
                        <div class="movie-card" data-bs-toggle="tooltip" data-bs-html="true" data-bs-placement="right" title="<b><%#:Eval("TenPhim_vi") %></b><br /><%#:Eval("TenPhim_en") %>">
                            <div class="movie-card__img">
                                <a href="XemPhim?phim=<%#: Eval("ID") %>">
                                    <img href="" src="/Upload/Image/<%#:Eval("UrlHinh") %>"
                                        loading="lazy" />
                                    <i class="far fa-play-circle"></i>
                                </a>
                            </div>
                            <div class="movie-card__detail">
                                <a href="XemPhim?phim=<%#: Eval("ID") %>" class="moive-card__detail__title-vi"><%#:Eval("TenPhim_vi") %></a>
                                <a href="XemPhim?phim=<%#: Eval("ID") %>" class="moive-card__detail__title-en"><%#:Eval("TenPhim_en") %></a>
                                <div class="col-12 d-flex flex-row justify-content-between align-items-baseline">
                                    <div class="d-flex flex-row">
                                        <a class="viewed me-3" aria-label="Lượt xem" aria-hidden="true"><i class="fas fa-eye"></i><%#:Eval("LuotXem") %></a>
                                        <a class="viewed" aria-label="Lượt thích" aria-hidden="true"><i class="fas fa-heart"></i><%#:Eval("LuotThich") %></a>
                                    </div>
                                    <asp:LinkButton ID="ButtonBookmark" runat="server" aria-label="Xem sau" data-bs-toggle="tooltip" data-bs-html="true" title="Xem sau" CommandArgument='<%#: Eval("ID") %>' OnClick="ButtonBookmark_Click" CausesValidation="false"><i class="fas fa-bookmark"></i></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>

            <div class="page-nav">
                <asp:DataPager ID="DataPager1" QueryStringField="page" PageSize="15" PagedControlID="ListViewMovie" runat="server">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Link" RenderNonBreakingSpacesBetweenControls="true" ShowPreviousPageButton="true" ShowNextPageButton="false" PreviousPageText="&laquo;" ButtonCssClass="page-button" />
                        <asp:NumericPagerField ButtonType="Link" NumericButtonCssClass="page-button" NextPreviousButtonCssClass="page-button" CurrentPageLabelCssClass="current-button" />
                        <asp:NextPreviousPagerField ButtonType="Link" RenderNonBreakingSpacesBetweenControls="true" ShowNextPageButton="true" ShowPreviousPageButton="false" NextPageText="&raquo;" ButtonCssClass="page-button" />
                    </Fields>
                </asp:DataPager>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>