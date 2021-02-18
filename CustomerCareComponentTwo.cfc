<cfcomponent displayname="CustomerCareComponentTwo">

	<cffunction name="UpdateOrderInformation" access="remote" returntype="void" hint="this function updates the Order Information in the Orders Table.">
    <cfargument default="" type="struct" name="s">
    
    <cfquery name="UpdateOrderInfo" datasource="discountsoccer" password="Nx3ae383">
    Update Orders
    Set 
    CCNumber='#s.CCnumber#', 
    CCDate='#s.CCDate#', 
    CCNameOnCard='#s.CCNameOnCard#',
    CCThreedigit='#s.CCThreedigit#', 
    LastName='#s.LastName#', 
    CompanyName='#s.CompanyName#', 
    TaxID='#s.TaxID#', 
    
    Street='#s.Street#',
    Number='#s.Number#',
    State='#s.State#',
    City='#s.City#', 
    Zip='#s.Zip#',
     
    MailStreet='#s.MailStreet#',
    MailNumber='#s.MailNumber#',
    MailState='#s.MailState#',
    MailCity='#s.MailCity#', 
    MailZip='#s.MailZip#', 
     
    FirstName='#s.FirstName#', 
    UserID='#s.UserID#', 
    CCtype='#s.CCtype#',  
    MiddleInitial='#s.MiddleInitial#', 
     
    Shipped='#s.Shipped#', 
    EmailAddress='#s.EmailAddress#', 
    PhoneNumber='#s.PhoneNumber#', 
     
    CCnumberLastFour='#s.CCnumberLastFour#'
    Where OrderNumber = '#s.OrderNumber#'
    </cfquery>
    </cffunction>
	
    <cffunction name="getOrderInformation" access="remote" returntype="query" hint="">
    <cfargument default="none" name="OrderNumber" required="yes">
    <cfquery name="getOrderInfo" datasource="discountsoccer" password="Nx3ae383">
    Select *
    From Orders
    Where OrderNumber = '#arguments.OrderNumber#'    
    </cfquery>
    <cfreturn getOrderInfo/>
    </cffunction>
    
    <cffunction  name="UpdateQuantity" access="remote" returntype="void" hint="This function recieves two arguments and updates the quantity of a selected
     item to a new value">
     <cfargument name="ItemName" type="string" hint="The Items Name">
     <cfargument name="Quantity" type="numeric" hint="The New Quantity"> 
     <cfquery name="UpdateQuantity" datasource="discountsoccer">
     Update Itemssc
     Set Quan='#arguments.Quantity#'
     Where ItemName ='#arguments.ItemName#'
     </cfquery>
    </cffunction>
    
    <cffunction name="QueryNotYet" access="remote" returntype="query" hint="Returns a query or orders that have not yet been shipped">
    <cfquery name="querynotyet" datasource="discountsoccer" password="Nx3ae383">
		select *
		from orders
		where shipped = 'not yet'
	</cfquery>
    <cfreturn querynotyet />
    </cffunction>
    
    <cffunction  name="SelectInventoryItems" access="remote" returntype="query" hint="This function recieves a parameter and returns 
    				searchresults for inventory possible parameters are ItemName, Description, and Category">
     <cfargument name="SearchParameter" type="string" hint="String from the radiobuttons that determins the column to be search" required="no" 
     default="category">
     <cfargument name="SearchArea" type="string" hint="String form the Search Area" required="no" default="apparel"> 
     <cfquery name="UpdateQuantity" datasource="discountsoccer" >
     Select *
     From Itemssc
     Where #arguments.SearchParameter# Like '%#arguments.SearchArea#%'
     Order by ItemNumber
     </cfquery>
     <cfreturn UpdateQuantity/>
    </cffunction>

   <cffunction name="getOrdersYTD" access="remote" returntype="query" hint="This Function Querys orders for a Given Time Period.Used in the Admin Page Number One.">
   <cfargument default="" required="no"  name="DatesAdjusted">
   <cfset DateTo = NumberFormat(LSParseNumber("#arguments.DatesAdjusted#") + 10000)>
   <cfquery name="queryID" datasource="discountsoccer">
   		select *
        from orders
        where DateAdjusted >= '#DatesAdjusted#'  
        and DateAdjusted <= '#DateTo#'  
   </cfquery>	
   <cfreturn queryID />
   </cffunction>
   
   <cffunction name="getPartNumbers" access="remote" returntype="query" hint="returns all Item Names from the inventory">
   <cfquery name="ItemNames" datasource="discountsoccer">
    Select ItemNumber
    From Itemssc
   </cfquery>
   <cfreturn ItemNames/>
   </cffunction>
   
   <cffunction name="UpdateCustomerInformation" access="remote" returntype="void" hint="This Function Querys the Existing User IDs for Comparison">
   <cfargument default="none" required="yes"  name="s" type="struct">
   
   <cfquery name="queryID" datasource="discountsoccer" password="Nx3ae383">
   		UPDATE customersinfo
        SET CCDATE='#s.CCDate#', 
        CCNAMEONCARD='#s.CCNameoncard#', 
        CCNUMBER='#s.CCNumber#',
        CCTHREEDIGIT='#s.CCTHREEDIGIT#',
        CCTYPE='#s.CCtype#',
        City='#s.City#', 
        CompanyName='#s.CompanyName#', 
        EmailAddress='#s.EmailAddress#', 
        FirstName='#s.FirstName#', 
        LastName='#s.LastName#', 
        MailCity='#s.MailCity#', 
        MailCompanyName='#s.MailCompanyName#', 
        MailFirstName='#s.MailFirstName#', 
        MailLastName='#s.MailLastName#', 
        MailMiddleInitial='#s.MailMiddleInitial#', 
        MailNumber='#s.MailNumber#', 
        MailState='#s.MailState#', 
        MailStreet='#s.MailStreet#', 
        MailZip='#s.MailZip#', 
        MiddleInitial='#s.MiddleInitial#', 
        Password='#s.Password#', 
        PhoneNumber='#s.PhoneNumber#', 
        State='#s.State#', 
        Street='#s.Street#', 
        TaxID='#s.TaxID#', 
        Zip='#s.Zip#', 
        Number='#s.Number#', 
        Title='#s.Title#', 
        AccessType='#s.AccessType#', 
        CCnumberLastFour='#s.CCNumberLastFour#', 
        Applied='#s.Applied#'
        WHERE  UserID='#s.UserID#'
   </cfquery>	
   </cffunction>
   
