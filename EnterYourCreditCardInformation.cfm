<cfparam name="url.action" type="string" default="">
<cfparam name="Cookie.OrderNumber" type="string" default="">
<cfparam name="variables.msg" type="string" default="">
<cfparam name="cookie.UserID" type="string" default="">
<cfparam name="form.PhoneNumber" type="string" default="none">

<cfparam name="form.CCNameOnCard" type="string" default="">
<cfparam name="form.CCType" type="string" default="">
<cfparam name="form.CCNumber" type="string" default="">
<cfparam name="form.CCThreeDigit" type="string" default="">
<cfparam name="form.Street" type="string" default="">
<cfparam name="form.City" type="string" default="">
<cfparam name="form.State" type="string" default="">
<cfparam name="form.Zip" type="string" default="">
<cfparam name="form.KeepMyCardInfoOnFile" default="No">

<cfset NOCColor  	= "##FFFFFF">
<cfset CCTColor  	= "##FFFFFF">
<cfset CCDColor  	= "##FFFFFF">
<cfset CCTyColor  	= "##FFFFFF">
<cfset EAColor 		= "##FFFFFF">
<cfset CCNColor 	= "##FFFFFF">

<cfscript>
populateFieldsRet.CCNameOnCard = "Name";
populateFieldsRet.CCNumber = "";
populateFieldsRet.CCNumberLastFour = "";
populateFieldsRet.CCDate = "";
populateFieldsRet.CCThreeDigit = "";
populateFieldsRet.CCType = "";
populateFieldsRet.eMailAddress = "";
populateFieldsRet.PhoneNumber = "";
</cfscript>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Enter Your Credit Card Information</title>

<cfquery name="getAccessType" datasource="discountsoccer">
select AccessType
from customersinfo
where UserID='#Cookie.UserID#'
</cfquery>

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

<cfif url.action eq "submit">

		<cfscript>
			form.OrderNumber = Cookie.OrderNumber;
			form.UserID = Cookie.UserID;
			form.AccessType = getAccessType.AccessType;
		</cfscript>
        
        <cfoutput>
        
        <cfset LeftMostNumber = Left("#form.CCNumber#",1)>
        
        <cfif LeftMostNumber eq "X">
        	<cfset form.CCNumber="#populateFieldsRet.CCNumber#">       	
        </cfif>
     
		</cfoutput>
        
		<cfinvoke component="asyncFormHandler" method="UpdateCreditCardInformation" returnvariable="msg"> 	
                <cfinvokeargument name="form"  value="#form#">
		</cfinvoke>
        
        <cfif form.CCNameOncard eq "">
        <cfset NOCColor = "##CC9999">
        </cfif>
        <cfif form.CCNumber eq "">
        <cfset CCNColor  = "##CC9999">
        </cfif>      
        <cfif form.CCDate eq "">
        <cfset CCDColor  = "##CC9999">
        </cfif>
		<cfif form.CCThreeDigit eq "">
        <cfset CCTColor = "##CC9999">
        </cfif>
        <cfif form.eMailAddress eq "">
        <cfset EAColor = "##CC9999">
        </cfif>
        <cfif form.CCType eq "select">
        <cfset CCTyColor  = "##CC9999">
        </cfif>
        
        <cfscript>
			populateFieldsRet.CCNameOnCard = "#form.CCNameOnCard#";
			populateFieldsRet.CCDate = "#form.CCDate#";
			populateFieldsRet.CCType = "#form.CCType#";
			populateFieldsRet.CCNumber = "#form.CCNumber#";
			populateFieldsRet.CCThreeDigit = "#form.CCThreeDigit#";
			populateFieldsRet.eMailAddress = "#form.eMailAddress#";
			populateFieldsRet.phoneNumber = "#form.phoneNumber#";
			populateFieldsRet.UserID2 = "#Cookie.UserID#";
			variables.msg2 = "";
		</cfscript>
        
 		<cfif variables.msg eq "">
 			<cflocation url="https://secure.reliablecleanroomproducts.com/CheckToBeSureYourInformationIsCorrect.cfm">
    	</cfif>
</cfif>
    


