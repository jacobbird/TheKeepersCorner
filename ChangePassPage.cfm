<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<cfparam name="URL.tempfile" default="" type="string">
<cfparam name="URL.emailaddress" default="" type="string">
<cfparam name="URL.action" default="" type="string">
<cfparam name="variables.msg" default="" type="string">

<cfquery name="warehouse" datasource="discountsoccer">
Select UserID
from customersinfo
where emailaddress = '#url.emailaddress#'
</cfquery>

<cfif URL.action eq "post"> 
<cfif Form.PasswordOne eq Form.PasswordTwo>
<cfquery name="update" datasource="discountsoccer">
Update customersinfo
Set Password='#Form.PasswordOne#'
Where UserID='#Form.UserID#'
</cfquery>
<cflocation url="http://www.discountsoccersupply.com/store.cfm">
<cffile action="delete" file="C:\websites\DiscountSoccer\ChangePassPage#url.emailAddress#.cfm" >
<cfelse>
<cfset msg = "Passwords did not match, Please try again!">
</cfif>
</cfif>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ChangeUserNamePage</title>
<link href="UniversalFormatter.css" rel="stylesheet" type="text/css" />
</head>

<body class="ArialStore" background="images/Area Fill/BG2.jpg"><center>
<table width="364" border="0" cellspacing="0" cellpadding="0" bgcolor="FFFFFF">
  <tr>
    <td width="21">&nbsp;</td>
    <td width="139">&nbsp;</td>
    <td width="17">&nbsp;</td>
    <td width="165">&nbsp;</td>
    <td width="22">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5" height="35" align="center" class="ArialStoreWhiteBold" >Please Change Your Password</td>
  </tr>
  <tr>
    <td height="10"></td>
    <td colspan="3"></td>
    <td></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="3"><cfoutput> #variables.msg# </cfoutput></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="10"></td>
    <td colspan="3"></td>
    <td></td>
  </tr>
  <cfform name="form1" id="form1" method="post" action="#url.tempfile#?action=post&emailaddress=#url.emailaddress#&tempfile=#url.tempfile#">
  <tr>
    <td>&nbsp;</td>
    <td align="right">User Name:</td>
    <td align="center">&nbsp;</td>
    <td align="left"><cfinput type="text" name="UserID" typeahead="no" readonly="true" value="#warehouse.userid#" showautosuggestloadingicon="true"></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="right">Password:</td>
    <td align="center">&nbsp;</td>
    <td align="left">
      <label>
      <cfinput type="Password" name="PasswordOne" id="PasswordOne">
      </label>    </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="right">Re-Type Your Password:</td>
    <td align="center">&nbsp;</td>
    <td align="left"><cfinput type="password" name="PasswordTwo" id="PasswordTwo"></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><cfinput type="Submit" name="Submit" value="Submit" id="Submit"></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><label></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr></cfform>
</table>
</body>
</html>
