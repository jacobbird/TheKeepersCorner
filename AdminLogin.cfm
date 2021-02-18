<!--Copyright 2008-2009 'Out Of Site Software' --->

<cfparam name="URL.originURL" default="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
	<cfparam name="FORM.userID" default="">
		<cfparam name="errMsg" default="">

<cfif isDefined("FORM.submit")>

	<cfquery name="qryLogin" datasource="discountsoccer">
		SELECT userID, Password
		FROM admin
		WHERE userID = '#form.userID#' AND Password = '#form.Password#' 
			</cfquery>

		<cfif qryLogin.recordCount EQ 1>
    		<cfcookie name="admin" value="admin" >
    			<cfcookie name="userSecurity" value="high">
    				<cflocation url="Admin.cfm">
    					<cfelse>
            				<cfset errMsg = "Incorrect login information: Please try again">
    							</cfif>    
									</cfif>

<html>
	<link href="UniversalFormatterTwo.css" rel="stylesheet" type="text/css">
		<style type="text/css">
			<!--
				.style4 {
					color: #FFFFFF;
						font-weight: bold;
							}
								-->
									</style>

	<body class="ArialStore">
		<center>

		<!-- This displays the url of the calling page-->

		<cfoutput>http://#CGI.HTTP_HOST##CGI.SCRIPT_NAME#
		<cfform action="AdminLogin.cfm" method="post" name="login">

			<table width="263" cellpadding="0" border="0" cellspacing="0">            
    			<tr>
    				<td height="30" colspan="3" align="center" class="ArialStoreWhite" bgcolor="##000000">
                    	<p class="style4">Administrator Login:</p></td>
    						</tr>
                            
    			<tr bgcolor="##FFFFFF">
    				<td width="20"></td>
        				<td width="200"><br><p><strong>User Name:</strong><br>
        					<cfinput type="text" name="userID" value="" typeahead="no" autosuggest="no" maxlength="25">
        						<br><strong>Password:</strong>
        							<br><cfinput type="password" name="Password" maxlength="25">
  					
                    <br><br><cfinput type="hidden" name="originURL" value="#URL.originURL#">
            			<cfinput type="submit" name="submit" value="submit"></p>
            				<br></td>
								<td width="14">&nbsp;</td>
									</tr>	
										</table>

							</cfform>
								#Variables.errMsg#
									</cfoutput>

										</body>
											</html>