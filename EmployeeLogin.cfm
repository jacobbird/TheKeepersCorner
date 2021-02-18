<cfparam name="FORM.userID" default="">
<cfparam name="errMsg" default="">

<!--- Login text Coptright &copy; 2008 Clean, Simple, and Smart Web Design --->
<html>
<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
<body background="images/Area Fill/bACKGROUND-cENTER.jpg" class="ArialStore"><center>


<cfif isDefined("FORM.submit")>

<cfquery name="qryLogin" datasource="discountsoccer">
	SELECT userID, Password, AccessType
	FROM employeeinformation
	WHERE userID = '#form.userID#' AND Password = '#form.Password#' 
</cfquery>
			
		<cfif qryLogin.recordCount EQ 1>
            <cfcookie name="UserID" value="#qryLogin.UserID#">
            <cfcookie name="AccessType" value="#qryLogin.AccessType#">
            <cflocation url="#URL.OriginURL#">
        <cfelse>
            <cfset errMsg = "Incorrect login information: Please try again">
        </cfif>
   </cfif>
   <cfoutput>#URL.originurl#</cfoutput>
   
   	<cfform action="#CGI.script_name#?OriginURL=#URL.OriginURL#"  method="post" name="login">
            <table width="263" cellpadding="0" border="0"  cellspacing="0">            
            <tr>
            <td height="30" colspan="3" align="center" background="images/Area Fill/Plain-Blue-Fill.jpg" class="ArialStoreWhite">
              <p><b>Reliable Employee Login:</b> </p>              </td>
            </tr>
            <tr>
            <td width="22" align="left" class="ArialStore" bgcolor="#FFFFFF"><p><br>
            </p>              </td>
            <td width="218" align="left" class="ArialStore" bgcolor="#FFFFFF"><br>
              <p><strong>User Name: </strong><br>
                  <cfinput type="text" name="userID" autosuggest="no" typeahead="no" value="" maxlength="25">
                  <br>
                  <strong><br>
                    Password:</strong><br>
  				  <cfinput type="password" name="Password" maxlength="25">
              </p>
              <p><br>
                  <cfinput type="hidden" name="originURL" value="#URL.originURL#">
                  <cfinput type="submit" name="submit" value="submit">
              </p><br></td>
            <td width="23" align="left" class="ArialStore" bgcolor="#FFFFFF">&nbsp;</td>
            </tr>
            </table>
            
			</cfform>
     	<cfoutput>#Variables.errMsg#
	</cfoutput>
 </body>
</html>
            
            


