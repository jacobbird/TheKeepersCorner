<link href="UniversalFormatterTwo.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {
	font-size: 18;
	color:#AAAAAA;
}
-->
</style>
<table>
<cfinvoke 
 component="itemsGateway"
 method="getAllAsQuery"
 returnvariable="getAllAsQueryRet"></cfinvoke>
	<cfset startrowItems = round(rand() * getAllAsQueryRet.RecordCount) + 1 >
	<cfset endrowItems = startrowItems + 2>
	<cfoutput>
	  <cfloop query="getAllAsQueryRet" startrow="#startrowItems#" endrow="#endrowItems#">
    	<tr>
     		<td class="ArialStoreWhite" align="center"><h4 class="style1">#getAllAsQueryRet.ItemName#</h4>
  <h4><a href="ItemsPageInitializer.cfm?ItemNumber=#getAllAsQueryRet.ItemNumber#&category=#getAllAsQueryRet.Category#"><img src="Items/#getAllAsQueryRet.ItemNumber#.gif" 
          	     alt="items"  height="75" border="0"/></a><br />
                  </h4>
							<cfif StructKeyExists(COOKIE, "AccessType") and COOKIE.AccessType eq "Preferred">
                      		  	<h4><span class="style5"><s>#dollarformat(getAllAsQueryRet.Prices)#/#getAllAsQueryRet.sizeSML#</s><br>
	  	    #dollarformat(getAllAsQueryRet.PreferedPrice)#/#getAllAsQueryRet.sizeSML#</span></h4>
							<cfelse>
                     		  	<strong>#dollarformat(getAllAsQueryRet.prices)#/#getAllAsQueryRet.sizeSML#</strong>
                                <span class="style5"><br>
			      	 		  	</span>
				  			</cfif>
							<cfif getAllAsQueryRet.Quan lt 1 >
  								<p class="OutOfStock">Out of Stock</p>
  							<cfelse>
  								<cfform name="form" method="post" 
            					action="Store.cfm?action=buy&Key=#getAllAsQueryRet.ItemNumber#&ItemNumber=#getAllAsQueryRet.ItemNumber#&category=#getAllAsQueryRet.Category#">Qty: 
  								<cfinput type="text" name="quantity" size="2" value="0" mask="99">
  								<br />
  								<cfinput name="submit" type="submit" value="Add To Cart">
  								<br />
  								<br />
  								</cfform>
								</cfif>
                            </td>
    					</tr>
      				</cfloop>
    			</cfoutput>
</table>