<script>
    function sF() 
	{
    	cardnumber = test();
		if (cardnumber == true)
			{
				form.submit();
    		}
		else
			{
				alert("Card Number Invalid. Try Again");
			}
	}
	
	function test(){
		
		cctype = document.getElementById("CCType").value;
		ccnumber = document.getElementById("CCNumber").value;

		if (cctype=="Visa"){
				
			if( (ccnumber.substring(0,1) == 4) && (ccnumber.length == 16) 
          		|| (ccnumber.length == 13) )
          		{
					return (true);
          		}
			else{
					alert("Not a valid Visa card number!");	
          			return (false);
				}
		}
		
		else if(cctype=="MasterCard"){
		
			if( (ccnumber.length == 16) && (ccnumber.substring(0,2) == 51) 
          		|| (ccnumber.substring(0,2) == 52) || (ccnumber.substring(0,2) == 53)
          		|| (ccnumber.substring(0,2) == 54) || (ccnumber.substring(0,2) == 55) )
          		{
              		
					return (true);
          		}
			else
				{	
		  			alert("Not a valid Master Card number!");	
          			return (false);
				}
		}
		
		else if(cctype=="AmExpress"){		
		
			if( (ccnumber.length == 15) && (ccnumber.substring(0,2) == 34) 
                               || (ccnumber.substring(0,2) == 37) )
          		{
               		
					return (true);
          		}
			else
				{
          			alert("Not a valid American Express card number!");
		  			return (false);
				}
		
		}
		
		else if(cctype=="Discover")
		{
		
			if( (ccnumber.length == 16) && (ccnumber.substring(0,4) == 6011) )
          		{
					
               		return isCreditCard( cc );
          		}
			 else
			 	{
		  			alert("Not a valid Discover card number!");	
          			return (false);
				}
			}
	}
	
	function ccnumbervalidation(form, ctrl, value)
	{
		if(value.length > 4)
		{
			alert("Greater than four!");
			return (false);
		}
		else
		{
			alert("Less than four");
			return (false);
		}
		alert("Less than four");
		return (false);
	}
	/*---------------------------------------------------------------*/
/*                                                               */
/* Function  : isVisa()                                           */
/* Purpose   : Validate CC number following visa specs      */
/*                                                                  */
/*                                                               */
/* Parameters:     cc - the cc number                                                       */
/*                                                               */
/* Returns   : boolean                                              */
/*                                                               */
/* Usage     : isVisa(cc)                                           */
/*---------------------------------------------------------------*/

     function isVisa( cc )
     {
          
     }


/*---------------------------------------------------------------*/
/*                                                               */
/* Function  : isMC()                                           */
/* Purpose   : Validate CC number following MasterCard specs      */
/*                                                                  */
/*                                                               */
/* Parameters:     cc - the cc number                                                       */
/*                                                               */
/* Returns   : boolean                                              */
/*                                                               */
/* Usage     : isMC(cc)                                           */
/*---------------------------------------------------------------*/
     function isMC( cc )
     {
          if( (cc.length == 16) && (cc.substring(0,2) == 51) 
          || (cc.substring(0,2) == 52) || (cc.substring(0,2) == 53)
          || (cc.substring(0,2) == 54) || (cc.substring(0,2) == 55) )
          {
               return isCreditCard( cc );
          }
          return (false);
     }
/*---------------------------------------------------------------*/
/*                                                               */
/* Function  : isAmex()                                           */
/* Purpose   : Validate CC number following AMEX specs      */
/*                                                                  */
/*                                                               */
/* Parameters:     cc - the cc number                                                       */
/*                                                               */
/* Returns   : boolean                                              */
/*                                                               */
/* Usage     : isAmex(cc)                                           */
/*---------------------------------------------------------------*/
     function isAmex( cc )
     {
          if( (cc.length == 15) && (cc.substring(0,2) == 34) 
                               || (cc.substring(0,2) == 37) )
          {
               return isCreditCard( cc );
          }
          return (false);
     }
/*---------------------------------------------------------------*/
/*                                                               */
/* Function  : isDiscover()                                           */
/* Purpose   : Validate CC number following Discover specs      */
/*                                                                  */
/*                                                               */
/* Parameters:     cc - the cc number                                                       */
/*                                                               */
/* Returns   : boolean                                              */
/*                                                               */
/* Usage     : isDiscover(cc)                                           */
/*---------------------------------------------------------------*/
     function isDiscover( cc )
     {
     if( (cc.length == 16) && (cc.substring(0,4) == 6011) )
          {
               return isCreditCard( cc );
          }
          return (false);
     }



	
</script>

<link href="UniversalFormatterTwo.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {font-size: 12px}
.style2 {
	font-size: 14px;
	font-style: italic;
}
-->
</style>
</head>

<body>
<table width="892" border="1" bordercolor="#FFFFFF" bgcolor="#FFFFFF">

	<cfif not variables.msg eq "">
		<tr bgcolor="#FFAA66" bordercolor="#999999" >
			<td height="50" colspan="5">&nbsp;<cfoutput>#variables.msg#</cfoutput></td>
		</tr>
	</cfif>

<cfoutput>

<cfform name="form" action="http://www.discountsoccersupply.com/EnterYourCreditCardInformation.cfm?action=submit" method="post" enctype="multipart/form-data">
<tr>
	<td colspan="6" style="color:004400; font-size:24px">DiscountSoccerSupply.com</td>
