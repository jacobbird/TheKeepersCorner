<cfset migiCart = session.cart.getCart()>
<cfset totalweight=0>
<cfset subtotal=0>

	<cfloop from="1" to="#arraylen(migicart)#" index="counter">
    <cfset ItemNumber=#Trim(migiCart[counter].ItemName.getItemNumber())#>
    	<cfquery name="getWeight" datasource="discountsoccer">
			SELECT weight
            FROM Itemssc
            WHERE ItemNumber = '#ItemNumber#'
		</cfquery>
		<cfset subtotal = #variables.subtotal# + (#migiCart[counter].price# * #migiCart[counter].quantity#)>       
		<cfset totalWeight = #totalWeight# + (#GetWeight.Weight# * #migiCart[counter].quantity#)>
	</cfloop>
    
<cfset Tax = round(8.25 * #variables.subtotal#)>
<cfset Tax = Tax/100>
<cfset Total = #variables.tax# + #variables.subtotal#>

<cfparam name="url.action" type="string" default="">
<cfparam name="variables.msg" type="string" default="">
<cfparam name="cookie.UserID" type="string" default="">
<cfparam name="form.FirstName" type="string" default="">
<cfparam name="form.SandHSelectBox" type="string" default="03">

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
populateFieldsRet.MailCompanyName = "";
populateFieldsRet.MailFirstName = "";
populateFieldsRet.MailLastName = "";
populateFieldsRet.MailMiddleInitial = "";
populateFieldsRet.MailStreet = "";
populateFieldsRet.MailCity = "";
populateFieldsRet.MailState = "";
populateFieldsRet.MailZip = "";
populateFieldsRet.eMailAddress = "";
populateFieldsRet.PhoneNumber = "";
populateFieldsRet.PhoneNumber2 = "";
populateFieldsRet.AccessType = "";
variables.msg2 = "";
</cfscript>

<cfquery name="getAccessType" datasource="discountsoccer">
select AccessType
from customersinfo
where UserID='#Cookie.UserID#'
</cfquery>

<cfif url.action eq "Next">  
<cfif form.captchaTextField eq form.captchaHiddenField>	
<cf_tsconverter returnvariable="convertedDate">
	<cfscript>
		form.OrderNumber = Cookie.OrderNumber;
		form.UserID = Cookie.UserID;
		form.AccessType = getAccessType.AccessType;
		form.dateadjusted = variables.convertedDate;
	</cfscript>	
	
    <cfinvoke component="asyncFormHandler" method="AddTheCartInformation" >
    	<cfinvokeargument name="form" value="#form#">
    </cfinvoke>
    
    <cfset ItemNumbers=ArrayNew(1)>
    <cfset Prices=ArrayNew(1)>
    <cfset Quantities=ArrayNew(1)>
    <cfset obj = createObject("component", "titlesTwo").init(form.OrderNumber)>
    <cfset ItemNumbers=obj.getItemNumbers()>
    <cfset Prices=obj.getPrices()>
    <cfset Quantities=obj.getQuantities()>	
    
   	<cfloop from="1" to="#ArrayLen(Quantities)#" index="counter">
    	
        <cfquery name="findQuantity" datasource="discountsoccer" >
        	select Quan
        	from itemssc
        	where ItemNumber = '#ItemNumbers[counter]#'
        </cfquery> 
        
        <cfset newQuantity = findQuantity.Quan - Quantities[counter]>
        
        <cfquery name="findQuantity" datasource="discountsoccer" >
        	update itemssc
        	set Quan = '#variables.newQuantity#'
        	where ItemNumber = '#ItemNumbers[counter]#'
        </cfquery>

    </cfloop>
	 
	<cfif Cookie.AccessType eq "preferred"> 
		<cflocation url="http://www.discoutnsoccersupply.com/GatherYourInvoiceInformation.cfm">  
	<cfelse>
		<cflocation url="http://www.discoutnsoccersupply.com/GatherYourReceiptInformation.cfm">  
	</cfif>
</cfif>
</cfif>
	
    <cfinvoke 
 	 component="CheckoutComponent"
 	 method="retrievecustomerinformation"
 	 returnvariable="populateFieldsRetTwo">
 		<cfinvokeargument name="Arg" value="#Cookie.UserID#" />
	</cfinvoke>

	<cfinvoke 
 	 component="CheckoutComponent"
 	 method="retrieveorderinformation"
 	 returnvariable="populateFieldsRet">
 		<cfinvokeargument name="Arg" value="#Cookie.OrderNumber#" />
	</cfinvoke>

<cfscript>
switch(form.SandHSelectBox){
case "01":{SelectedShippingService = "UPS - Next Day Air"; break;}
case "02":{SelectedShippingService = "UPS - 2nd Day Air"; break;}
case "03":{SelectedShippingService = "UPS - Ground"; break;}
case "12":{SelectedShippingService = "UPS - 3rd Day Select"; break;}
default:{SelectedShippingService = "UPS - Ground"; break;}
}
</cfscript>

<cfoutput>
	<cf_usupsshippingratecalculator ShipToWeight="#TotalWeight#" ShipToService="03" ShipToZip="#populateFieldsRet.MailZip#" ReturnVariable="ShippingRate"/>
    
	<cfif url.action eq "ChangeShippingService">
 		<cf_usupsshippingratecalculator ShipToWeight="#TotalWeight#" ShipToService="#form.SandHSelectBox#" ShipToZip="#populateFieldsRet.MailZip#" ReturnVariable="ShippingRate"/>
        <cfquery datasource="discountsoccer" name="update">
        UPDATE orders
        SET shippingMethod = '#form.SandHSelectBox#'
        WHERE orderNumber = '#Cookie.OrderNumber#'
        </cfquery>
	</cfif>

</cfoutput>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Enter Your Mailing Address</title>

<script>
	function sF() {
		form.submit();
	}
	function redo() {
    	window.open('http://www.discountsoccersupply.com/EnterYourMailingAddress.cfm','_self')
    }

</script>

<style type="text/css">
<!--
.style2 {	font-size: 14px;
	font-style: italic;
}
.style3 {
	color: #666666;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<table width="1040" height="1433" border="1" bordercolor="#666666" bgcolor="#FFFFFF">
  <cfif not variables.msg eq "">
    <tr bgcolor="#FFAA66" bordercolor="#999999" class="ArialStore" >
      <td height="50" colspan="6">&nbsp;<cfoutput>#variables.msg# Also reselect the shipping option of your choice!</cfoutput></td>
    </tr>
  </cfif>
  <cfoutput>
    
      <tr>
        <td colspan="6"><img src="images/Area Fill/CheckoutStepFour.jpg"/></td>
      </tr>
      <cfif structkeyexists(cookie, "UserID") and not cookie.UserID eq "">
        <tr>
          <td height="61" colspan="6" class="ArialStore"><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <cfoutput>Thank You #populateFieldsRetTwo.FirstName# #populateFieldsRetTwo.LastName# You are a #populateFieldsRetTwo.AccessType# Member! Please Update The Your Information in the Forms Below and Feel Free to Contact Us at our Customer Support Line. </cfoutput></td>
        </tr>
      </cfif>
      <tr>
        <td colspan="6"></td>
      </tr>
      <tr>
        <td colspan="8" bgcolor="##FFFFFF"><span class="style3">Please Check To Be Sure That The Information You Have Entered Is Correct: </span></td>
      </tr>
      <tr>
        <td colspan="8" bgcolor="005500"><br /></td>
      </tr>
      <tr>
        <td colspan="6">
        <table width="100%">
          <tr>
            <td>&nbsp;</td>
            <td colspan="2"><img src="images/Area Fill/275Wide.gif" alt="" width="275" height="15" /></td>
            <td colspan="2"><img src="images/Area Fill/275Wide.gif" width="275" height="15" /></td>
            <td colspan="2"><img src="images/Area Fill/275Wide.gif" alt="" width="275" height="15" /></td>
          </tr>
          <tr>
            <td width="1">&nbsp;</td>
            <td colspan="2" valign="top"><strong>eMail:</strong> #PopulateFieldsRet.EmailAddress#</td>
            <td colspan="2" align="left" valign="top"><strong>Phone:</strong>&nbsp;#PopulateFieldsRet.PhoneNumber#<br />
              #PopulateFieldsRet.PhoneNumber2#</td>
            <td></td>
            <td width="280" valign="top"><cfif structKeyExists(Cookie, "UserID") and not Cookie.UserId eq "">
              <strong>UserID:</strong> #Cookie.UserID#
            </cfif></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td width="36" valign="top"><strong>Mail To:</strong></td>
            <td width="256" rowspan="4" align="left" valign="top">
            &nbsp;#PopulateFieldsRet.MailFirstName#<br />&nbsp;#PopulateFieldsRet.MailLastName#<br />
              &nbsp;
              <cfif not PopulateFieldsRet.MailCompanyName eq "">
                #PopulateFieldsRet.MailCompanyName#
              </cfif>
              <br />
              &nbsp;#PopulateFieldsRet.MailStreet#<br />
              &nbsp;#PopulateFieldsRet.MailCity#, <br />&nbsp;#PopulateFieldsRet.MailState#<br />&nbsp;#PopulateFieldsRet.MailZip#</td>
            <td width="30" valign="top"><strong>Bill To:</strong></td>
            <td width="225" rowspan="4" align="left" valign="top">&nbsp;#PopulateFieldsRet.FirstName#<br />&nbsp;#PopulateFieldsRet.LastName#<br />
              &nbsp;
              <cfif not PopulateFieldsRet.CompanyName eq "">
                #PopulateFieldsRet.CompanyName#
              </cfif>
              <br />
              &nbsp;#PopulateFieldsRet.Street#<br />
              &nbsp;#PopulateFieldsRet.City#,<br />&nbsp;#PopulateFieldsRet.State# <br />&nbsp;#PopulateFieldsRet.Zip#</td>
            <td width="46" valign="top"><cfif not Cookie.AccessType eq "preferred">
              <strong>Credit Card Info:</strong>
            </cfif></td>
            <td rowspan="4" valign="top"><cfif not Cookie.AccessType eq "preferred">
              #PopulateFieldsRet.CCType#<br />
              #PopulateFieldsRet.CCnameoncard# <br />
              #PopulateFieldsRet.CCnumberlastFour# <br />
              #PopulateFieldsRet.CCDate# <br />
              #PopulateFieldsRet.CCThreeDigit#
            </cfif></td>
          </tr>
        </table></td>
      </tr>
      <cfscript>
captchaArray = ArrayNew(1);
captchaArray[1] = "FTLP2";
captchaArray[2] = "CVD32";
captchaArray[3] = "FA122";
captchaArray[4] = "GR234";
captchaArray[5] = "SQ342";
captchaArray[6] = "GG456";
captchaArray[7] = "345FE";
captchaArray[8] = "F45DD";
captchaArray[9] = "L234D";
captchaArray[10]= "GF34Q";
randomNumber = round(rand()*9) + 1;

captchaText = captchaArray[#randomNumber#];

</cfscript>
      <tr>
        <td colspan="6"><br /><br /><h3>Items You've Selected</h3> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="16%"><strong>Part Number</strong></td>
            <td width="19%"><strong>Item Name</strong></td>
            <td width="32%"><strong>Description</strong></td>
            <td width="16%"><strong>Quantity</strong></td>
            <td width="17%"><strong>Price</strong></td>
          </tr>
          <cfset ItemNumber = ArrayNew(1)>
          <cfset Quantity = ArrayNew(1)>
          <cfset Price = ArrayNew(1)>
          <cfset Shipped = ArrayNew(1)>
          <cfoutput>
            <cfloop from="1" to="#arraylen(migiCart)#" index="counter">
              <cfset num = #counter#>
              <cfset ItemNumber[counter] = "#migiCart[counter].ItemName.getItemNumber()#">
              <cfset Quantity[counter] = "#migiCart[counter].quantity#">
              <cfset Price[counter] = "#migiCart[counter].ItemName.getPrice()#">
              <cfset Shipped[counter] = "NotYet">
            </cfloop>
            <cfloop from="1" to="#arrayLen(ItemNumber)#" index="counter">
              <cfquery name="ItemInformation" datasource="discountsoccer">
    	SELECT Description, ItemName
        FROM Itemssc
        WHERE ItemNumber = '#ItemNumber[counter]#'
    </cfquery>
              <tr>
                <td>#ItemNumber[counter]#</td>
                <td>#ItemInformation.ItemName#</td>
                <td>#left(ItemInformation.Description,30)#</td>
                <td>#Quantity[counter]#</td>
                <td>#numberformat(Price[counter],'$____.__')#</td>
              </tr>
            </cfloop>
          </cfoutput>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td align="right">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td align="right">SubTotal: &nbsp;&nbsp;</td>
            <td>#numberformat(SubTotal,'$____.__')#</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td align="right"><cfform name="ShippingandHandeling" action="CheckToBeSureYourInformationIsCorrect.cfm?action=ChangeShippingService">
              <cfselect name="SandHSelectBox" onChange="form.submit()">
                <option value="#SelectedShippingService#">#SelectedShippingService#</option>
                <option value="03">UPS - Ground</option>
                <option value="01">UPS - Next Day Air</option>
                <option value="02">UPS - 2nd Day Air</option>
                <option value="12">UPS - 3rd Day Select</option>
              </cfselect>
            </cfform></td>
            <td align="right">Shipping:&nbsp;&nbsp;</td>
            <td><cfif isNumeric(ShippingRate)>#numberformat(ShippingRate,'$____.__')#<cfelse>Invalid Zip Code</cfif></td>
          </tr>
          <cfif isNumeric(ShippingRate)><cfset Total=Total+ShippingRate><cfelse>Invalid Zip Code</cfif>
          
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td align="right">Tax:&nbsp;&nbsp;</td>
            <td><cfif isNumeric(ShippingRate)>#numberformat(Tax,'$____.__')#<cfelse>Invalid Zip Code</cfif></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td align="right">Total:&nbsp;&nbsp;</td>
            <td><cfif isNumeric(ShippingRate)>#numberformat(Total,'$____.__')#<cfelse>Invalid Zip Code</cfif></td>
          </tr>
        </table></td>
      </tr>
    <form name="form" action="CheckToBeSureYourInformationIsCorrect.cfm?action=Next" method="post" >
      <tr>
        <td width="6">&nbsp;</td>
        <td colspan="5" align="right"><cfimage action="captcha" fontsize="23" text="#captchaText#" difficulty="high" width="200" height="34"/>&nbsp;
          <input type="hidden" name="captchaHiddenField" value="#captchaText#" />
          <input type="text" name="captchaTextField" value="Enter Text Here" /></td>
      </tr>
      <tr>
        <td height="46">&nbsp;</td>
        <td width="6">&nbsp;</td>
        <td width="728"><span class="style2">Checkout System</span></td>
        <td colspan="5" align="right"><img src="images/Area Fill/redo.jpg" width="100" height="42" onClick="window.open('https://secure.ReliableCleanroomProducts.com/EnterYourMailingAddress.cfm','_self')" /><cfif isNumeric(ShippingRate)><img src="images/Area Fill/NextButton.jpg" onClick="form.submit()" border="0" /></cfif></td>
      </tr>
      <tr>
        <td height="39" colspan="8" bgcolor="005500"><br /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td class="ArialStoreGreyBold" colspan="4"><br />Your order is important to us please get it right! Double check your typing so that you can get the products you've ordered! Be sure that everything has been spelled correctly Thank You!</td>
        <td width="176">&nbsp;</td>
      </tr>
      <cfset cartInfo = ArrayNew(1)>
      <cfset cartInfo[1] = ArrayToList(#ItemNumber#)>
      <cfset cartInfo[2] = ArrayToList(#Quantity#)>
      <cfset cartInfo[3] = ArrayToList(#Price#)>
      <cfset cartInfo[4] = ArrayToList(#Shipped#)>
      <cfset cartInfoList = ArrayToList(#cartInfo#, "   - ")>
      <input type="hidden" name="Date" value="#dateformat(now())#" />
      <input type="hidden" name="Tax" value="#variables.Tax#" />
      <input type="hidden" name="Shipping" value="#ShippingRate#"/>
      <input type="hidden" name="Total" value="#variables.Total#" />
      <input type="hidden" name="Items" value="#variables.cartInfoList#" />
    </form>
  </cfoutput>
</table>
</body>
</html>
