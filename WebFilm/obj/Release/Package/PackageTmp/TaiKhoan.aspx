<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TaiKhoan.aspx.cs" Inherits="WebFilm.TaiKhoan" %>

<%@ Register Src="~/Controls/User/Account/InformationControl.ascx" TagPrefix="uc1" TagName="InformationControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plhHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="plhContent" runat="server">
    <uc1:informationcontrol runat="server" id="InformationControl" />
</asp:Content>