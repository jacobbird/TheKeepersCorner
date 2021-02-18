<html>
	<head>
		
        <cfparam default="none" name="URL.Action" type="string">
			<cfparam default="none" name="URL.UserID" type="string">
				<cfparam default="#URL.UserID#" name="Form.UserID" type="string">
					<cfparam default="none" name="COOKIE.ACCESSTYPE" type="string">

	<!-- Here an if statement contains which controlls the 
    		page security if user is not logged it redirects 
            	the user to a login dialog. -->
		
		<cfif structKeyExists(COOKIE, "UserID")>
			<cfelse>
				<cfparam name="originURL" default="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
					<cfset originURL = "CustomersInformation.cfm">
						<cflocation URL="BuyersLoginPage.cfm?originURL=#variables.originURL#">
							<cfabort>
								</cfif>

	<!-- Here a couple of queries are retieved from the Customer Care 
    		Component one which gathers order information 
    			and another which gathers customer information  -->

	<cfoutput>
		<cfinvoke component="CustomerCareComponent" method="RetrieveCustomerInformation" returnvariable="RetrieveCustomerInformationRet">
			<cfinvokeargument name="UserID" value="#COOKIE.USERID#">
				</cfinvoke>
		
        	<cfinvoke component="CustomerCareComponent" method="OrdersByCustomer" returnvariable="RetrieveOrderInformationRet">
				<cfinvokeargument name="UserID" value="#COOKIE.USERID#">
					</cfinvoke>

	<cfif url.action eq "Update">
	<cfset s = structNew()>   
   	<cfset s.City = Form.City>
   	<cfset s.CompanyName = Form.CompanyName>
   	<cfset s.EmailAddress = Form.EmailAddress>
   	<cfset s.FirstName = Form.FirstName>
   	<cfset s.LastName = Form.LastName>
   	<cfset s.MailCompanyName = Form.MailCompanyName>   
   	<cfset s.MailFirstName = Form.MailFirstName>
   	<cfset s.MailLastName = Form.MailLastName>
   	<cfset s.MailMiddleInitial = Form.MailMiddleInitial>
   	<cfset s.MailNumber = Form.MailNumber>
   	<cfset s.MailStreet = Form.MailStreet>   
   	<cfset s.MailCity = Form.MailCity>
   	<cfset s.MailState = Form.MailState>
   	<cfset s.MailZip = Form.MailZip>
   	<cfset s.MiddleInitial = Form.MiddleInitial>
   	<cfset s.Password = Form.Password>   
   	<cfset s.PhoneNumber = Form.PhoneNumber>
   	<cfset s.State = Form.State>
   	<cfset s.Street = Form.Street>
   	<cfset s.TaxID = Form.TaxID>
   	<cfset s.UserID = Form.UserID>   
   	<cfset s.Zip = Form.Zip >
   	<cfset s.Number = Form.Number>
   	<cfset s.Title = Form.Title>
   	<cfset s.AccessType = Form.AccessType>
   	<cfset s.Applied = Form.Applied>
  
    <!-- Invokes the customer care component two which imputs form data in the the MySql(4/5) database -->
   	<cfinvoke component="CustomerCareComponentTwo" method="CustomersUpdateFunction">
   		<cfinvokeargument name="s" value="#s#">
   			</cfinvoke>
   				<cflocation url="EditCustomerInformationPage.cfm?userid=#Form.UserID#">
					</cfif>
						</cfoutput>

	<!-- Here the cascading style sheets are linked to the page effectivly importing all style for text -->
	<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">

	<body bgcolor="FFFFFF" leftmargin="45">
	<cfoutput>
		<table height="411" border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<td height="60" colspan="4" align="left" class="StoreTitle">&nbsp; 
           	Account and Billing Information</td>
							</tr>

				<tr>
  					<td height="12">&nbsp;</td>
  						<td>&nbsp;</td>
  							<td>&nbsp;</td>
								<td>&nbsp;</td>
			  </tr>

		  <tr class="StoreTitle">
			<td height="43" colspan="4">
       	    <font >&nbsp; Account Information:</font></td>
							</tr>

		  <tr class="Store">
			<td height="26">&nbsp; First Name</td>
  						<td>&nbsp; Last Name</td>
  							<td>&nbsp; Status</td>
  								<td>&nbsp;</td>
									</tr>
				
          <tr class="Store">
			<td width="322" height="19">&nbsp; #RetrieveCustomerInformationRet.FirstName#</td>
						<td width="295">&nbsp; #RetrieveCustomerInformationRet.LastName#</td>
							<td width="223">&nbsp; Active</td>
								<td width="225">&nbsp;</td>
									</tr>

		  <tr>
					<td height="20">&nbsp;</td>
						<td>&nbsp;</td>
							<td>&nbsp;</td>
								<td>&nbsp;</td>
		  </tr>

		  <tr class="Store">
			<td height="20">&nbsp; Company Name</td>
  						<td>&nbsp; Position Held</td>
  							<td>&nbsp; User ID </td>
 								<td>&nbsp;</td>
									</tr>

		  <tr class="Store">
			<td height="19">&nbsp; #RetrieveCustomerInformationRet.CompanyName#</td>
 						<td>&nbsp; #RetrieveCustomerInformationRet.PositionHeld#</td>
  							<td>#Cookie.UserID#</td>
  								<td>&nbsp;</td>
									</tr>

		  <tr>
			  <td height="19">&nbsp;</td>
  						<td>&nbsp;</td>
  							<td>&nbsp;</td>
  								<td>&nbsp;</td>
		  </tr>

		  <tr class="StoreTitle"> 
			<td height="51" colspan="4"> &nbsp; Billing History</td>
						</tr>

				<tr>
  					<td height="25" colspan="4">&nbsp;</td>
		  </tr>
				
                <tr>
  					<td></td>
  						<td></td>
  							<td></td>
  								<td></td>
		  </tr>

		  <tr class="Store">
			<td height="25">&nbsp; OrderNumber</td>
  						<td>Amount</td>
  							<td>Date</td>
  								<td></td>
									</tr>
			
            <!-- Here is some code which controls the next-n system for the orders on the page -->	
			<cfparam name="url.startRow" type="numeric" default="1">
				<cfset startRow=url.startRow>
					<cfset endRow=startRow+9>
						<cfset nextStartRow=endRow+1>
							<cfset previousStartRow=startRow-10>
                            
		  <cfloop query="RetrieveOrderInformationRet" startrow="#startRow#" endrow="#endRow#">
			<tr class="Store">
			  <td height="37">&nbsp; #OrderNumber#</td>
  						<td>#DollarFormat(Total)#</td>
  							<td>#Date#</td>
  								<td></td>
									</tr>
		  </cfloop>

		  <tr class="Store">
  					<td height="21">
						<cfif startRow gt 1><a href="AccountAndBillingInformation.cfm?startRow=#nextStartPrevious#">&nbsp;
                        	<span class="style2"> Previous</span></a>
					  </cfif>
           	</td>
  										<td>&nbsp;</td>
  											<td>&nbsp;</td>
  					
                    <!-- More next-n stuff -->
            <td  class="Store" align="right">
						<cfif RetrieveOrderInformationRet.RecordCount gt 10><cfoutput>
                        	<a href="AccountAndBillingInformation.cfm?startRow=#nextStartRow#">
                            	Next &nbsp;</a></cfoutput>
			  </cfif>
           	</td>
											</tr>
	  </table>
	</cfoutput>                                                    
														</body>
															</html>
                                                            
                                                            <!-- The End -->