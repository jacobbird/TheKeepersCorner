<html>
<head>
<cfparam default="none" name="URL.Action" type="string">
<cfparam default="admin" name="URL.UserID" type="string">
<cfparam default="#URL.UserID#" name="Form.UserID" type="string">
<cfparam default="admin" name="Form.UserID" type="string">
<cfparam default="none" name="COOKIE.ACCESSTYPE" type="string">
<cfif structKeyExists(COOKIE, "UserID")>
<cfelse>
<cfparam name="originURL" default="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
<cfset originURL = "CurrentOrderPage.cfm">
<cflocation URL="EmployeeLogin.cfm?originURL=#variables.originURL#">
<cfabort>
</cfif>
<cfoutput>

<cfinvoke component="CustomerCareComponentTwo" method="getOrderInformationThree" returnvariable="getOrderHistoryRet">
<cfinvokeargument name="UserID" value="#Cookie.USERID#">
</cfinvoke>
</cfoutput>

<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#666666">
<cfoutput>
<table width="821" height="214" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td height="91" colspan="4" align="left" class="PageHeaders">&nbsp;<font color="##FFFFFF">Current Orders Page</font></td>
</tr>
<tr>
  <td width="194" height="19">&nbsp;</td>
  <td width="200">&nbsp;</td>
  <td width="155">&nbsp;</td>
  <td width="272">&nbsp;</td>
</tr>

<tr class="CustomerNumber" bgcolor="##666666" >
  <td height="25" colspan="4">&nbsp;Current Orders:</td>
</tr>
<tr>
  <td height="19">&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr bgcolor="EEEEEE">
  <td height="20">&nbsp; Order Number</td>
  <td>Order Report</td>
  <td>Shipped</td>
  <td>Date</td>
</tr>
<cfparam default="1" name="url.startRow" type="numeric">
<cfset startRow = url.startRow>
<cfset endRow = url.startRow + 10>
<cfset startRowNext = endRow + 1>
<cfset endRowNext = startRow - 10>
<cfoutput>
<cfloop query="getOrderHistoryRet" startrow="#startRow#" endrow="#endRow#">
<cfif startRow mod 2>
<cfset bgcolor = 555555>
<cfelse>
<cfset bgcolor = DDDDDD>
</cfif>
<tr bgcolor="#bgcolor#"><td valign="top">&nbsp; #OrderNumber#</td>
  <td valign="bottom"><cfform name="form"><cfinput type="button" name="report" onClick="window.open('receiptConfirmationpdf.cfm?UUID=#OrderNumber#', '_blank')" value="Order Report"></cfform></td>
  <td valign="top">Not Yet</td>
  <td valign="top">#Date#</td>
</tr>
</cfloop>
</cfoutput>
<tr class="formlabels">
  <td height="20">&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

</table>
</cfoutput>
</body>
</html>
