<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HomeControl.ascx.cs" Inherits="WebFilm.Controls.User.Home.HomeControl" %>
<%@ Register Src="~/Controls/User/Banner/BannerControl.ascx" TagPrefix="uc1" TagName="BannerControl" %>
<%@ Register Src="~/Controls/User/Movie/MovieListSwiperControl.ascx" TagPrefix="uc1" TagName="MovieListSwiperControl" %>

<uc1:BannerControl runat="server" ID="BannerControl" />
<asp:Repeater ID="Repeater1" runat="server">
    <ItemTemplate>
        <uc1:MovieListSwiperControl runat="server" ID="MovieListSwiperControl" IdTheLoai='<%#:Eval("ID") %>' Title='<%#:Eval("TheLoai") %>' />
    </ItemTemplate>
</asp:Repeater>
<script type="text/javascript">
    const swiper2 = new Swiper('.list-movie__container', {
        // Optional parameters
        loop: true,
        loopFillGroupWithBlank: true,
        // Default parameters
        slidesPerView: 2,
        spaceBetween: 20,
        // Responsive breakpoints
        breakpoints: {
            // when window width is >= 320px
            320: {
                slidesPerView: 3,
                slidesPerGroup: 3,
                spaceBetween: 30
            },
            // when window width is >= 480px
            480: {
                slidesPerView: 4,
                slidesPerGroup: 4,
                spaceBetween: 30
            },
            // when window width is >= 640px
            640: {
                slidesPerView: 5,
                slidesPerGroup: 5,
                spaceBetween: 30
            }
        },
        // Pagination
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        // Navigation arrows
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });
</script>