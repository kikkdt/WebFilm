<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="XemSau.aspx.cs" Inherits="WebFilm.XemSau" %>

<%@ Register Src="~/Controls/User/Movie/MovieListControl.ascx" TagPrefix="uc1" TagName="MovieListControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plhHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plhContent" runat="server">
    <uc1:MovieListControl runat="server" ID="MovieListControl" />
</asp:Content>