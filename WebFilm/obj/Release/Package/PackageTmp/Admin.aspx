<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebFilm.Admin" ValidateRequest="false" %>

<%@ Register Src="~/Controls/Admin/adminControl.ascx" TagPrefix="uc1" TagName="adminControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="plhContent" runat="server">
    <%if (Session["admin"] != null)
        {%>
    <uc1:admincontrol runat="server" id="adminControl" />
    <%}
        else { Response.Redirect("LoginAdmin.aspx"); } %>
</asp:Content>