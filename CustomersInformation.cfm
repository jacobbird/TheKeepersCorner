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
<cfset originURL = "CustomersInformation.cfm">
<cflocation URL="BuyersLoginPage.cfm?originURL=#variables.originURL#">
<cfabort>
</cfif>

<!-- -->

<cfoutput>
<cfinvoke component="CustomerCareComponent" method="RetrieveCustomerInformation" returnvariable="RetrieveCustomerInformationRet">
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
   
   <cfinvoke component="CustomerCareComponentTwo" method="CustomersUpdateFunction">
   		<cfinvokeargument name="s" value="#s#">
   </cfinvoke>
   
   <cflocation url="CustomersInformation.cfm">
</cfif>
</cfoutput>

<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</head>
<body bgcolor="#666666">
<cfoutput>
<table height="1532" border="0" cellpadding="0" cellspacing="0">
<cfform name="form1" action="CustomersInformation.cfm?action=Update">
<tr>
  <td height="60" colspan="5" align="left" class="PageHeaders"><font color="FFFFFF">&nbsp;Edit Information  Page</font></td>
</tr>


<tr>
  <td height="12"><img src="images/Area Fill/BlankFormFillerCol.gif" width="180" height="14"></td>
  <td><img src="images/Area Fill/BlankFormFillerCol.gif" width="180" height="14"></td>
  <td><img src="images/Area Fill/BlankFormFillerCol.gif" alt="" width="180" height="14"></td>
  <td colspan="2"><img src="images/Area Fill/BlankFormFillerCol.gif" width="180" height="14"></td>
</tr>
<tr bgcolor="666666">
  <td height="43" colspan="5"><font color="##FFFFFF" size="+2">&nbsp;Name Information:</font></td>
</tr>
<tr bgcolor="CCCCCC" class="formlabels">
  <td bgcolor="##666666"><span class="style1">&nbsp; First Name</span></td>
  <td bgcolor="##666666"><span class="style1">Last Name</span></td>
  <td bgcolor="##666666"><span class="style1">Middle Initial</span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1">Title PhD. Dr. Mr. Ms. Mrs. </span></td>
</tr>
<tr bgcolor="EEEEEE">
<td width="180" bgcolor="##666666"><span class="style1">&nbsp; 
  <cfinput type="text" name="FirstName" id="FirstName" value="#RetrieveCustomerInformationRet.FirstName#">
</span></td>
<td width="180" bgcolor="##666666"><cfinput type="text" name="LastName" id="LastName" value="#RetrieveCustomerInformationRet.LastName#"></td>
<td width="180" bgcolor="##666666"><cfinput type="text" name="MiddleInitial" id="MiddleInitial" value="#RetrieveCustomerInformationRet.MiddleInitial#"></td>
<td colspan="2" bgcolor="##666666"><cfinput type="text" name="Title" id="Title" value="#RetrieveCustomerInformationRet.Title#"></td>
</tr>
<tr class="formlabels" bgcolor="FFFFFF">
<td bgcolor="##666666"><span class="style1"></span></td>
<td bgcolor="##666666"><span class="style1"></span></td>
<td bgcolor="##666666"><span class="style1"></span></td>
<td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr bgcolor="CCCCCC" class="formlabels">
  <td bgcolor="##666666"><span class="style1">&nbsp; Company Name</span></td>
  <td bgcolor="##666666"><span class="style1">Position Held</span></td>
  <td bgcolor="##666666"><span class="style1">User ID </span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1">Password</span></td>
</tr>
<tr bgcolor="EEEEEE">
  <td bgcolor="##666666"><span class="style1">&nbsp; 
    <cfinput type="text" name="CompanyName" id="CompanyName" value="#RetrieveCustomerInformationRet.CompanyName#">
  </span></td>
  <td bgcolor="##666666"><cfinput type="text" name="PositionHeld" id="PositionHeld2" value="#RetrieveCustomerInformationRet.PositionHeld#"></td>
  <td bgcolor="##666666"><span class="style1">#Cookie.UserID#
      <cfinput type="hidden" name="UserID" id="PositionHeld" value="#Cookie.UserID#">
  </span></td>
  <td colspan="2" bgcolor="##666666"><cfinput type="text" name="Password" id="Password" value="#RetrieveCustomerInformationRet.Password#"></td>
