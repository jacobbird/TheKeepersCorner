<cfparam name="url.action" type="string" default="">
<cfparam name="Cookie.OrderNumber" type="string" default="">
<cfparam name="variables.msg" type="string" default="">
<cfparam name="cookie.UserID" type="string" default="">
<!--new-->

<cfparam name="form.FirstName" type="string" default="">
<cfparam name="form.LastName" type="string" default="">
<cfparam name="form.MiddleInitial" type="string" default="">
<cfparam name="form.CompanyName" type="string" default="">
<cfparam name="form.Street" type="string" default="">
<cfparam name="form.City" type="string" default="">
<cfparam name="form.State" type="string" default="">
<cfparam name="form.Zip" type="string" default="">

<cfset FColor  = "##FFFFFF">
<cfset LColor  = "##FFFFFF">
<cfset CColor  = "##FFFFFF">
<cfset SColor  = "##FFFFFF">
<cfset CIColor = "##FFFFFF">
<cfset STColor = "##FFFFFF">
<cfset ZColor  = "##FFFFFF">
<cfscript>
populateFieldsRet.Title = "";
populateFieldsRet.CompanyName = "";
populateFieldsRet.FirstName = "";
populateFieldsRet.LastName = "";
populateFieldsRet.MiddleInitial = "";
populateFieldsRet.Street = "";
populateFieldsRet.City = "";
populateFieldsRet.State = "";
populateFieldsRet.Zip = "";
populateFieldsRet.AccessType = "";
variables.msg2 = "";
</cfscript>

<cfquery name="getAccessType" datasource="warehouse">
select AccessType
from customersinfo
where UserID='#Cookie.UserID#'
</cfquery>


<cfswitch expression="#url.action#">
<cfcase value="submit">

		<cfscript>
			form.OrderNumber = Cookie.OrderNumber;
			form.UserID = Cookie.UserID;
			form.AccessType = getAccessType.AccessType;
		</cfscript>

		<cfinvoke component="asyncFormHandler" method="UpdateBillingInformation" returnvariable="msg">
			<cfinvokeargument name="form"  value="#form#">
		</cfinvoke>
        
        <!--new-->
		<cfif form.FirstName eq "">
        <cfset FColor = "##CC9999">
        </cfif>
        <cfif form.LastName eq "">
        <cfset LColor  = "##CC9999">
        </cfif>      
        <cfif form.Street eq "">
        <cfset SColor  = "##CC9999">
        </cfif>
		<cfif form.City eq "">
        <cfset CIColor = "##CC9999">
        </cfif>
        <cfif form.State eq "">
        <cfset STColor = "##CC9999">
        </cfif>
        <cfif form.Zip eq "">
        <cfset ZColor  = "##CC9999">
        </cfif>
        
        <cfscript>
			populateFieldsRet.Title = "";
			populateFieldsRet.CompanyName = "#form.CompanyName#";
			populateFieldsRet.FirstName = "#form.FirstName#";
			populateFieldsRet.LastName = "#form.LastName#";
			populateFieldsRet.MiddleInitial = "#form.MiddleInitial#";
			populateFieldsRet.Street = "#form.Street#";
			populateFieldsRet.City = "#form.City#";
			populateFieldsRet.State = "#form.State#";
			populateFieldsRet.Zip = "#form.Zip#";
			populateFieldsRet.UserID2 = "#Cookie.UserID#";
			variables.msg2 = "";
		</cfscript>
        
        <cfif msg eq "">    
		<cfif getAccessType.AccessType eq "preferred">      
			<cflocation url="https://secure.reliablecleanroomproducts.com/EnterYourContactInformation.cfm">  
		<cfelse>
			<cflocation url="https://secure.reliablecleanroomproducts.com/EnterYourCreditCardInformation.cfm">  
		</cfif>
        </cfif>
     
</cfcase>

