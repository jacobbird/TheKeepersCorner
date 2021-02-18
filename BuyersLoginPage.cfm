<cfparam name="URL.originURL" default="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
<cfparam name="FORM.userID" default="">
<cfparam name="errMsg" default="">

<!--- Login text Copyright &copy; 2008 Clean, Simple, and Smart Web Design --->
<html>

<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
<body background="images/Area Fill/bACKGROUND-cENTER.jpg" ><center>

<cfif isDefined("FORM.submit")>

<cfquery name="qryLogin" datasource="discountsoccer">
SELECT FirstName, LastName, AccessType, userID, Password, Activated
FROM customersinfo
WHERE userID = '#form.userID#' AND Password = '#form.Password#' 
</cfquery>

			<cfif qryLogin.recordCount eq 1 and qryLogin.activated eq "yes" >
            <cfcookie name="fullname" value="#qryLogin.FirstName# #qryLogin.LastName#">
            <cfcookie name="UserID" value="#qryLogin.UserID#">
            <cfcookie name="AccessType" value="#qryLogin.AccessType#">
            <cflocation url="store.cfm">
            <cfelseif qryLogin.recordCount eq 1 and not qryLogin.activated eq "yes">
            <cfset errMsg = "Your account has not yet been activated! call for assistance">
			<cfelse>
            <cfset errMsg = "Incorrect login information: Please try again">
            </cfif>
   </cfif>
   
   		<cfform action="#CGI.script_name#" method="post" name="login">
            <table width="250" cellpadding="0" border="0" cellspacing="0">            
            <tr>
            <td height="30" colspan="3" align="center"  bgcolor="#006600" class="ArialStoreWhite">
            <b> A New Leaf Login Page:</b>            </td>
            </tr>
            <tr>
            <td width="20" bgcolor="#FFFFFF" class="ArialStore"><br>
              &nbsp;</td>
            
            <td width="200" bgcolor="#FFFFFF" class="ArialStore"><br>
              <strong>User Name:</strong><br>
              <cfinput autosuggest="false" typeahead="no" type="text" name="userID" value="#FORM.userID#" 
            maxlength="25">
<br>
<br>
<strong>Password:</strong><br>
<cfinput type="password" name="Password" maxlength="25">
<br>
<a href="ForgotPass.cfm">Forgot Login Information</a><br>
<br>
<cfinput type="hidden" name="originURL" value="#URL.originURL#">
<cfinput type="submit" name="submit" value="submit"><br><br></td>
            <td width="19" bgcolor="#FFFFFF" class="ArialStore">&nbsp;</td>
            </tr>
            </table>
            
  </cfform>
     <cfoutput>
     <span class="ArialStore">#Variables.errMsg#</span>
	</cfoutput></center>
 </body>
</html>