</tr>
<tr class="formlabels">
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>

<tr class="CustomerNumber" bgcolor="##666666"> 
  <td colspan="5" bgcolor="##666666"> <span class="style1">&nbsp; Address Information:</span></td>
</tr>
<tr bgcolor="999999">
  <td colspan="5" bgcolor="##666666" class="formheaders style1" >&nbsp; Billing Address</td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td bgcolor="##666666" h><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td height="25" bgcolor="##666666"><span class="style1">&nbsp;Street </span></td>
  <td bgcolor="##666666"><span class="style1">Number</span></td>
  <td bgcolor="##666666"><span class="style1">City</span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1">State</span></td>
</tr>
<tr bgcolor="EEEEEE">
  <td bgcolor="##666666"><span class="style1">&nbsp; 
    <cfinput type="text" name="Street" id="Street" value="#RetrieveCustomerInformationRet.Street#">
  </span></td>
  <td bgcolor="##666666"><cfinput type="text" name="Number" id="Number" value="#RetrieveCustomerInformationRet.Number#"></td>
  <td bgcolor="##666666"><cfinput type="text" name="City" id="City" value="#RetrieveCustomerInformationRet.City#"></td>
  <td colspan="2" bgcolor="##666666"><cfinput type="text" name="State" id="State" value="#RetrieveCustomerInformationRet.State#"></td>
</tr>
<tr class="formlabels">
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td bgcolor="##666666"><span class="style1">&nbsp;Zip</span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr bgcolor="EEEEEE">
  <td bgcolor="##666666"><span class="style1">&nbsp;
      <cfinput type="text" name="Zip" id="Zip" value="#RetrieveCustomerInformationRet.Zip#">
  </span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr class="formlabels">
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr bgcolor="999999">
  <td colspan="5" bgcolor="##666666" class="formheaders style1" >&nbsp; Mailing Address &nbsp; <cfinput type="button" value="Same" name="same" onClick="document.getElementById('MailFirstName').value=
document.getElementById('FirstName').value, document.getElementById('MailLastName').value=
document.getElementById('LastName').value, document.getElementById('MailMiddleInitial').value=
document.getElementById('MiddleInitial').value, document.getElementById('MailStreet').value=
document.getElementById('Street').value, document.getElementById('MailNumber').value=
document.getElementById('Number').value, document.getElementById('MailCity').value=
document.getElementById('City').value, document.getElementById('MailState').value=
document.getElementById('State').value, document.getElementById('MailZip').value=
document.getElementById('Zip').value, document.getElementById('MailCompanyName').value=
document.getElementById('CompanyName').value" ></td>
  </tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td bgcolor="##666666"><span class="style1">&nbsp; Mail First Name</span></td>
  <td bgcolor="##666666"><span class="style1">Mail Middle Initial</span></td>
  <td bgcolor="##666666"><span class="style1">Mail Last Name </span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr  bgcolor="EEEEEE">
  <td bgcolor="##666666"><span class="style1">&nbsp;
      <label>
      <cfinput type="text" name="MailFirstName" id="MailFirstName" value="#RetrieveCustomerInformationRet.MailFirstName#">
      </label>
  </span></td>
  <td bgcolor="##666666"><span class="style1">
    <label>
    <cfinput type="text" name="MailMiddleInitial" id="MailMiddleInitial" value="#RetrieveCustomerInformationRet.MailMiddleInitial#">
    </label>
  </span></td>
  <td bgcolor="##666666"><span class="style1">
    <label>
    <cfinput type="text" name="MailLastName" id="MailLastName" value="#RetrieveCustomerInformationRet.MailLastName#">
    </label>
  </span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr class="formlabels">
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td bgcolor="##666666"><span class="style1">&nbsp;Mail Street </span></td>
  <td bgcolor="##666666"><span class="style1">Mail Number</span></td>
  <td bgcolor="##666666"><span class="style1">Mail City</span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1">Mail State</span></td>
