<html>
<head>
<cfparam default="none" name="URL.Action" type="string">
<cfparam default="admin" name="URL.UserID" type="string">
<cfparam default="#URL.UserID#" name="Form.UserID" type="string">
<cfparam default="admin" name="Form.UserID" type="string">
<cfparam default="none" name="COOKIE.ACCESSTYPE" type="string">
<cfif structKeyExists(COOKIE, "admin") or COOKIE.AccessType eq "Customer Care" or COOKIE.AccessType eq "Both">
<cfelse>
<cfparam name="originURL" default="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
<cfset originURL = "CustomerCareAndOrderUpdatingSystem.cfm">
<cflocation URL="EmployeeLogin.cfm?originURL=#variables.originURL#">
<cfabort>
</cfif>
<cfoutput>
<cfinvoke component="CustomerCareComponent" method="RetrieveCustomerInformation" returnvariable="RetrieveCustomerInformationRet">
<cfinvokeargument name="UserID" value="#URL.USERID#">
</cfinvoke>

<cfif url.action eq "Update">
    
   <cfset lf = toString(right(Form.CCnumber,4))>
   <cfset X = left("#form.CCNumber#", 1)>
   
   <cfif variables.X eq "X">
   	<cfset form.CCNumber = "#RetrieveCustomerInformationRet.CCNumber#">
   </cfif>
   
   <cfset s = structNew()>
   
   <cfset s.CCNAMEONCARD = Form.CCNAMEONCARD>
   <cfset s.CCNUMBER = Form.CCNUMBER>
   <cfset s.CCTHREEDIGIT = Form.CCTHREEDIGITS>
   <cfset s.CCTYPE = Form.CCTYPE>
   <cfset s.CCDATE = Form.CCExpirationDate >
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
   <cfset s.CCnumberLastFour = "XXXX XXXX XXXX #variables.lf#">
   <cfset s.Applied = Form.Applied>
   <cfinvoke component="CustomerCareComponentTwo" method="UpdateCustomerInformation">
   	<cfinvokeargument name="s" value="#s#">
   </cfinvoke>
   <cflocation url="EditCustomerInformationPage.cfm?userid=#Form.UserID#">
</cfif>

<cfif URL.action eq "FindOrder">
	<cfinvoke component="CustomerCareComponent" method="OrdersByCustomer" returnvariable="OrdersByCustomerRet">
	<cfinvokeargument name="UserID" value="#Form.UserID#">
	
	</cfinvoke>
    <cfelse>
    <cfinvoke component="CustomerCareComponent" method="OrdersByCustomer" returnvariable="OrdersByCustomerRet">
	<cfinvokeargument name="UserID" value="#URL.UserID#">
	</cfinvoke>
</cfif>

<cfif URL.action eq "EditOrder">
	<cflocation url="EditOrderInformationPage.cfm?OrderNumber=#Form.OrderNumber#">
</cfif>
</cfoutput>
<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfoutput>
<table height="1557" border="0" cellpadding="0" cellspacing="0">
<cfform name="form1" action="EditCustomerInformationPage.cfm?action=Update">
<tr>
  <td colspan="4" align="center" class="PageHeaders">Edit Customer's Information  Page</td>
</tr>
<tr>
  <td width="225">&nbsp;</td>
  <td>&nbsp;</td>
  <td width="280">&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr class="formheaders">
  <td height="30" colspan="4" bgcolor="##000000" class="CustomerNumber">&nbsp; Identification Information:</td>
  </tr>
<tr>
  <td height="12">&nbsp;</td>
  <td></td>
  <td></td>
  <td></td>
</tr>
<tr bgcolor="FFFF99">
  <td height="12">&nbsp;</td>
  <td></td>
  <td></td>
  <td></td>
</tr>
<tr>
  <td height="12"><img src="images/Area Fill/BlankFormFillerCol.gif" width="225" height="15"></td>
  <td><img src="images/Area Fill/BlankFormFillerCol.gif" alt="" width="225" height="15"></td>
  <td><img src="images/Area Fill/BlankFormFillerCol.gif" alt="" width="225" height="15"></td>
  <td><img src="images/Area Fill/BlankFormFillerCol.gif" alt="" width="225" height="15"></td>
</tr>
<tr bgcolor="CCCCCC" class="formlabels">
  <td>&nbsp; First Name</td>
  <td>Last Name</td>
  <td>Middle Initial</td>
  <td>Title PhD. Dr. Mr. Ms. Mrs. </td>
