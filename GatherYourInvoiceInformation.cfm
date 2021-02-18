<cfparam default="" name="variables.msg" type="string">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Enter Your Mailing Address</title>
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

<cfquery name="SelectAll" datasource="warehouse">
select *
from orders
where OrderNumber = '#Cookie.OrderNumber#'
</cfquery>

<cfset migiCart = session.cart.getCart()>
<cfset a=false>
<cfset length=#arraylen(migiCart)#>

<cfquery name="SelectAll" datasource="warehouse">
select *
from orders
where OrderNumber = '#Cookie.OrderNumber#'
</cfquery>

<link href="UniversalFormatterTwo.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {font-size: 12px}
.style2 {	font-size: 14px;
	font-style: italic;
}
.style3 {font-size: 18px}
.style4 {font-size: 14px}
.style6 {font-size: 18px; color: #666666; }
-->
</style>
</head>
<body>
<cfoutput>
<cfform>
<table width="1000" class="ArialStoreGreyBold" border="1" bordercolor="##FFFFFF" bgcolor="##FFFFFF">
<cfif not variables.msg eq "">
<tr bgcolor="##FFAA66" bordercolor="##999999" >
<td height="50" colspan="7">&nbsp;<cfoutput>#variables.msg#</cfoutput></td>
</tr>
</cfif>
<tr>
<td colspan="7"><br />
  <cfinput type="button" name="MakePDF" value="Print - Make PDF - Print" onClick="window.open('https://secure.reliablecleanroomproducts.com/invoiceConfirmationPDF.cfm?UUID=#Cookie.OrderNumber#','window1')"></td>
</tr>
<tr>
<td height="61" colspan="7" class="ArialStore">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <cfif structkeyexists(cookie, "UserID") and not cookie.UserID eq ""><cfoutput>Thank You #populateFieldsRet.FirstName# #populateFieldsRet.LastName# You are a #populateFieldsRet.AccessType# Member! Please Update The Your Information in the Forms Below and Feel Free to Contact Us at our Customer Support Line. </cfoutput></cfif></td>
</tr>
<tr>
<td width="1"></td>
<td colspan="3"></td>
<td width="256"></td>
</tr>
<tr>
<td>&nbsp;</td>
<td colspan="3"><strong>Gather Your Invoice Information:</strong></td>
<td width="256">&nbsp;</td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td colspan="4"><p class="ArialStoreTitle">DiscountSoccerSupply.com - CA</p>      </td>
    <td width="188" valign="top"><p class="ArialStoreTitle">Invoice</p></td>
    <td colspan="2" >&nbsp;</td>
    </tr>
    <tr>
    <td height="72">&nbsp;    </td>
    <td height="72" colspan="2" valign="top"><span class="style2">Billing Address<br><br></span>#SelectAll.FirstName# #SelectAll.LastName# <br>
      #SelectAll.CompanyName# <br>
#SelectAll.Street#<br>
#SelectAll.City#&nbsp;#SelectAll.State#,&nbsp;#SelectAll.Zip#</td>
    <td height="72">&nbsp;</td>
    <td height="72">&nbsp;</td>
    <td height="72" bordercolor="##999999" valign="top"><br>
    <p><strong>&nbsp;&nbsp;Invoice Date </strong><br>
      &nbsp;&nbsp;#SelectAll.Date#</p>
      <p><strong>&nbsp;&nbsp;Invoice Type: </strong><br>&nbsp;&nbsp;Purchase</p></td>
    <td height="72" colspan="2">&nbsp;</td>
    </tr>
  <tr>
  
    <td width="20" height="76" rowspan="2">&nbsp;</td>
    <td height="76" colspan="2" align=-"center" valign="top"><p>&nbsp;</p>
      <p>&nbsp;</p></td>
    <td colspan="5" align="center" valign="top">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="5" align="left" valign="top" class="ArialStore">Thank you for being a prefered customer! Your Order has been accepted! Please keep a copy of this <br> page for you records.</td>
  </tr>
  <tr>
    <td height="40" align="center" class="style1">&nbsp;</td>
    <td colspan="5" align="center" class="ArialStore">
      <p class="style3">OrderNumber: #SelectAll.OrderNumber#</p></td>
    <td colspan="2" align="center" class="style1">&nbsp;</td>
  </tr>
  
   <tr>
        <td colspan="2"></td>
        <th align="left">Items</th>
        <th width="236" align="left">&nbsp;</th>
      <th width="137" align="left">Quantity</th>
      <th align="left">Unit Price</th>
    </tr>
        <cfset ItemNumbers=ArrayNew(1)>
        <cfset Prices=ArrayNew(1)>
        <cfset Quantities=ArrayNew(1)>
        <cfset obj = createObject("component", "titlesTwo").init(SelectAll.OrderNumber)>
        <cfset ItemNumbers=obj.getItemNumbers()>
        <cfset Prices=obj.getPrices()>
        <cfset Quantities=obj.getQuantities()>
        <cfset subtotal=0>
        <cfloop from="1" to="#arraylen(ItemNumbers)#" index="counter">
        <cfset subtotal= #variables.subtotal# + (#Prices[counter]# * #Quantities[counter]#)>
        <cfquery name="getDescription" datasource="warehouse">
        select Description, ItemName
        from Itemssc
        where ItemNumber = '#ItemNumbers[counter]#'        
        </cfquery>
        <tr height="20">
          <td colspan="2"></td>
          <td width="183">#ItemNumbers[counter]# #getDescription.ItemName#</td>
          <td>#left(getDescription.Description ,25)#</td>
          <td>#Quantities[counter]#</td>
          <td colspan="3">#Prices[counter]#</td>
        </tr>
      </cfloop>
	  <cfset Tax = .0825 * #variables.subtotal#>
	  <cfset Total = #variables.tax# + #variables.subtotal# + #SelectAll.Shipping#>
  	  <cfset total = dollarformat(variables.Total)> 
      <tr>
        <td colspan="2"></td>
        <td></td>
        <td colspan="2">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2"></td>
        <td colspan="2" rowspan="4" valign="top" bordercolor="##999999" class="ArialStore"><br><span class="style3">&nbsp;&nbsp;Customer Service</span><br> 
          &nbsp;&nbsp; If you have any questions about your order please call Reliable<br>
          &nbsp;&nbsp; Cleanroom Products at:<br><p class="style3 style4">&nbsp;&nbsp;1(909)919-7970</p>
          <span class="style3">&nbsp;&nbsp;Please Make Checks Payable To:</Span><br>
          &nbsp;&nbsp; Reliable Cleanroom Products<br>
          &nbsp;&nbsp; C/O Internet Sales<br>
          &nbsp;&nbsp; Street Address<br>
          &nbsp;&nbsp; City, ST Zip<br>        </td>
        <td>&nbsp;&nbsp;Sub-Total:</td>
        <td colspan="3">#dollarformat(variables.subtotal)#</td>
      </tr>
      <tr>
        <td colspan="2"></td>
        <td>&nbsp;&nbsp;Shipping</td>
        <td colspan="3">#dollarformat(SelectAll.Shipping)#</td>
      </tr>
      <tr>
        <td colspan="2"></td>
        <td>&nbsp;&nbsp;Tax:</td>
        <td colspan="3">#dollarformat(variables.tax)#</td>
      </tr>
      <tr>
        <td colspan="2"></td>
        <td>&nbsp;&nbsp;<strong>Total:</strong></td>
        <td colspan="3"><strong>#variables.total#</strong></td>
      </tr>
      <tr>
        <td colspan="2"></td>
        <td>&nbsp;</td>
        <td colspan="2"></td>
        <td colspan="3"></td>
      </tr>
       <tr>
         <td></td>
         <td width="31">&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td>&nbsp;</td>
         <td colspan="3"></td>
       </tr>
       <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td width="20">&nbsp;</td>
        <td width="1">&nbsp;</td>
      </tr>
<tr>
  <td>&nbsp;</td>
  <td width="3">&nbsp;</td>
  <td width="214">&nbsp;</td>
  <td width="216" align="right"><span class="style2">Checkout System</span></td>
  <td width="256" align="right">&nbsp;</td>
  <td width="160" align="right">&nbsp;</td>
  <td width="90" align="right">&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
<td>&nbsp;</td>
<td colspan="7">&nbsp;</td>
<td width="1">&nbsp;</td>
</tr>
</table>
</cfform>
</cfoutput>
</body>
</html>
<cfcookie name="OrderNumber" expires="now" secure="yes">
<cfset structdelete(session, "cart")>