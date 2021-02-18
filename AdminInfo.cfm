<!-- Copywrite 2008-2009 'Out Of Site Software' -->

<!-- This page allows the user to change the administrators' password. This password is important because 
it controlls access to the admin areas of the site. the admin area of the site is the only place where 
credit card numbers can be aquired along side of the order history. The admin password has a backup which 
is call the master pass. The master pass word is stored in the database as a backup entery system. This page 
is only accessable from the admin page. -->

<!-- Here is the page security section of the page. Here the allowed or disallowed access to the page. -->

<cfif structKeyExists(COOKIE, "admin")>
	<cfelse>
		<cfparam name="originURL" default="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
			<cflocation URL="AdminLogin.cfm?originURL=#urlEncodedFormat(originURL)#">
				<cfabort>
					</cfif>

<!-- The only parameter sets a blank message "URL.state". -->

	<cfparam name="URL.state" default="" type="string">

	<cfif url.action eq "submit">
    	<cfquery name="getquery" datasource="discountsoccer">
			SELECT userID
			FROM employeeinformation
				</cfquery>

		<cfif #FORM.UserID# eq #getquery.userID#>
			<cflocation url="CreateNewUser.cfm?state=User Name already in use! Please choose a different User Name!">
				<cfelseif #FORM.password# eq #FORM.password2#>
					<cfquery name="inquery" datasource="discountsoccer">
						UPDATE admin
						SET Password='#FORM.Password#', UserID='#FORM.UserID#'
						WHERE Number = 1
							</cfquery>
                            	<cflocation url="Admin.cfm">
								<cfelse>
									<cflocation url="AdminInfo.cfm?state='Passwords did not match! Please try again.'">
										</cfif>
											</cfif>


<html>
	<body>
		<center>

<!--this form suttles its data to a new page called newadmin.cfm-->
		
	<cfform name="form1" id="form1" method="post" action="AdminInfo.cfm?action=submit">
		<table width="518" border="0" cellpadding="4">
  			<tr>
    			<td colspan="2" align="Center"><p>Administrator Information:</p>
    				
                    <p><strong>Important:</strong> Admin Password provides access to restricted pages and could allow unauthorized access to administration pages.</p>
                    		</td>
  								</tr>
  
  			<tr>
    			<td height="35" align="right">&nbsp;</td>
    				<td>&nbsp;</td>
  						</tr>
  
  			<tr>
    			<td width="150" height="35" align="right">UserName:</td>
    				<td width="346">
      					<cfinput type="text" name="UserID" id="UserID" value="" required="yes">    
                              </td>
  									</tr>
  			
            <tr>
    			<td align="right">Password:</td>
    				<td>
      					<cfinput type="password" name="Password" id="Password" maxlength="12" required="yes">
         					</td>
  								</tr>
  
  			<tr>
    			<td align="right">re-type Password:</td>
    				<td>
      			    	<cfinput type="password" name="Password2" id="Password2" maxlength="12" required="yes">
         					</td>
  								</tr>
  
  			<tr>
    			<td align="right">&nbsp;</td>
    				<td></td>
  						</tr>
  			
            <tr>
    			<td>&nbsp;</td>
    				<td>&nbsp;</td>
  						</tr>
  
  			<tr>
    			<td>&nbsp;</td>
    				<td><cfinput type="submit" name="Button" value="Submit" id="Button">
    					<cfinput type="hidden" name="hiddenField" value="employee"></td>
  							</tr>
  
		<!-- Here messages fro the page are displayed -->
  
  			<tr>
    			<td>&nbsp;</td>
    				<td><cfset message='#URL.state#'>
						<cfoutput>#variables.message#</cfoutput>&nbsp;</td>
  							</tr>
								</table> 

							</cfform>
								</body>
									</html>
                                    
                                    <!-- The End-->
