<html>
<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
<link href="UniversalFormatterTwo.css" rel="stylesheet" type="text/css">
<body background="images/Area Fill/BG2.jpg"><center>
<cfparam default="" name="form.eMailAddress" type="string">
<cfparam default="" name="variables.msg" type="string">
<cfparam default="" name="URL.action" type="string">

<cfquery name="geteMailAddress" datasource="discountsoccer">
	select eMailAddress
	from customersInfo
</cfquery>

<cfif url.action eq "eMailAddress">
	<cfset q = false>
		<cfloop query="geteMailAddress">
			<cfif form.eMailAddress eq geteMailAddress.eMailAddress>
				<cfset q = true>
    		</cfif>
		</cfloop>
	<cfif q eq true>
		<cflocation url="TemporaryFileCreator.cfm?action=makefile&emailaddress=#form.emailaddress#">
	<cfelse>
		<cfset msg = "The Email Address You Entered Does Not Match One In Our Database.">
	</cfif>
</cfif>
<table width="323" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="35" colspan="3" align="center" background="images/Area Fill/Plain-Blue-Fill.jpg" class="ArialStoreWhiteBold">Reliable Password Retrival </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="143">&nbsp;</td>
    <td width="12">&nbsp;</td>
    <td width="168"><cfoutput>#msg#</cfoutput></td>
  </tr><cfform name="form" method="post" action="https://secure.reliablecleanroomproducts.com/Forgotpass.cfm?action=emailAddress">
  <tr>
    <td align="right" class="formlabels">eMail Address:</td>
    <td>&nbsp;</td>
    <td><label><cfinput type="text" name="EmailAddress"></label></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td></td>
  </tr>
  <tr>
    <td height="50">&nbsp;</td>
    <td>&nbsp;</td>
    <td valign="top"><cfinput type="Submit" name="Submit" value="Submit"></td>
  </tr></cfform>
</table>
</body>
</html>