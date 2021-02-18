<!-- Copywrite 2009 'Out Of Site Software' -->

<!-- This component hold all of the methods used in the admin page.-->

<cfcomponent displayname="AdministrationComponent" output="no">
      
	<cffunction name="getAdminPass" returntype="query" hint="retrieves the admin password">
    	<cfset key = "mx3op281">
    		<cfquery name="adminpass" datasource="discountsoccer">
    			select password
    			from admin
    			where Number = 1
    				</cfquery> 
    					<cfreturn adminpass/>
							</cffunction>
    
    <cffunction name="adminkey" returntype="string" hint="retrieves the admin key">
    	<cfset key = "mx3op281"> 
    		<cfreturn variables.key>
    			</cffunction>
    
    <cffunction name="getCustomerInformation" returntype="query" hint="Gathers customer information">
    	<cfargument name="SearchParameterOne" type="string" required="no"  default="LastName">
    		<cfargument name="SearchParameterTwo" type="string" required="no" default="">
    			<cfquery name="searcharps" datasource="discountsoccer">
   					select *
    				from customersInfo
    				Where #arguments.SearchParameterOne# like '%#arguments.SearchParameterTwo#%'
    					</cfquery>
    						<cfreturn searcharps/> 
    							</cffunction>
    
    <cffunction name="MakePreferred" returntype="void" hint="Make standard customer a preferred customer.">
    	<cfargument name="UserID" type="string" required="yes" default="">
    		<cfquery datasource="discountsoccer">
    			Update customersInfo
    			Set AccessType='Preferred'
    			WHERE UserID='#arguments.UserID#'
    				</cfquery>
    					</cffunction>
    
    <cffunction name="makeStandard" returntype="void" hint="Make a preferred customer a standard customer.">
    	<cfargument name="UserID" type="string" required="no" default="">
    		<cfquery datasource="discountsoccer">
    			Update customersInfo
    			Set AccessType='Standard'
    			WHERE UserID='#arguments.UserID#'
    				</cfquery>
    					</cffunction>
    
    <cffunction name="getOrderReportInformation" returntype="query" hint="This method is used on admin page one to retieve order information.">
    	<cfargument name="BeginDate" type="String" required="yes"  default="20,090,101">
    		<cfargument name="EndDate" type="String" required="yes" default="42,000,101">
    			<cfquery datasource="discountsoccer" name="orderReportsQuery">
    				select *
    				from orders
    				Where DateAdjusted >= '#arguments.BeginDate#' and
                    DateAdjusted <= '#arguments.EndDate#'                    
    					</cfquery>
    						<cfreturn orderReportsQuery/> 
    							</cffunction>    
									</cfcomponent>