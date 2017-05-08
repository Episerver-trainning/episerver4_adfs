<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ReadSpeaker.ascx.cs" Inherits="development.Templates.Units.ReadSpeaker" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<script>
	document.write('<a href="javascript:void(0);" onclick="readPage();" title="<%=Translate("/templates/readspeaker/readmealttext")%>"><%=Translate("/templates/readspeaker/readme")%></a>');
</script>
<noscript>
	<a href="http://isi.phoneticom.com/cgi-bin/epirsone?customerid=77&type=<%=CurrentPage["AudioFormat"] == null ? "2" : CurrentPage["AudioFormat"].ToString()%>&lang=<%=CurrentPage["ReadspeakerLanguage"] == null ? CurrentPage.LanguageID.ToLower() : ((String)CurrentPage["ReadspeakerLanguage"]).ToLower()%>&url=<%=Server.UrlEncode(Request.Url.AbsoluteUri)%>" target="rs" accesskey="1" title="<%=Translate("/templates/readspeaker/readmealttext")%>"><%=Translate("/templates/readspeaker/readme")%></a>
</noscript>