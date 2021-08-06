﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MovieListSwiperControl.ascx.cs" Inherits="WebFilm.Controls.User.Movie.MovieListSwiperControl" %>

<div class="list-movie__container swiper-container">
    <div class="d-flex flex-row justify-content-between">
        <h4 class="list-movie__title"><%=this.Title %></h4>
        <p><a href="TheLoai?the-loai=<%=this.IdTheLoai %>">Xem thêm</a></p>
    </div>

    <div class="swiper-wrapper">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <div class="swiper-slide movie-card" data-bs-toggle="tooltip" data-bs-html="true" data-bs-placement="right" title="<b><%#:Eval("TenPhim_vi") %></b><br /><%#:Eval("TenPhim_en") %>">
                    <div class="movie-card__img">
                        <a href="XemPhim?phim=<%#: Eval("ID") %>">
                            <img src="/Upload/Image/<%#:Eval("UrlHinh") %>"
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
        </asp:Repeater>
    </div>
    <!-- Add Pagination -->
    <div class="swiper-pagination"></div>
    <!-- Add Arrows -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
</div>