</tr><cfif structkeyexists(cookie, "UserID") and not cookie.UserID eq "">
<tr>
<td height="61" colspan="5" class="ArialStore">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  	
  		<cfoutput>Thank You #populateFieldsRet.FirstName# #populateFieldsRet.LastName# You are a #populateFieldsRet.AccessType# Member! Please Update The Your 	Information in the Forms Below and Feel Free to Contact Us at our Customer Support Line. </cfoutput></td>
</tr></cfif>
<tr>
<td></td>
<td colspan="3"></td>
<td width="10"></td>
</tr>
<tr>
<td>&nbsp;</td>
<td colspan="3" class="ArialStore"><strong>Please Enter Your Credit Card Information: </strong><span class="style1">(* = required)</span></td>
<td width="10">&nbsp;</td>
</tr>
<tr>
  <td bgcolor="##FFFFFF">&nbsp;</td>
  <td colspan="4" bgcolor="##004400">&nbsp;</td>
  </tr>
<tr>
  <td>&nbsp;</td>
  <td><img src="images/Area Fill/275Wide.gif" alt="" width="275" height="8" /></td>
  <td><img src="images/Area Fill/275Wide.gif" width="275" height="8" /></td>
  <td><img src="images/Area Fill/275Wide.gif" alt="" width="275" height="9" /></td>
  <td>&nbsp;</td>
</tr>


<tr>
<td width="8">&nbsp;</td>
<td width="275"><input type="text" style="background-color:#variables.NOCColor#" name="CCNameOnCard" id="CCNameOnCard" typeahead="yes" showautosuggestloadingicon="false" autosuggest="false" maxlength="21" value="#populateFieldsRet.CCNameOnCard#" required="yes"></td>
<td width="275"><select Name="CCType" id="CCType" >
<option value="MasterCard">Master Card</option>
<option value="Visa">Visa</option>
<option value="AmExpress">American Express</option>
<option value="Discover">Discover</option>
</select></td>
<td width="290"><label>
  <cfif Cookie.AccessType eq "Standard">
  	<input type="checkbox" name="KeepMyCardInfoOnFile" id="KeepMyCardInfoOnFile" value="yes" /> 
  	Keep my Card Info On File?</cfif>
</label></td>
<td width="10">&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><em>Name On Card <span class="style4"> *</span><span class="style1">(As it Appears)</span></em></td>
<td><em>Credit Card Type<span class="style4"> *</span></em></td>
<td>&nbsp;</td>            
<td width="10">&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td width="10">&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><cfinput type="text" style="background-color:#variables.CCNColor#" id="CCNumber" name="CCNumber" typeahead="no" width="150 px" showautosuggestloadingicon="false" autosuggest="false" maxlength="22" value="#populateFieldsRet.CCNumber#"></td>
<td><input type="text" style="background-color:#variables.CCDColor#" name="CCDate" typeahead="no" showautosuggestloadingicon="false" autosuggest="false" maxlength="20" value="#populateFieldsRet.CCDate#" mask="99/99 /9999"></td>
<td><input type="text" style="background-color:#variables.CCTColor#" name="CCThreeDigit" typeahead="no" showautosuggestloadingicon="false" autosuggest="false" maxlength="20" value="#populateFieldsRet.CCThreeDigit#"></td>
<td width="10">&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><em>Credit Card Number<span class="style4"> *</span></em></td>
<td><em>Expiration Date <span class="style4">*</span></em></td>
<td><em>Three Digits<span class="style4"> *</span></em></td>
<td width="10">&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td align="right">&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td><input type="text" style="background-color:#variables.EAColor#" name="eMailAddress" typeahead="yes" width="150 px" showautosuggestloadingicon="false" autosuggest="false" maxlength="22" value="#populateFieldsRet.emailaddress#" ></td>
  <td><input type="text" name="PhoneNumber" typeahead="yes" width="150 px" showautosuggestloadingicon="false" autosuggest="false" maxlength="22" value="#populateFieldsRet.PhoneNumber#" ></td>
  <td align="right">&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td><em>eMail Address<span class="style4"> *</span></em></td>
  <td><em>Phone Number</em></td>
  <td align="right">&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td><br /></td>
  <td class="style2">Checkout System</td>
  <td align="right"><img src="images/icons/CheckOutButtonNext.jpg" onClick="sF()" border="0" /></td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td bgcolor="##FFFFFF">&nbsp;</td>
  <td colspan="3" bgcolor="##004400">&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td colspan="3">Your order is important to us please get it right! Double check your typing so that you can get the products you've ordered! Be sure that everything has been spelled correctly Thank You!</td>
<td width="10">&nbsp;</td>
</tr>
</cfform>
</cfoutput>
</table>
</body>
</html>