</tr>
<tr bgcolor="EEEEEE">
  <td bgcolor="##666666"> <span class="style1">&nbsp; 
    <cfinput type="text" name="MailStreet" id="MailStreet" value="#RetrieveCustomerInformationRet.MailStreet#">
  </span></td>
  <td bgcolor="##666666"><cfinput type="text" name="MailNumber" id="MailNumber" value="#RetrieveCustomerInformationRet.MailNumber#"></td>
  <td bgcolor="##666666"><cfinput type="text" name="MailCity" id="MailCity" value="#RetrieveCustomerInformationRet.MailCity#"></td>
  <td colspan="2" bgcolor="##666666"><cfinput type="text" name="MailState" id="MailState" value="#RetrieveCustomerInformationRet.MailState#"></td>
</tr>
<tr class="formlabels">
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr class="formlabels" bgcolor="CCCCCC">
  <td bgcolor="##666666"><span class="style1">&nbsp;Mail Zip</span></td>
  <td bgcolor="##666666"><span class="style1">Mail Company Name</span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr bgcolor="EEEEEE">
  <td bgcolor="##666666"><span class="style1">&nbsp; 
    <cfinput type="text" name="MailZip" id="MailZip" value="#RetrieveCustomerInformationRet.MailZip#">
  </span></td>
  <td bgcolor="##666666"><span class="style1">
    <label>
    <cfinput type="text" name="MailCompanyName" id="MailCompanyName" value="#RetrieveCustomerInformationRet.MailCompanyName#">
    </label>
  </span></td>
  <td bgcolor="##666666"><span class="style1">
    <label></label>
  </span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr class="formlabels">
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td colspan="2">&nbsp;</td>
</tr>

<tr bgcolor="##666666" class="CustomerNumber" >
  <td height="47" colspan="5">&nbsp;Other Info:</td>
  </tr>
<tr>
  <td></td>
  <td></td>
  <td></td>
  <td colspan="2"></td>
</tr>
<tr bgcolor="CCCCCC" class="formlabels">
  <td bgcolor="##666666"><span class="style1">&nbsp;Access Type</span></td>
  <td bgcolor="##666666"><span class="style1">Tax ID</span></td>
  <td bgcolor="##666666"><span class="style1">Phone Number</span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1">Applied for Preferred</span></td>
</tr>
<tr bgcolor="EEEEEE">
  <td bgcolor="##666666"><span class="style1">&nbsp;
    <cfinput type="text" name="AccessType" id="AccessType" value="#RetrieveCustomerInformationRet.AccessType#">
  </span></td>
  <td bgcolor="##666666"><cfinput type="text" name="TaxID" class="style1" id="TaxID" value="#RetrieveCustomerInformationRet.TaxID#"></td>
  <td bgcolor="##666666"><cfinput type="text" name="PhoneNumber" class="style1" id="PhoneNumber" value="#RetrieveCustomerInformationRet.PhoneNumber#"></td>
  <td colspan="2" bgcolor="##666666"><span class="style1">
    <label>
    <cfinput type="text" name="Applied" id="Applied" value="#RetrieveCustomerInformationRet.Applied#">
    </label>
  </span></td>
</tr>
<tr class="formlabels">
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr bgcolor="CCCCCC" class="formlabels">
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1">eMail Address</span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr bgcolor="EEEEEE">
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1"></span></td>
  <td bgcolor="##666666"><span class="style1">
    <label>
    <cfinput type="text" name="emailaddress" id="emailaddress" value="#RetrieveCustomerInformationRet.emailaddress#">
    </label>
  </span></td>
  <td colspan="2" bgcolor="##666666"><span class="style1"></span></td>
</tr>
<tr class="formlabels">
  <td height="31">&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td height="25">&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td width="185" align="right"><cfinput type="submit" name="Update Entery" value="Submit" id="Update Entery"> &nbsp; </td>
  <td width="145" align="right">&nbsp;</td>
</tr>
<tr>
  <td height="27">&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td colspan="2">&nbsp;</td>
</tr>
</cfform>
<tr class="CustomerNumber" bgcolor="##666666">
  <td colspan="5">&nbsp;</td>
  </tr>
<cfform name="form3" action="EditCustomerInformationPage.cfm?action=EditOrder">
<cfloop query="OrdersByCustomerRet" startrow="1" endrow="10">
</cfloop>
</cfform>
</table>
</cfoutput>
</body>
</html>
