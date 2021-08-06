<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuocGia.aspx.cs" Inherits="WebFilm.QuocGia" %>

<%@ Register Src="~/Controls/User/Movie/MovieListControl.ascx" TagPrefix="uc1" TagName="MovieListControl" %>
<%@ Register Src="~/Controls/Utilities/Modal/ModalFailure.ascx" TagPrefix="uc1" TagName="ModalFailure" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plhHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plhContent" runat="server">
    <uc1:ModalFailure runat="server" ID="ModalFailure" IsBack="true" />
    <uc1:MovieListControl runat="server" ID="MovieListControl" />
</asp:Content>