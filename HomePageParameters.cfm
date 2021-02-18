<!--Here follows the code that intitailizes parameters used for function of this page.--> 

<cfparam name="url.key" type="string" default="">
<cfparam default="" name="Cookie.UserID"  type="string">
<cfparam name="url.action" type="string" default="none">
<cfparam name="Form.Search" type="string" default="none">
<cfparam name="variables.vanquish" type="string" default=0>
<cfparam name="variables.q" type="boolean" default="false">
<cfparam name="variables.m" type="numeric" default=0>
<cfparam name="variables.UserName" type="string" default="">

<!-- The following code is used to determine the totals and subtotals for the visual represntation of the car  -->
<cfset migiCart = session.cart.getCart()>
<cfset subtotal=0>
<cfloop from="1" to="#arraylen(migiCart)#" index="counter">
	<cfset subtotal= #variables.subTotal# + (#migiCart[counter].price# * #migiCart[counter].quantity#)>
</cfloop>
<cfparam name="url.startRow" default="1" type="numeric">
<cfset tax = .082 * #variables.subTotal#>
<cfset total = #variables.tax# + #variables.subTotal#>