<cfcase value="makeSame">
	<cfquery name="retrieveorderinfo"  datasource="warehouse">
   			select *
   			from Orders
   			where OrderNumber = '#Cookie.OrderNumber#'
   		</cfquery> 
        
        <cfscript>			
			populateFieldsRet.Title = "#retrieveorderinfo.MailTitle#";
			populateFieldsRet.CompanyName = "#retrieveorderinfo.MailCompanyName#";
			populateFieldsRet.FirstName = "#retrieveorderinfo.MailFirstName#";
			populateFieldsRet.LastName = "#retrieveorderinfo.MailLastName#";
			populateFieldsRet.MiddleInitial = "#retrieveorderinfo.MailMiddleInitial#";
			populateFieldsRet.Street = "#retrieveorderinfo.MailStreet#";
			populateFieldsRet.City = "#retrieveorderinfo.MailCity#";
			populateFieldsRet.State = "#retrieveorderinfo.MailState#";
			populateFieldsRet.Zip = "#retrieveorderinfo.MailZip#";
			populateFieldsRet.UserID2 = "#Cookie.UserID#";
			variables.msg2 = "";
		</cfscript>
       
</cfcase>
 
<cfcase value="init"> 
<cfinvoke component="asyncFormHandler" method="createANewOrder"  returnvariable="OrderNumber"/>
<cfcookie secure="yes" value="#variables.OrderNumber#" expires="never" name="OrderNumber">
</cfcase>
</cfswitch>

<cfif not url.action eq "submit" or url.action eq "makeSame">
<cfif Cookie.AccessType eq "Preferred" or Cookie.AccessType eq "Standard">

	<cfinvoke 
 	 component="CheckoutComponent"
 	 method="retrievecustomerinformation"
 	 returnvariable="populateFieldsRet">
 		<cfinvokeargument name="Arg" value="#Cookie.UserID#" />
	</cfinvoke>   
    
    
<cfelse>

	<cfinvoke 
 	 component="CheckoutComponent"
 	 method="retrieveorderinformation"
 	 returnvariable="populateFieldsRet">
 		<cfinvokeargument name="Arg" value="#Cookie.OrderNumber#" />
	</cfinvoke>
    
</cfif>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Enter Your Billing Address</title>

<script>
    function sF() {
    	form.submit();
    }
	function makeSame() {
	window.open('https://secure.reliablecleanroomproducts.com/EnterYourBillingAddress.cfm?action=makeSame','_self');
	}
</script>