<cffunction access="public" name="adjustQuantity" >
   <cfset migiCart = session.cart.getCart()> 
   <cfloop from="1" to="#ArrayLen(migiCart)#" index="i">
   <cfquery name="Quan" datasource="discountsoccer"> 
   Select Quan  
   from Itemssc 
   Where ItemName ='#migiCart[i].Notes#'
   </cfquery>
   <cfset newquan = NumberFormat(Quan.Quan)-Numberformat(migiCart[i].quantity)> 
   <cfquery name="Stuff" datasource="discountsoccer"> 
   Update Itemssc  
   Set Quan= '#variables.newquan#'
   Where ItemName ='#migiCart[i].Notes#'
   </cfquery>
   </cfloop>
   </cffunction>
   
 <cffunction access="public" name="CustomersUpdateFunction" returntype="void">
 <cfargument default="none" required="yes"  name="s" type="struct">
   
   <cfquery name="queryID" datasource="discountsoccer" password="Nx3ae383">
   		UPDATE customersinfo
        SET City='#s.City#', 
        CompanyName='#s.CompanyName#', 
        EmailAddress='#s.EmailAddress#', 
        FirstName='#s.FirstName#', 
        LastName='#s.LastName#', 
        MailCity='#s.MailCity#', 
        MailCompanyName='#s.MailCompanyName#', 
        MailFirstName='#s.MailFirstName#', 
        MailLastName='#s.MailLastName#', 
        MailMiddleInitial='#s.MailMiddleInitial#', 
        MailNumber='#s.MailNumber#', 
        MailState='#s.MailState#', 
        MailStreet='#s.MailStreet#', 
        MailZip='#s.MailZip#', 
        MiddleInitial='#s.MiddleInitial#', 
        Password='#s.Password#', 
        PhoneNumber='#s.PhoneNumber#', 
        State='#s.State#', 
        Street='#s.Street#', 
        TaxID='#s.TaxID#', 
        Zip='#s.Zip#', 
        Number='#s.Number#', 
        Title='#s.Title#', 
        AccessType='#s.AccessType#', 
        Applied='#s.Applied#'
        WHERE  UserID='#s.UserID#'
   </cfquery>
   
   
 </cffunction>
 
 <cffunction access="public" name="UpdateCreditCardInformation" returntype="void" >
 <cfargument default="none" required="yes"  name="s" type="struct">   
 <cfquery name="queryID" datasource="discountsoccer" password="Nx3ae383">
   		UPDATE customersinfo
        SET CCDATE='#s.CCDate#', 
        CCNAMEONCARD='#s.CCNameoncard#', 
        CCNUMBER='#s.CCNumber#',
        CCTHREEDIGIT='#s.CCTHREEDIGIT#',
        CCTYPE='#s.CCtype#', 
        CCnumberLastFour='#s.CCNumberLastFour#' 
        WHERE  UserID='#s.UserID#'
   </cfquery>	
 </cffunction>
 
 <cffunction access="public" name="getOrderInformationTwo" returntype="query" >
 <cfargument default="none" required="yes"  name="UserId" type="String">
 <cfquery name="getOrderInformation" datasource="discountsoccer">
 	SELECT *
    FROM orders
    WHERE UserID='#arguments.UserId#' AND shipped = 'shipped'
 </cfquery>
 <cfreturn getOrderInformation>
 </cffunction>
 
 <cffunction access="public" name="getOrderInformationThree" returntype="query" >
 <cfargument default="none" required="yes"  name="UserId" type="String">
 <cfquery name="getOrderInformation" datasource="discountsoccer">
 	SELECT *
    FROM orders
    WHERE UserID='#arguments.UserId#' AND shipped = 'not yet'
 </cfquery>
 <cfreturn getOrderInformation> 
 </cffunction>
 
</cfcomponent>