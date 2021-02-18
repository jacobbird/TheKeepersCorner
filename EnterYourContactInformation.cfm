<!--Set default values for the url variables-->
<cfparam name="url.action" type="string" default="">
<cfparam name="url.ON" type="string" default="">


<!--Set default values for the page variable-->

<cfparam name="variables.msg" type="string" default="">


<!--Set default values for the cookie-->

<cfparam name="cookie.UserID" type="string" default="">


<!-- Inititalize the necessary query results populateFieldRet to null or blank values. Later you'll see why! -->

<cfscript>
	populateFieldsRet.EmailAddress = "";
	populateFieldsRet.PhoneNumber = "";
</cfscript>


<!-- Initialize the background of the required fields to the color white -->

<cfscript>
	eColor = "##FFFFFF";
	Pcolor = "##FFFFFF";	
</cfscript>

<!-- 
 Find the access type aasigned to the user if one exists, If the user is not a member the record count for this 
 query will be zero.
-->

<cfquery name="getAccessType" datasource="discountsoccer">
select AccessType
from customersinfo
where UserID='#Cookie.UserID#'
</cfquery>



<!-- Order is important avoid using additional recursive statements by placing statements in the correct order.-->

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

<!-- Here the page communicates with the asyncFormHandler on when the action submit is present in the url.-->

<cfif url.action eq "submit">

		<cfscript>	
			form.OrderNumber = Cookie.OrderNumber;
			form.UserID = cookie.UserID;
			form.AccessType = getAccessType.AccessType;
			
			
			populateFieldsRet.eMailAddress = "#form.eMailAddress#";
			populateFeildsRet.PhoneNumber = "#form.PhoneNumber#";
		</cfscript>
        
        <!-- Adjust the background color of the required fields that have no content to light red!!!-->
        
		<cfif form.eMailAddress eq "">
        <cfset eColor = "##CC9999">
        </cfif>
        <cfif form.PhoneNumber eq "">
        <cfset PColor  = "##CC9999">
        </cfif>
		

		<cfinvoke component="asyncFormHandler" method="UpdateContactInformation" returnvariable="msg">
			<cfinvokeargument name="form"  value="#form#">
		</cfinvoke>
     
     
        
	<!--
     If the asyncFormHandler does not return an error message then allow the user to move on to the next step
     of the checkout process.
    -->        
		<cfif variables.msg eq "">
			<cflocation url="http://www.discountsoccersupply.com/CheckToBeSureYourInformationIsCorrect.cfm">  
		</cfif>

</cfif>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Enter Your Mailing Address</title>

<script>
    function sF() {
    	form.submit();
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
	<tr bgcolor="#FFAA66" bordercolor="#999999" class="ArialStore">
	<td height="50" colspan="6">&nbsp;<cfoutput>#variables.msg#</cfoutput></td>
	</tr>
</cfif>

<form name="form" action="https://secure.reliablecleanroomproducts.com/EnterYourContactinformation.cfm?action=submit" method="post" >
	<cfoutput>
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
              <td colspan="4" bgcolor="##FFFFFF"><span class="style3">Please Enter Your Contact Address Information: </span><span class="style1">(* = required)</span></td>
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
<td width="279"><input type="text" name="eMailAddress" typeahead="yes" showautosuggestloadingicon="false" autosuggest="false" maxlength="55" value="#populateFieldsRet.eMailAddress#" required="yes" style="background-color:#eColor#"></td>
<td width="279"><input type="text" name="PhoneNumber" typeahead="yes" showautosuggestloadingicon="false" autosuggest="false" maxlength="21" value="#populateFieldsRet.PhoneNumber#" style="background-color:#PColor#"></td>
<td width="259"><input type="text" name="PhoneNumber2" typeahead="yes" showautosuggestloadingicon="false" autosuggest="false" maxlength="21" value="#populateFieldsRet.PhoneNumber2#" /></td>
<td width="20" bgcolor="##FFFFFF">&nbsp;</td>
<td width="3">&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><em>eMail Address <span class="style4">*</span></em></td>
<td><em>Phone Number1<span class="style4"> *</span></em></td>
<td><em>Phone Number2</em></td>            
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
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
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
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td align="right">&nbsp;</td>
  <td align="right" bgcolor="##FFFFFF">&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td align="left"><input name="UserID2"  type="hidden" value="#Cookie.UserID#"/>
  UserID: 
    #Cookie.UserID#</td>
  <td align="left" bgcolor="##FFFFFF">&nbsp;</td>
  <td>&nbsp;</td>
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
  <td height="46">&nbsp;</td>
  <td>&nbsp;</td>
  <td><span class="style2">Checkout System</span></td>
  <td colspan="2" align="right"><img src="images/icons/CheckOutButtonNext.jpg" onClick="sF()" border="0" /></td>
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
</cfoutput></form>
</table>
</body>
</html>
