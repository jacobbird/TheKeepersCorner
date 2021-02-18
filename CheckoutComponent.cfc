<cfcomponent>
	<cffunction name="retrievecustomerinformation" access="remote" returntype="query">
   		<cfargument name="Arg" type="string" default="" required="yes">
   		<cfquery name="retrievecustomerinfo"  datasource="discountsoccer">
   			select *
   			from customersinfo
   			where UserID = '#arguments.Arg#'
   		</cfquery> 
   		<cfreturn retrievecustomerinfo />
   </cffunction>
   
   <cffunction name="retrieveorderinformation" access="remote" returntype="query">
   		<cfargument name="Arg" type="string" default="" required="yes">
   		<cfquery name="retrieveorderinfo"  datasource="discountsoccer">
   			select *
   			from Orders
   			where OrderNumber = '#arguments.Arg#'
   		</cfquery>
   		<cfreturn retrieveorderinfo />
   </cffunction>
   
   <cffunction name="makeSame" access="remote" returntype="struct">
   		<cfargument name="Arg" type="string" default="" required="yes">
   		
        <cfquery name="retrieveorderinfo"  datasource="discountsoccer">
   			select *
   			from Orders
   			where OrderNumber = '#arguments.Arg#'
   		</cfquery> 
        
        <cfscript>
			p = structNew();
			p.Title = "#retrieveorderinfo.MailTitle#";
			p.CompanyName = "#retrieveorderinfo.MailCompanyName#";
			p.FirstName = "#retrieveorderinfo.MailFirstName#";
			p.LastName = "#retrieveorderinfo.MailLastName#";
			p.MiddleInitial = "#retrieveorderinfo.MailMiddleInitial#";
			p.Street = "#retrieveorderinfo.MailStreet#";
			p.City = "#retrieveorderinfo.MailCity#";
			p.State = "#retrieveorderinfo.MailState#";
			p.Zip = "#retrieveorderinfo.MailZip#";
			p.UserID2 = "#Cookie.UserID#";
			variables.msg2 = "";
		</cfscript>
        
   		<cfreturn p/>
   </cffunction>
   
   
</cfcomponent>