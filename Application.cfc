<cfcomponent output="false">

	<cfset this.name="shoppingcart">
	<cfset this.sessionManagement="true">

	<!-- 
     Here is instantiated several cfc files assigned to the application! These files are store in the session an are 
     accessable from anywhere in the application! 
    -->
    
	<cffunction name="onRequestStart">
    
		<cfif isDefined("url.restart")>
			<cfset structdelete(session, "cart")>
				</cfif>
        
		<cfif not isDefined("session.cart")>
			<cfset session.cart=CreateObject("component", "ShoppingCart")>
				</cfif>
        
        <cfif not isDefined("session.cartTwo")>
        	
        	<cfset session.cartTwo=CreateObject("component", "ShoppingCartTwo")>           
        		</cfif>
        
        <cfif isDefined("url.restart")>
        
			<cfset structdelete(session, "cartTwo")>
				</cfif>
        
        <cfif not isDefined("session.sections")>
        	<cfset session.sections=CreateObject("component", "showSections")>           
        		</cfif>
        
        <cfif isDefined("url.restart")>
			<cfset structdelete(session, "sections")>
				</cfif>
        
		<cfif not isDefined("session.rows")>
        	<cfset session.rows=CreateObject("component", "rowsPerPage")>           
        		</cfif>	
                
        <cfif isDefined("url.restart")>
			<cfset structdelete(session, "rows")>
				</cfif>
        
	</cffunction>
    
    
</cfcomponent>