<link href="UniversalFormatterTwo.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {font-size: 12px}
.style2 {	font-size: 14px;
	font-style: italic;
}
.style3 {
	color: #666666;
	font-weight: bold;
}
.style4 {color: #FFCC33}
-->
</style>
</head>

<body>
	<table width="883" border="1" bordercolor="#FFFFFF" bgcolor="#FFFFFF">

<cfif not variables.msg eq "">
	<tr bgcolor="#FFAA66" bordercolor="#999999" class="ArialStore" >
		<td height="50" colspan="6">&nbsp;<cfoutput>#variables.msg#</cfoutput></td>
	</tr>
</cfif>

<cfoutput>

	<form name="form" action="https://secure.reliablecleanroomproducts.com/EnterYourBillingAddress.cfm?action=submit" method="post" >
		<tr>
			<td colspan="6" style="color:004400; font-size:24px">DiscountSoccerSupply.com</td>
	  </tr>
		<cfif structkeyexists(cookie, "UserID") and not cookie.UserID eq ""><tr>
			<td height="61" colspan="6" class="ArialStore">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  				<cfoutput>Thank You #populateFieldsRet.FirstName# #populateFieldsRet.LastName# You are a #populateFieldsRet.AccessType# Member! Please Update The Your Information in the Forms Below and Feel Free to Contact Us at our Customer Support Line. </cfoutput></td>
	  </tr></cfif>
			<tr>
		<td>	</td>
	<td colspan="4"> 	  </td>
		 <td width="3">            </td>
</tr>
            <tr>
              <td bgcolor="##FFFFFF">&nbsp;</td>
              <td colspan="4" bgcolor="##FFFFFF"><span class="style3">Please Enter Your Billing Address Information: </span><span class="style1">(* = required)</span></td>
              <td>&nbsp;</td>
            </tr>
      <tr>
<td bgcolor="##FFFFFF">&nbsp;</td>
<td colspan="4" bgcolor="##004400">&nbsp;</td>
<td width="3">&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><img src="images/Area Fill/275Wide.gif" alt="" width="275" height="15" /></td>
<td><img src="images/Area Fill/275Wide.gif" width="275" height="15" /></td>
<td><img src="images/Area Fill/275Wide.gif" alt="" width="275" height="15" /></td>
<td bgcolor="##FFFFFF">&nbsp;</td>
<td width="3">&nbsp;</td>
</tr>

<tr>
<td width="3">&nbsp;</td>
<td width="279"><input style="background-color:#variables.FColor#" type="text" name="FirstName" typeahead="no" showautosuggestloadingicon="false" autosuggest="false" maxlength="21" value="#populateFieldsRet.FirstName#" required="yes"></td>
<td width="279"><input style="background-color:#variables.LColor#" type="text" name="LastName" typeahead="no" showautosuggestloadingicon="false" autosuggest="false" maxlength="21" value="#populateFieldsRet.LastName#"></td>
<td width="259"><input type="text" name="MiddleInitial" typeahead="no" showautosuggestloadingicon="false" autosuggest="false" maxlength="1" value="#populateFieldsRet.MiddleInitial#"></td>            
<td width="20" bgcolor="##FFFFFF">&nbsp;</td>
<td width="3">&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><em>First Name<span class="style4"> *</span></em></td>
<td><em>Last Name<span class="style4"> *</span></em></td>
<td><em>Middle Initial</em></td>            
<td bgcolor="##FFFFFF">&nbsp;</td>
<td width="3">&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td bgcolor="##FFFFFF">&nbsp;</td>
<td width="3">&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><input type="text" name="CompanyName" typeahead="yes" width="150 px" showautosuggestloadingicon="false" autosuggest="false" maxlength="22" value="#populateFieldsRet.CompanyName#"></td>
<td><input style="background-color:#variables.SColor#" type="text" name="Street" typeahead="no" showautosuggestloadingicon="false" autosuggest="false" maxlength="20" value="#populateFieldsRet.Street#"></td>
<td><input style="background-color:#variables.CIColor#" type="text" name="City" typeahead="no" showautosuggestloadingicon="false" autosuggest="false" maxlength="20" value="#populateFieldsRet.City#"></td>
<td bgcolor="##FFFFFF">&nbsp;</td>
<td width="3">&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td bgcolor="##FFFFFF"><em>Company Name</em></td>
<td><em>Street <span class="style4">*</span></em></td>
<td><em>City<span class="style4"> *</span></em></td>
<td bgcolor="##FFFFFF">&nbsp;</td>
<td width="3">&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td align="right">&nbsp;</td>
  <td align="right" bgcolor="##FFFFFF">&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td><input style="background-color:#variables.STColor#" type="text" name="State" typeahead="yes" width="150 px" showautosuggestloadingicon="false" autosuggest="false" maxlength="22" value="#populateFieldsRet.State#"></td>
  <td><input style="background-color:#variables.ZColor#" type="text" name="Zip" typeahead="no" showautosuggestloadingicon="false" autosuggest="false" maxlength="20" value="#populateFieldsRet.Zip#"></td>
  <td align="left"><input name="UserID2"  type="hidden" value="#Cookie.UserID#"/>
  <cfif structKeyExists(Cookie, "UserID") and not Cookie.UserId eq "">
  <strong>UserID:</strong> #Cookie.UserID#
</cfif></td>
  <td align="left" bgcolor="##FFFFFF">&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td><em>State<span class="style4"> *</span> </em></td>
  <td><em>Zip<span class="style4"> *</span></em></td>
  <td align="right">&nbsp;</td>
  <td align="right" bgcolor="##FFFFFF">&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td height="46">&nbsp;</td>
  <td>&nbsp;</td>
  <td><span class="style2">Checkout System</span></td>
  <td colspan="2" align="right"><img src="images/icons/CheckOutButtonNext.jpg" onclick="sF()" border="0" /></td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td bgcolor="##FFFFFF">&nbsp;</td>
  <td colspan="4" bgcolor="##004400">&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td class="ArialStoreGreyBold" colspan="4">Your order is important to us please get it right! Double check your typing so that you can get the products you've ordered! Be sure that everything has been spelled correctly Thank You!</td>
<td width="3">&nbsp;</td>
</tr>
</form>
</cfoutput>
</table>
</body>
</html>
