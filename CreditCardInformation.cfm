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
<cfset originURL = "EditYourCreditCardInformation.cfm">
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
   <cfset s.CCDATE = Form.CCExpirationDate>    
   <cfset s.CCnumberLastFour = "XXXX XXXX XXXX #variables.lf#">
   <cfset s.UserID = Cookie.UserID>

   <cfinvoke component="CustomerCareComponentTwo" method="UpdateCreditCardInformation">
   		<cfinvokeargument name="s" value="#s#">
   </cfinvoke>
   
   <cflocation url="CreditCardInformation.cfm">
   
</cfif>
<cfset CurrentCard = RetrieveCustomerInformationRet.CCType>
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
<table width="821" height="442" border="0" cellpadding="0" cellspacing="0">
<cfform name="form1" action="CreditCardInformation.cfm?action=Update">
<tr>
  <td colspan="4" align="left" class="PageHeaders"><font color="FFFFFF">&nbsp;Edit Credit Card Information Page</font></td>
</tr>
<tr>
  <td width="187" height="19">&nbsp;</td>
  <td width="172">&nbsp;</td>
  <td width="185">&nbsp;</td>
  <td width="277">&nbsp;</td>
</tr>
<tr class="CustomerNumber" bgcolor="##666666" >
  <td height="25" colspan="4">&nbsp;Credit Card Information:</td>
</tr>
<tr>
  <td height="19">&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

<tr class="formlabels">
  <td height="20"><span class="style1">&nbsp;CC Name On Card</span></td>
  <td><span class="style1"></span></td>
  <td><span class="style1"></span></td>
  <td><span class="style1"></span></td>
</tr>

<tr>
  <td height="32"><span class="style1">&nbsp;
    <cfinput type="text" name="CCNameoncard" id="CCNameoncard" value="#RetrieveCustomerInformationRet.CCNameoncard#">
  </span></td>
  <td><span class="style1"></span></td>
  <td><span class="style1"></span></td>
  <td><span class="style1"></span></td>
</tr>
<tr class="formlabels">
  <td height="20"><span class="style1"></span></td>
  <td><span class="style1"></span></td>
  <td><span class="style1"></span></td>
  <td><span class="style1"></span></td>
</tr>
<tr class="formlabels">
  <td height="27"><span class="style1">&nbsp; CC Number (lastfour)</span></td>
  <td><span class="style1">CC Expiration Date</span></td>
  <td><span class="style1">CC Type (AmExp, Visa, Master Card)</span></td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td height="35"><span class="style1">&nbsp; 
    <cfinput type="text" name="CCnumber" id="CCnumber" value="#RetrieveCustomerInformationRet.CCnumberlastfour#">
  </span></td>
  <td><cfinput type="text" name="CCExpirationDate" id="CCDate" value="#RetrieveCustomerInformationRet.CCDate#"></td>
  <td><cfselect name="CCType" id="CCType">
  <option value="#RetrieveCustomerInformationRet.CCType#">#RetrieveCustomerInformationRet.CCType#</option>
  <option value="Visa">Visa</option>
  <option value="MasterCard">Master Card</option>
  <option value="AmExpress">American Express</option>
  <option value="Discover">Discover</option>
  </cfselect>
  </td>
  <td>&nbsp;</td>
</tr>
<tr class="formlabels">
  <td height="20">&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>


<tr class="formlabels">
  <td height="35">&nbsp; <span class="style1"> CC Three Digits</span></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

<tr>
  <td height="32">&nbsp; <cfinput type="text" name="CCThreedigits" id="CCThreedigits" value="#RetrieveCustomerInformationRet.CCThreeDigit#"></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td align="right"><cfinput type="submit" name="Update Entery" value="Submit" id="Update Entery"> &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;</td>
  <td>&nbsp;</td>
</tr>
</cfform>
</table>
</cfoutput>
</body>
</html>
