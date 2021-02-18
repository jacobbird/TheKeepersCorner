<html>
<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
<body>
<cfoutput>
<cfset migiCart = session.cart.getCart()>
<cfset a=false>
<cfset length=#arraylen(migiCart)#>
<cfset structdelete(session, "cart")>
<cfset total = 0>
<cfset subtotal=0>
        <cfloop from="1" to="#variables.length#" index="counter">
		<cfset subtotal= #variables.subtotal# + (#migiCart[counter].price# * #migiCart[counter].quantity#)>
		</cfloop>
	<cfset Tax = .082 * #variables.subtotal#>
	<cfset Total = #variables.tax# + #variables.subtotal#>
    <table width="730" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="141">&nbsp;</td>
        <td width="409" colspan="3">&nbsp;</td>
        <td width="180">&nbsp;</td>
      </tr>
      <tr>
        <td height="97">&nbsp;</td>
        <td valign="top" colspan="3"><p>Thank You! Using DiscountSoccersupply.com! Your Order for #variables.total# has been accepted! Thank you for your payment Orders are Shipped Daily! To return to the store <a href="store.cfm">click here</a></p>       </td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="6" align="center" class="style1">Reliable Cleanroom Receipt: #url.customer# </td>
      </tr>
      <tr>
        <td colspan="6" align="center" class="style1">&nbsp; </td>
      </tr>
      
        <tr>
        <td colspan="2"></td>
        <th align="left">Items</th>
        <th align="left">Price Per Item</th>
        <th align="left">Quantity</th>
        </tr>
        <cfloop from="1" to="#arraylen(migiCart)#" index="counter">
        <tr height="20">
          <td colspan="2"></td>
          <td width="279">#migiCart[counter].ItemName.getItemName()# </td>
          <td width="276">#dollarformat(migiCart[counter].ItemName.getPrice())#</td>
          <td colspan="2">#migiCart[counter].quantity#</td>
        </tr>
      </cfloop>
      <tr>
        <td colspan="2"></td>
        <td></td>
        <td>&nbsp;</td>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2"></td>
        <td></td>
        <td>Sub-Total:</td>
        <td colspan="2">#dollarformat(variables.subtotal)#</td>
      </tr>
      <tr>
        <td colspan="2"></td>
        <td></td>
        <td>Tax:</td>
        <td colspan="2">#dollarformat(variables.tax)#</td>
      </tr>
      <tr>
        <td colspan="2"></td>
        <td></td>
        <td><strong>Total:</strong></td>
        <td colspan="2">#dollarformat(variables.total)#</td>
      </tr>
      <tr>
        <td colspan="2"></td>
        <td></td>
        <td></td>
        <td colspan="2"></td>
      </tr>
      <tr>
        <td colspan="2">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2">&nbsp;</td>
        <td colspan="2" align="center">Please make a copy of this Receipt for your records and have an nice day!</td>
      </tr>
    </table>
</cfoutput>
</body>
</html>