</tr>
<tr bgcolor="EEEEEE">
<td width="225">&nbsp; <cfinput type="text" name="FirstName" id="FirstName" value="#RetrieveCustomerInformationRet.FirstName#"></td>
<td width="225"><cfinput type="text" name="LastName" id="LastName" value="#RetrieveCustomerInformationRet.LastName#"></td>
<td width="280"><cfinput type="text" name="MiddleInitial" id="MiddleInitial" value="#RetrieveCustomerInformationRet.MiddleInitial#"></td>
<td width="234"><cfinput type="text" name="Title" id="Title" value="#RetrieveCustomerInformationRet.Title#"></td>
</tr>
<tr class="formlabels" bgcolor="FFFFFF">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
<tr bgcolor="CCCCCC" class="formlabels">
  <td>&nbsp; Company Name</td>
  <td>Position Held</td>
  <td>User ID </td>
  <td>Password</td>
</tr>
<tr bgcolor="EEEEEE">
  <td>&nbsp; <cfinput type="text" name="CompanyName" id="CompanyName" value="#RetrieveCustomerInformationRet.CompanyName#"></td>
  <td><cfinput type="text" name="PositionHeld" id="PositionHeld2" value="#RetrieveCustomerInformationRet.PositionHeld#"></td>
  <td>#RetrieveCustomerInformationRet.UserID#<cfinput type="hidden" name="UserID" id="PositionHeld" value="#RetrieveCustomerInformationRet.UserID#"></td>
  <td><cfinput type="text" name="Password" id="Password" value="#RetrieveCustomerInformationRet.Password#"></td>
</tr>
<tr class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr class="CustomerNumber" bgcolor="##000000"> 
  <td colspan="4"> &nbsp; Address Information:</td>
  </tr>
<tr>
  <td height="12"></td>
  <td></td>
  <td></td>
  <td></td>
</tr>
<tr bgcolor="999999">
  <td colspan="4" class="formheaders" >&nbsp; Billing Address</td>
  </tr>
<tr height="12" class="formlabels" bgcolor="FFFFFF">
  <td height="12"></td>
  <td></td>
  <td></td>
  <td></td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td h></td>
  <td></td>
  <td></td>
  <td></td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td height="25">&nbsp;Street </td>
  <td>Number</td>
  <td>City</td>
  <td>State</td>
</tr>
<tr bgcolor="EEEEEE">
  <td>&nbsp; <cfinput type="text" name="Street" id="Street" value="#RetrieveCustomerInformationRet.Street#"></td>
  <td><cfinput type="text" name="Number" id="Number" value="#RetrieveCustomerInformationRet.Number#"></td>
  <td><cfinput type="text" name="City" id="City" value="#RetrieveCustomerInformationRet.City#"></td>
  <td><cfinput type="text" name="State" id="State" value="#RetrieveCustomerInformationRet.State#"></td>
</tr>
<tr class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td>&nbsp;Zip</td>
  <td></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr bgcolor="EEEEEE">
  <td>&nbsp;<cfinput type="text" name="Zip" id="Zip" value="#RetrieveCustomerInformationRet.Zip#"></td>
  <td></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr bgcolor="999999">
  <td colspan="4" class="formheaders" >&nbsp; Mailing Address</td>
  </tr>
<tr>
  <td height="10"></td>
  <td></td>
  <td></td>
  <td></td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td>&nbsp;Mail First Name</td>
  <td>Mail Middle Initial</td>
  <td>Mail Last Name </td>
  <td>&nbsp;</td>
</tr>
<tr  bgcolor="EEEEEE">
  <td>&nbsp;<label>
    <cfinput type="text" name="MailFirstName" id="MailFirstName" value="#RetrieveCustomerInformationRet.MailFirstName#">
  </label></td>
  <td><label>
    <cfinput type="text" name="MailMiddleInitial" id="MailMiddleInitial" value="#RetrieveCustomerInformationRet.MailMiddleInitial#">
  </label></td>
  <td><label>
    <cfinput type="text" name="MailLastName" id="MailLastName" value="#RetrieveCustomerInformationRet.MailLastName#">
  </label></td>
  <td>&nbsp;</td>
</tr>
<tr class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td>&nbsp;Mail Street </td>
  <td>Mail Number</td>
  <td>Mail City</td>
  <td>Mail State</td>
</tr>
<tr bgcolor="EEEEEE">
  <td> &nbsp; <cfinput type="text" name="MailStreet" id="MailStreet" value="#RetrieveCustomerInformationRet.MailStreet#"></td>
  <td><cfinput type="text" name="MailNumber" id="MailNumber" value="#RetrieveCustomerInformationRet.MailNumber#"></td>
  <td><cfinput type="text" name="MailCity" id="MailCity" value="#RetrieveCustomerInformationRet.MailCity#"></td>
  <td><cfinput type="text" name="MailState" id="MailState" value="#RetrieveCustomerInformationRet.MailState#"></td>
