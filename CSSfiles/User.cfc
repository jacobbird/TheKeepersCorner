<cfcomponent output="false">

	<cfproperty name="UserAttributes" type="array" default="arraynew(1)" />

	<cfscript>
		variables.UserAttributes = arraynew(1);
	</cfscript>

	<cffunction name="addUserId" access="public" output="false" returntype="void">
		
        <cfargument name="id" required="true" >
		
		<cfscript>
			var ItemName = CreateObject("component", "UserGateway").
				getID(arguments.id);
			arrayappend(migiCart, structnew());
			index = arraylen(migiCart);
			migiCart[index].ItemName = ItemName;
			migiCart[index].quantity = 1;
		</cfscript>
		
		<cfreturn />
	</cffunction>

	<cffunction name="removeItem" access="public" output="false" returntype="void">
		<cfargument name="position" required="true" type="numeric">
		
		<cfset arraydeleteat(migiCart, arguments.position)>
		
	</cffunction>

	<cffunction name="getCart" access="public" output="false" returntype="Array">
		<cfreturn variables.migiCart/>
	</cffunction>

</cfcomponent>