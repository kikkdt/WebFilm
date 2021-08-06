<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="XemPhim.aspx.cs" Inherits="WebFilm.XemPhim" %>

<%@ Register Src="~/Controls/User/Movie/MovieDetailControl.ascx" TagPrefix="uc1" TagName="MovieDetailControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plhHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plhContent" runat="server">
    <uc1:moviedetailcontrol runat="server" id="MovieDetailControl" />
</asp:Content>