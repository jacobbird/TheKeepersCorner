<cfcomponent>
	
    <cffunction name="CreateANewOrder" access="public" returntype="string">
		
        <cfquery name="qOrderNumbers" datasource="discountsoccer">
		select OrderNumber
		from orders
		</cfquery>

		<cfset newOrderNumber = 1>
		
		<cfloop query="qOrderNumbers">
		<cfif numberFormat(qOrderNumbers.OrderNumber) gte newOrderNumber>
			<cfset newOrderNumber = numberFormat(qOrderNumbers.OrderNumber) + 1>
		</cfif>
		</cfloop>
        
        
        <cfset newOrderNumber2 = ToString(newOrderNumber)>
		
        <cfquery name="NewOrder" datasource="discountsoccer">
        insert into orders(OrderNumber)
        values('#variables.newOrderNumber2#')               
        </cfquery>
		
        <cfreturn variables.newOrderNumber2>
        
	</cffunction>
    
    <cffunction name="UpdateMailingInformation" access="public" returntype="string">
		
        <cfargument name="form" type="struct" required="yes">
        	<cfif not form.FirstName eq "">
            <cfif not form.LastName eq "">
            <cfif not form.Street eq "">
            <cfif not form.City eq "">
            <cfif not form.State eq "">
			<cfif not form.Zip eq ""> 
                       
			<cfif form.accessType eq "Standard" or form.accessType eq "Preferred">
            
            <cfquery name="updateCustomersInfo" datasource="discountsoccer">
				update customersinfo
				set MailFirstName='#form.FirstName#', MailLastName='#form.LastName#', MailMiddleInitial='#form.MiddleInitial#', MailCompanyName='#form.CompanyName#', MailStreet='#form.Street#', MailCity='#form.City#', MailState='#form.State#', MailZip='#form.Zip#'
				where UserID= '#form.UserID#'
			</cfquery>
            
            </cfif>
            
            <cfquery name="updateOrders" datasource="discountsoccer">
				update Orders
				set MailFirstName='#form.FirstName#', MailLastName='#form.LastName#', MailMiddleInitial='#form.MiddleInitial#', MailCompanyName='#form.CompanyName#', MailStreet='#form.Street#', MailCity='#form.City#', MailState='#form.State#', MailZip='#form.Zip#'
				where OrderNumber= '#form.OrderNumber#'
			</cfquery>
            
			<cfset msg="">            
            <cfelse>
            <cfset msg="Err: It appears that the ""Zip"" field is blank please fill in a valid ""Zip"" and press Next">
			</cfif>
            <cfelse>
            <cfset msg="Err: It appears that the ""State"" field is blank please fill in a valid ""State"" and press Next">
			</cfif>
            <cfelse>
            <cfset msg="Err: It appears that the ""City"" field is blank please fill in a valid ""City"" and press Next">
			</cfif>
            <cfelse>
            <cfset msg="Err: It appears that the ""Street"" field is blank please fill in a valid ""Street"" and press Next">
			</cfif>
            <cfelse>
            <cfset msg="Err: It appears that the ""Last Name"" field is blank please fill in a valid ""Last Name"" and press Next">
			</cfif>
            <cfelse>
            <cfset msg="Err: It appears that the ""First Name"" field is blank please fill in a valid ""First Name"" and press Next">
			</cfif>

		<cfreturn variables.msg>
	</cffunction>
    
    <cffunction name="UpdateBillingInformation" access="public" returntype="string">
		
        <cfargument name="form" type="struct" required="yes">
        	<cfif not form.FirstName eq "">
            <cfif not form.LastName eq "">
            <cfif not form.Street eq "">
            <cfif not form.City eq "">
            <cfif not form.State eq "">
			<cfif not form.Zip eq "">          
			
			<cfif form.accessType eq "Standard" or form.accessType eq "Preferred">
            
            <cfquery name="updateCustomersInfo" datasource="discountsoccer">
				update customersinfo
				set FirstName='#form.FirstName#', LastName='#form.LastName#', MiddleInitial='#form.MiddleInitial#', CompanyName='#form.CompanyName#', Street='#form.Street#', City='#form.City#', State='#form.State#', Zip='#form.Zip#'
				where UserID= '#form.UserID#'
			</cfquery>
            </cfif>
            
            <cfquery name="updateOrders" datasource="discountsoccer">
				update Orders
				set FirstName='#form.FirstName#', LastName='#form.LastName#', MiddleInitial='#form.MiddleInitial#', CompanyName='#form.CompanyName#', Street='#form.Street#', City='#form.City#', State='#form.State#', Zip='#form.Zip#'
				where OrderNumber= '#form.OrderNumber#'
			</cfquery>
            <cfset msg="">
            
            <cfelse>
            <cfset msg="Err: It appears that the ""Zip"" field is blank please fill in a valid ""Zip"" and press Next">
			</cfif>
            <cfelse>
            <cfset msg="Err: It appears that the ""State"" field is blank please fill in a valid ""State"" and press Next">
			</cfif>
            <cfelse>
            <cfset msg="Err: It appears that the ""City"" field is blank please fill in a valid ""City"" and press Next">
			</cfif>
            <cfelse>
            <cfset msg="Err: It appears that the ""Street"" field is blank please fill in a valid ""Street"" and press Next">
			</cfif>
            <cfelse>
            <cfset msg="Err: It appears that the ""Last Name"" field is blank please fill in a valid ""Last Name"" and press Next">
			</cfif>
            <cfelse>
            <cfset msg="Err: It appears that the ""First Name"" field is blank please fill in a valid ""First Name"" and press Next">
			</cfif>

		<cfreturn variables.msg>
	</cffunction>
    
    <cffunction name="UpdateCreditCardInformation" access="remote" returntype="string">
		<cfargument name="form" type="struct" required="yes">
		<cfif  not form.CCNumber eq ""><!--6-->		
		<cfif  not form.CCNameOnCard eq ""><!--5-->		
		<cfif not form.CCDate eq ""><!--4-->		
		<cfif not form.CCthreeDigit eq ""><!--3-->
		<cfset form.CCnumberlastfour = "XXXX XXXX XXXX " & right("#form.CCNumber#",4)>
		<cfif not form.CCType eq "Select">
        <cfif not form.emailAddress eq "">
        
        <cfquery name="updateOrders" datasource="discountsoccer">
				update Orders
				set CCNumber='#form.CCNumber#', CCNameOnCard='#form.CCNameOnCard#', CCDate='#form.CCDate#', CCthreedigit='#form.CCthreedigit#', CCnumberlastfour='#form.CCNumberLastFour#', CCtype='#form.CCtype#', emailAddress='#form.emailAddress#', Phonenumber='#form.phoneNumber#'
				where OrderNumber= '#form.OrderNumber#'
		</cfquery>
		
		<cfif form.KeepMyCardInfoOnFile eq "no">
        <cfset form.ccnumber = "">
        <cfset form.ccnameoncard = "">
        <cfset form.ccdate = "">
        <cfset form.ccthreedigit = "">
        <cfset form.ccnumberlastfour = "">
        <cfset form.cctype = "">
        </cfif>
        
        <cfif form.accessType eq "Standard" or form.AccessType eq "Preferred" >
            <cfquery name="updateCustomersInfo" datasource="discountsoccer">
				update customersinfo
				set CCNumber='#form.CCNumber#', CCNumberLastFour='#form.CCNumberLastFour#', CCNameOnCard='#form.CCNameOnCard#', CCDate='#form.CCDate#', CCthreedigit='#form.CCthreedigit#', CCnumberlastfour='#form.CCNumberLastFour#', CCtype='#form.CCtype#', emailAddress='#form.emailAddress#', Phonenumber='#form.phoneNumber#'
				where UserID= '#form.UserID#'
			</cfquery>
         </cfif>
         
         
            
		<cfset msg="">
        <cfelse>
        <cfset msg="Err: It appears that the ""eMailAddress"" field is blank please fill in a valid ""eMailAddress"" and press Next">
		</cfif>
        <cfelse>
        <cfset msg="Err: It appears that the ""Credit Card Type"" field is blank please fill in a valid ""Credit Card Type"" and press Next">
		</cfif>
        <cfelse>
        <cfset msg="Err: It appears that the ""Three Digits"" field is incorrect please fill in a valid ""Three Digits"" and press Next">
		</cfif>
        <cfelse>
        <cfset msg="Err: It appears that the ""Expiration Date"" field is blank please fill in a valid ""Expiration Date"" and press Next">
		</cfif>
        <cfelse>
        <cfset msg="Err: It appears that the ""Name On Card"" field is blank please fill in a valid ""Name On Card"" and press Next">
		</cfif> 
        <cfelse>
        <cfset msg="Err: It appears that the ""Credit Card Number"" field is incorrect please fill in a valid ""Credit Card Number"" and press Next">
		</cfif>
        
		<cfreturn variables.msg>
	</cffunction>
    
    <cffunction name="UpdateContactInformation" access="public" returntype="string">
		<cfargument name="form" type="struct" required="yes">
		<cfif  not form.eMailAddress eq "">	
        <cfif  not form.PhoneNumber eq "">
		<cfif form.accessType eq "Preferred">
            
            <cfquery name="updateCustomersInfo" datasource="discountsoccer">
				update customersinfo
				set eMailAddress='#form.eMailAddress#', PhoneNumber='#form.PhoneNumber#', PhoneNumber2='#form.PhoneNumber2#'
				where UserID= '#form.UserID#'
			</cfquery>
            
        </cfif>
            
            <cfquery name="updateOrders" datasource="discountsoccer">
				update Orders
				set eMailAddress='#form.eMailAddress#', PhoneNumber='#form.PhoneNumber#', PhoneNumber2='#form.PhoneNumber2#'
				where OrderNumber= '#form.OrderNumber#'
			</cfquery>
		<cfset msg="">
        <cfelse>
        <cfset msg="Err: It appears that the ""Phone Number One"" field is blank please fill in a valid ""eMail Address"" and press Next">
		</cfif>
        <cfelse>
        <cfset msg="Err: It appears that the ""eMail Address"" field is blank please fill in a valid ""eMail Address"" and press Next">
		</cfif>
		<cfreturn variables.msg>
	</cffunction>
    
    <cffunction name="AddTheCartInformation" access="public" returntype="string">
		<cfargument name="form" type="struct" required="yes">
		  <cfif  not form.tax eq "">
          <cfif  not form.shipping eq "">
          <cfif  not form.total eq "">
          <cfif  not form.items eq "">
         
            <cfquery name="updateOrders" datasource="discountsoccer">
				update Orders
				set Tax='#form.Tax#', Shipping='#form.Shipping#' , Total='#form.Total#', Items='#form.Items#', Date='#form.Date#', DateAdjusted='#form.DateAdjusted#', UserID='#Cookie.UserID#'
				where OrderNumber= '#form.OrderNumber#'
			</cfquery>
		<cfset msg="">
        <cfelse>
        <cfset msg="Err: An Error has occured sometimes caused by taking too long to complete the order, Please refresh you cart and try again!" >
		</cfif>
        <cfelse>
        <cfset msg="Err: An Error has occured sometimes caused by taking too long to complete the order, Please refresh you cart and try again!">
		</cfif>
        <cfelse>
        <cfset msg="Err: An Error has occured. Please check to be sure that you address information is correct. Only addresses inside of the United states will work! Sorry for any inconvienience">
		</cfif>
        <cfelse>
        <cfset msg="Err: An Error has occured sometimes caused by taking too long to complete the order, Please refresh you cart and try again!">
		</cfif>
              
		<cfreturn variables.msg>
	</cffunction>
    
</cfcomponent>