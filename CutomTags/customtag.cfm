<!--- The custom tag syntax for array compairator 01 by: Jacob H. Bird --->
<cfoutput>
<cfargument name="array" type="array" hint="The array to be compaired against">
<cfparam name="URL.compares" default="" type="string">
<cfset marker=false>
<cfloop from="1" to="#arraylen(#array#)#"  index="counter">
<cfset name[counter]= #migiCart[counter].ItemName.getItemName()#>
</cfloop>
<cfflush>
<cfloop from="1" to="#arraylen(#array#)#"  index="counter">
<cfif #variables.name[counter]# eq #URL.compares#>
<cfset marker=true>
<cfset index eq [counter]>
</cfif>
<cfif #variables.marker# eq true>
<cfscript>
arrayappend(#Arguments.array#,structnew())
migiCart[#variables.index#].quantity = migiCart[#variables.index#].quantity + 1;
</cfscript>
</cfif>
</cfloop>
</cfoutput>