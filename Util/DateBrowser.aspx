<%@ Page language="c#" Codebehind="DateBrowser.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.DateBrowser" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title><%#Translate("/system/datebrowser/heading")%></title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta name="robots" content="noindex,nofollow">
		<link rel="stylesheet" type="text/css" href="styles/DateBrowser.css"/>
		<script type='text/javascript' src="javascript/datebrowser.js"></script>
		<script type='text/javascript'>
		<!--		
		var aMonth				= new Array();
		var aMonthName			= new Array('<%#TranslateForScript("/january")%>','<%#TranslateForScript("/february")%>','<%#TranslateForScript("/march")%>','<%#TranslateForScript("/april")%>','<%#TranslateForScript("/may")%>','<%#TranslateForScript("/june")%>','<%#TranslateForScript("/july")%>','<%#TranslateForScript("/august")%>','<%#TranslateForScript("/september")%>','<%#TranslateForScript("/october")%>','<%#TranslateForScript("/november")%>','<%#TranslateForScript("/december")%>');
		var CALENDAR			= new CDateConstants(1,2,3,4,5,6,7);
		var nSelectedIndex		= null;
		var nTodayIndex			= null;
		var oToday				= new CCalendarDate(<%#Current.Year%>,<%#Current.Month%>,<%#Current.Year%>,<%#Current.Month%>,<%#Current.Day%>,<%#Current.Hour%>,<%#Current.Minute%>);
		var sSelectMonthCaption = '<%#TranslateForScript("/system/datebrowser/selectmonthcaption")%>';
		var sSelectYearCaption	= '<%#TranslateForScript("/system/datebrowser/selectyearcaption")%>';

		var oCalendar			= new CCalendarDate(<%#Current.Year%>,<%#Current.Month%>,<%#Current.Year%>,<%#Current.Month%>,<%#Current.Day%>,<%#Current.Hour%>,<%#Current.Minute%>);		
		window.onload			= OnLoadHandler;
		var fNoTimeRow			= (('<%#Request.QueryString["notime"]%>').length>0);
		function OnLoadHandler()
		{
			document.body.onclick	= OnClickHandler;
			RenderView();
			LoadTimeSelector();
			if (fNoTimeRow) document.all.timerow.style.display='none';
		}

		//-->
		</script>		
	</HEAD>
	<BODY style="margin: 8px;">
		<form id="DateBrowser" method="post" runat="server">
			<center>
			<table class="ThreeDLayer" valign="middle">
				<tr><td><a href="javascript:void(0);" OnClick="StepMonth(1);return false;"><img border="0" src="Images/DateBrowser/RightArrow.gif" valign="middle" align="right"></a><a href="javascript:void(0);" OnClick="javascript:StepMonth(-1);return false;"><img src="Images/DateBrowser/LeftArrow.gif" valign="top" border="0" align="left"></a><div align="center" valign="top" id="MonthNavigator"></div></td></tr>
			</table>

			<table class="dateTable" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="WeekDay"><%#Translate("/monday").Substring(0,2)%></td>
				<td class="WeekDay"><%#Translate("/tuesday").Substring(0,2)%></td>
				<td class="WeekDay"><%#Translate("/wednesday").Substring(0,2)%></td>
				<td class="WeekDay"><%#Translate("/thursday").Substring(0,2)%></td>
				<td class="WeekDay"><%#Translate("/friday").Substring(0,2)%></td>
				<td class="WeekDay"><%#Translate("/saturday").Substring(0,2)%></td>
				<td class="WeekDay"><font color="red"><%#Translate("/sunday").Substring(0,2)%></font></td>
			</tr>
			<tr>
				<td OnClick="OnDateChanged(this)" class="date" id="date0"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date1"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date2"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date3"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date4"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date5"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date6"></td>
			</tr>
			<tr>
				<td OnClick="OnDateChanged(this)" class="date" id="date7"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date8"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date9"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date10"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date11"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date12"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date13"></td>
			</tr>
			<tr>
				<td OnClick="OnDateChanged(this)" class="date" id="date14"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date15"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date16"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date17"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date18"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date19"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date20"></td>
			</tr>
			<tr>
				<td OnClick="OnDateChanged(this)" class="date" id="date21"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date22"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date23"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date24"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date25"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date26"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date27"></td>
			</tr>
			<tr>
				<td OnClick="OnDateChanged(this)" class="date" id="date28"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date29"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date30"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date31"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date32"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date33"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date34"></td>
			</tr>
			<tr>
				<td OnClick="OnDateChanged(this)" class="date" id="date35"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date36"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date37"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date38"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date39"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date40"></td>
				<td OnClick="OnDateChanged(this)" class="date" id="date41"></td>
			</tr>

			</table>
			<table class="ThreeDLayer" valign="middle">
			<tr align="middle" id="timerow">
				<td><%#Translate("/system/datebrowser/time")%>:</td>
				<td>
					<select id="f_time" name="f_time">
					</select>
				</td>
			
			</tr>
			</table>
			<br>
			<input style="width: 60px;" type="button" value="<%#Translate("/button/ok")%>" OnClick="onOK()" id="button3" name="button3">
			<input style="width: 60px;" type="button" value="<%#Translate("/button/clear")%>" OnClick="onClear()" id="button2" name="button2">
			<input style="width: 60px;" type="button" value="<%#Translate("/button/cancel")%>" OnClick="onCancel()" id="button1" name="button1">

			</center>

			<span id="MonthMenu" class="ThreeDLayer" style="display:none;position:absolute;width:90px">
			</span>
			<span id="YearMenu" class="ThreeDLayer" style="display:none;position:absolute;width:60px;">
			</span>
		</form>
	</BODY>
</HTML>