</tr>
<tr class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td>&nbsp;Mail Zip</td>
  <td>Mail Company Name</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr bgcolor="EEEEEE">
  <td>&nbsp; <cfinput type="text" name="MailZip" id="MailZip" value="#RetrieveCustomerInformationRet.MailZip#"></td>
  <td><label>
    <cfinput type="text" name="MailCompanyName" id="MailCompanyName" value="#RetrieveCustomerInformationRet.MailCompanyName#">
  </label></td>
  <td><label></label></td>
  <td>&nbsp;</td>
</tr>
<tr class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr bgcolor="##000000" class="CustomerNumber" >
  <td colspan="4">&nbsp;Other Info:</td>
  </tr>
<tr>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
</tr>
<tr bgcolor="CCCCCC" class="formlabels">
  <td>&nbsp;Access Type</td>
  <td>Tax ID</td>
  <td>Phone Number</td>
  <td>Applied for Prefered</td>
</tr>
<tr bgcolor="EEEEEE">
  <td>&nbsp;<cfinput type="text" name="AccessType" id="AccessType" value="#RetrieveCustomerInformationRet.AccessType#"></td>
  <td><cfinput type="text" name="TaxID" id="TaxID" value="#RetrieveCustomerInformationRet.TaxID#"></td>
  <td><cfinput type="text" name="PhoneNumber" id="PhoneNumber" value="#RetrieveCustomerInformationRet.PhoneNumber#"></td>
  <td><label>
    <cfinput type="text" name="Applied" id="Applied" value="#RetrieveCustomerInformationRet.Applied#">
  </label></td>
</tr>
<tr class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr bgcolor="CCCCCC" class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>eMail Address</td>
  <td>&nbsp;</td>
</tr>
<tr bgcolor="EEEEEE">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td><label>
    <cfinput type="text" name="emailaddress" id="emailaddress" value="#RetrieveCustomerInformationRet.emailaddress#">
  </label></td>
  <td>&nbsp;</td>
</tr>
<tr class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td><label></label></td>
</tr>

<tr class="CustomerNumber" bgcolor="##000000" >
  <td colspan="4">&nbsp;Credit Card Information:</td>
  </tr>

<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

<tr class="formlabels" bgcolor="##CCCCCC">
  <td>&nbsp;CC Name On Card</td>
  <td></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

<tr bgcolor="EEEEEE">
  <td>&nbsp;<cfinput type="text" name="CCNameoncard" id="CCNameoncard" value="#RetrieveCustomerInformationRet.CCNameoncard#"></td>
  <td></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td height="27">&nbsp; CC Number (lastfour)</td>
  <td>CC Expiration Date</td>
  <td>CC Type (AmExp, Visa, Master Card)</td>
  <td>CC Three Digits</td>
</tr>
<tr bgcolor="EEEEEE">
  <td>&nbsp; <cfinput type="text" name="CCnumber" id="CCnumber" value="#RetrieveCustomerInformationRet.CCnumberlastfour#"></td>
  <td><cfinput type="text" name="CCExpirationDate" id="CCDate" value="#RetrieveCustomerInformationRet.CCDate#"></td>
  <td><cfinput type="text" name="CCType" id="CCType" value="#RetrieveCustomerInformationRet.CCType#"></td>
  <td><cfinput type="text" name="CCThreedigits" id="CCThreedigits" value="#RetrieveCustomerInformationRet.CCThreeDigit#"></td>
</tr>
<tr class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>


<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td><cfinput type="submit" name="Update Entery" value="Update Customer's Information" id="Update Entery"></td>
</tr>

<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

</cfform>
<tr class="CustomerNumber" bgcolor="##000000">
  <td colspan="4">&nbsp;Recent Orders:</td>
  </tr>
  
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr bgcolor="FFFF99">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <th>Items</th>
  <th>Order Number</th>
  <th>Edit</th>
  <th>Date Of Order</th>
</tr>
<cfform name="form3" action="EditCustomerInformationPage.cfm?action=EditOrder">
<cfloop query="OrdersByCustomerRet" startrow="1" endrow="10">
<tr bgcolor="EEEEEE">
<td>&nbsp;#Items#</td>
<td align="center">#OrderNumber# </td>
<td align="center"><cfinput type="button" name="EditOrder" value="Edit Orders" onClick="window.open('EditOrderInformationPage.cfm?OrderNumber=#OrderNumber#','window8','toolbar=yes, scrollbars=yes, resizable=yes, width=999, height=800')"></td>
<td align="center">#Date#</td>
</tr>
</cfloop>
</cfform>
</table>
</cfoutput>
</body>
</html>
