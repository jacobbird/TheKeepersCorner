 <cfcomponent>
 	
 <cffunction name="newOrder" access="public" returntype="void">
        
        <cfargument name="DatesConverted" type="numeric" required="no" default="1111111111111">
		<cfargument name="FirstName" type="string" required="no" default="FirstName">
        <cfargument name="LastName" type="string" required="no" default="LastName">
        <cfargument name="MiddleInitial" type="string" required="no" default="MiddleInitial">
        <cfargument name="Street" type="string" required="no" default="Street">
        <cfargument name="City" type="string" required="no" default="City">
        <cfargument name="State" type="string" required="no" default="State">
        <cfargument name="Zip" type="string" required="no" default="Zip">
        <cfargument name="CompanyName" type="string" required="no" default="No Tax ID">
        <cfargument name="TaxID" type="string" required="no" default="0">
        <cfargument name="CCnumber" type="string" required="no" default="invoice">
        <cfargument name="CCnameoncard" type="string" required="no" default="invoice">
        <cfargument name="CCdate" type="string" required="no" default="invoice">
        <cfargument name="CCthreedigit" type="string" required="no" default="invoice">
        <cfargument name="CCtype" type="string" required="no" default="invoice">
        <cfargument name="UserID" type="string" required="no" default="No UserID">
        <cfargument name="Items" type="string" required="no" default="Items">
        <cfargument name="EmailAddress" type="string" required="no" default="EmailAddress">
        <cfargument name="Number" type="string" required="no" default="Number">
        <cfargument name="PhoneNumber" type="string" required="no" default="PhoneNumber">
        <cfargument name="CCnumberLastFour" type="string" required="no" default="Invoice">
        <cfargument name="Total" type="string" required="no" 
         default="An Error Has Occured Customer Care Component(Total): Please Contact the Site Administrator">
        <cfargument name="Tax" type="string" required="no" 
         default="An Error Has Occured Customer Care Component(Tax): Please Contact the Site Administrator">
        <cfargument name="MailCompanyName" type="string" required="no" default="MailCompanyName">
        <cfargument name="MailFirstName" type="string" required="no" default="MailFirstName">
        <cfargument name="MailLastName" type="string" required="no" default="MailLastName">
        <cfargument name="MailStreet" type="string" required="no" default="MailStreet">
        <cfargument name="MailCity" type="string" required="no" default="MailCity">
        <cfargument name="MailState" type="string" required="no" default="MailState">
        <cfargument name="MailZip" type="string" required="no" default="MailZip">
        <cfargument name="UniqueIdentifier" type="string" required="no" default="1111-1111-111-1">    
        
        <cfset daten = dateformat(now())>
                
        <cfquery datasource="discountsoccer" name="InsertOrders" password="Nx3ae383">
        	INSERT INTO orders(FirstName, LastName, MiddleInitial, CompanyName, Street, City, State, Zip,
             TaxID, CCnumber, CCnameoncard, CCdate, CCthreedigit, UserID, Items, CCtype, EmailAddress, Number, PhoneNumber, CCnumberLastFour, Date, Total,
             Tax, OrderNumber, DateAdjusted, MailCompanyName, MailFirstName, MailLastName, MailStreet, MailCity, MailState, MailZip)
            VALUES ('#arguments.FirstName#', '#arguments.LastName#', '#arguments.MiddleInitial#', 
            '#arguments.CompanyName#','#arguments.Street#', '#arguments.City#', '#arguments.State#',
            '#arguments.Zip#', '#arguments.TaxID#', '#arguments.ccnumber#', '#arguments.CCnameoncard#',
            '#arguments.CCdate#', '#arguments.CCthreedigit#', '#arguments.UserID#', '#arguments.Items#', '#arguments.CCtype#', '#arguments.EmailAddress#',
            '#arguments.Number#', '#arguments.PhoneNumber#', '#arguments.CCnumberlastfour#', '#variables.daten#', '#arguments.Total#', '#arguments.Tax#',
            '#arguments.UniqueIdentifier#', #arguments.DatesConverted#, '#arguments.MailCompanyName#', '#arguments.MailFirstName#',
            '#arguments.MailLastName#', '#arguments.MailStreet#', '#arguments.MailCity#', '#arguments.MailState#',
            '#arguments.MailZip#')
        </cfquery>
        
	</cffunction>
    
    <cffunction name="newOrderTwo" access="public" returntype="void">
        
        <cfargument name="DatesConverted" type="numeric" required="no" default="1">
		<cfargument name="FirstName" type="string" required="yes" default="stuff">
        <cfargument name="LastName" type="string" required="yes" default="stuff">
        <cfargument name="MiddleInitial" type="string" required="no" default="stuff">
        <cfargument name="Street" type="string" required="yes" default="stuff">
        <cfargument name="City" type="string" required="yes" default="stuff">
        <cfargument name="State" type="string" required="yes" default="stuff">
        <cfargument name="Zip" type="string" required="yes" default="0">
        <cfargument name="CompanyName" type="string" required="no" default="stuff">
        <cfargument name="TaxID" type="string" required="no" default="0">
        <cfargument name="UserID" type="string" required="yes" default="noID">
        <cfargument name="Items" type="string" required="yes" default="stuff">
        <cfargument name="CCtype" type="string" required="no" default="stuff">
        <cfargument name="EmailAddress" type="string" required="no" default="stuff">
        <cfargument name="Number" type="string" required="yes" default="stuff">
        <cfargument name="PhoneNumber" type="string" required="no" default="stuff">
        <cfargument name="CCnumberLastFour" type="string" required="no" default="Invoice">
        <cfargument name="Total" type="string" required="yes" default="stuff">
        <cfargument name="Tax" type="string" required="yes" default="stuff">
        <cfset UniqueIdentifier = CreateUUID()>
        <cfset daten = dateformat(now())>
                
        <cfquery datasource="discountsoccer" name="InsertOrders" password="Nx3ae383">
        	INSERT INTO orders(FirstName, LastName, MiddleInitial, CompanyName, Street, City, State, Zip,
             TaxID, UserID, Items, EmailAddress, Number, PhoneNumber, Date, Total,
             Tax, OrderNumber, DateAdjusted)
            VALUES ('#arguments.FirstName#', '#arguments.LastName#', '#arguments.MiddleInitial#', 
            '#arguments.CompanyName#','#arguments.Street#', '#arguments.City#', '#arguments.State#',
            '#arguments.Zip#', '#arguments.TaxID#', '#arguments.UserID#', '#arguments.Items#', '#arguments.EmailAddress#',
            '#arguments.Number#', '#arguments.PhoneNumber#', '#variables.daten#', '#arguments.Total#', '#arguments.Tax#',
            '#variables.UniqueIdentifier#', #arguments.DatesConverted#) 
        </cfquery>
        
	</cffunction>
   
    <cffunction name="orderQueryone" access="public" returntype="query" hint="This Function Querys the Orders Database">
    <cfargument name="searchparameterone" type="string" hint="this is the search parameter" required="no" default="">
    <cfargument name="searchparametertwo" type="string" hint="this is the search parameter" required="no" default="">
    <cfargument name="searchparameterthree" type="string" hint="this is the search parameter" required="no" default="">
    <cfargument name="searchcolumnone" type="string" hint="this is the search parameter" required="no" default="LastName">
    <cfargument name="searchcolumntwo" type="string" hint="this is the search parameter" required="no" default="State">
    <cfargument name="searchcolumnthree" type="string" hint="this is the search parameter" required="no" default="FirstName">
		<cfquery datasource="discountsoccer" name="querycare" password="Nx3ae383"> 
        select *
        from orders
        where #arguments.searchcolumnone# like '%#arguments.searchparameterone#%'
        and   #arguments.searchcolumntwo# like '%#arguments.searchparametertwo#%'
        and   #arguments.searchcolumnthree# like '%#arguments.searchparameterthree#%'
        order by date
        </cfquery>	 	
	<cfreturn querycare />
   </cffunction>
    
   <cffunction name="InsertCustomerInfo" access="remote" returntype="void" hint="This Function Querys the Existing User IDs for 	        Comparison">
   <cfargument default="" required="no"  name="CCDATE" type="any">
   <cfargument default="" required="no"  name="CCNAMEONCARD" type="any">
   <cfargument default="" required="no"  name="CCNUMBER" type="any">
   <cfargument default="" required="no"  name="CCTHREEDIGIT" type="any">
   <cfargument default="" required="no"  name="City" type="any">
   <cfargument default="" required="no"  name="CompanyName" type="any">
   <cfargument default="" required="no"  name="EmailAddress" type="any">
   <cfargument default="" required="no"  name="FirstName" type="any">
   <cfargument default="" required="no"  name="LastName" type="any">
   <cfargument default="" required="no"  name="MailCompanyName" type="any">
   <cfargument default="" required="no"  name="MailFirstName" type="any">
   <cfargument default="" required="no"  name="MailLastName" type="any">
   <cfargument default="" required="no"  name="MailMiddleInitial" type="any">
   <cfargument default="" required="no"  name="MailNumber" type="any">
   <cfargument default="" required="no"  name="MailStreet" type="any">
   <cfargument default="" required="no"  name="MailCity" type="any">
   <cfargument default="" required="no"  name="MailState" type="any">
   <cfargument default="" required="no"  name="MailZip" type="any">
   <cfargument default="" required="no"  name="MiddleInitial" type="any">
   <cfargument default="" required="no"  name="PasswordOne" type="any">
   <cfargument default="" required="no"  name="PhoneNumber" type="any">
   <cfargument default="" required="no"  name="State" type="any">
   <cfargument default="" required="no"  name="Street" type="any">
   <cfargument default="" required="no"  name="TaxID" type="any">
   <cfargument default="" required="no"  name="UserID" type="any">
   <cfargument default="" required="no"  name="Zip" type="any">
   <cfargument default="" required="no"  name="Number" type="any">
   <cfargument default="" required="no"  name="Title" type="any">
   <cfargument default="" required="no"  name="AccessType" type="any">
   <cfargument default="" required="no"  name="CCnumberLastFour" type="any">
   <cfargument default="" required="no"  name="Applied" type="any"> 
   
   <cfset CCNumberDe = Decrypt("#arguments.ccnumber#" , "Nx3ae487" , "blowfish" , "HEX")>
   <cfquery datasource="discountsoccer" name="queryID" password="Nx3ae383" >
   		Insert Into customersinfo
        (CCDATE, 
        CCNAMEONCARD, 
        CCNUMBER, 
        CCTHREEDIGIT, 
        City, 
        CompanyName, 
        EmailAddress, 
        FirstName, 
        LastName, 
        MailCity, 
        MailCompanyName, 
        MailFirstName, 
        MailLastName, 
        MailMiddleInitial, 
        MailNumber, 
        MailState, 
        MailStreet, 
        MailZip, 
        MiddleInitial, 
        Password, 
        PhoneNumber, 
        State, 
        Street, 
        TaxID, 
        UserID, 
        Zip, 
        Number, Title, AccessType, CCnumberLastFour, Applied) 
        values 
        ('#arguments.CCDate#', 
        '#arguments.CCNameoncard#', 
        '#variables.CCNumberDe#',  
        '#arguments.CCTHREEDIGIT#', 
        '#arguments.City#', 
        '#arguments.CompanyName#', 
        '#arguments.EmailAddress#', 
        '#arguments.FirstName#', 
        '#arguments.LastName#', 
        '#arguments.MailCity#', 
        '#arguments.MailCompanyName#', 
        '#arguments.MailFirstName#', 
        '#arguments.MailLastName#', 
        '#arguments.MailMiddleInitial#', 
        '#arguments.MailNumber#', 
        '#arguments.MailState#', 
        '#arguments.MailStreet#',
        '#arguments.MailZip#', 
        '#arguments.MiddleInitial#', 
        '#arguments.PasswordOne#', 
        '#arguments.PhoneNumber#', 
        '#arguments.State#', 
        '#arguments.Street#', 
        '#arguments.TaxID#', 
        '#arguments.UserID#', 
        '#arguments.Zip#', 
        '#arguments.Number#',
        '#arguments.Title#',
        '#arguments.AccessType#',
        '#arguments.CCNumberLastFour#',
        '#arguments.Applied#')
   </cfquery>	
   </cffunction>
   
   <cffunction name="retrievecustomerinformation" access="remote" returntype="query">
   <cfargument name="UserID" type="string" default="" required="yes">
   <cfquery name="retrievecustomerinfo"  datasource="discountsoccer">
   Select *
   From customersinfo
   where UserID = '#arguments.UserID#'
   </cfquery> 
   <cfreturn retrievecustomerinfo />
   </cffunction>
   
   <cffunction name="IDQueryOne" access="public" returntype="query" hint="This Function Querys the Existing User IDs for Comparison">
   <cfquery datasource="discountsoccer" name="queryID">
   		select UserID
        from customersinfo
   </cfquery>	
   <cfreturn queryID />
   </cffunction>
   
   <cffunction name="getOrders" access="remote" returntype="query" hint="This Function Querys orders for a Given Time Period">
   <cfargument default="" required="no"  name="DateAdjusted">
   <cfquery datasource="discountsoccer" name="queryID">
   		select *
        from orders
        where DateAdjusted >= '#arguments.DateAdjusted#'       
   </cfquery>	
   <cfreturn queryID />
   </cffunction>
   
   <cffunction name="getAddresses" access="remote" returntype="query" hint="This Function Querys Customer Address Information">
   <cfargument default="" required="no"  name="Dates">
   <cfquery datasource="discountsoccer" name="queryID">
   		select *
        from customersinfo 
        Order by LastName      
   </cfquery>
   <cfreturn queryID />
   </cffunction>
   
   <cffunction name="populateFields" access="remote" returntype="query" hint="This Function Querys Customer Address Information to populate forms.">
   <cfargument default="" required="no"  name="UserID">
   <cfquery datasource="discountsoccer" name="queryID">
   		select *
        from customersinfo
        Where UserID = '#arguments.UserID#'    
   </cfquery>
   <cfreturn queryID />
   </cffunction>
   
   <cffunction name="Shipped" access="remote" returntype="void" hint="">
   <cfargument name="Key" type="string" required="yes" hint="Proper Identifier for the Order: In This Case the Order Number." >
   <cfquery name="Shipped" datasource="discountsoccer" password="Nx3ae383">
   Update Orders
   Set Shipped = 'Shipped'
   Where OrderNumber = '#arguments.Key#'
   </cfquery>
   </cffunction>
   
   <cffunction name="OrdersByCustomer" returntype="query" access="remote" hint="This Function returs a query of Orders for a Client and is called from 
   the EditClientInfoPage.cfm">
   <cfargument name="UserID" default="" required="yes">
   <cfquery datasource="discountsoccer" name="OrdersByCustomer" password="Nx3ae383">
   select *
   from orders
   where UserID='#arguments.UserID#'
   Order By TimeStamp DESC
   </cfquery>
   <cfreturn OrdersByCustomer />
   </cffunction>
   
   <cffunction name="AboutUs" returntype="query" access="remote" hint="This Function returs a query of aboutus Information">
   
   <cfquery datasource="discountsoccer" name="AboutUs" password="Nx3ae383">
   select *
   from AboutUs
   where name='aboutus'
   </cfquery>
   
   <cfreturn AboutUs />
   
   </cffunction>
   
   <cffunction name="idComparator" returntype="boolean" access="remote" hint="This function compaires a new user's name to find if it already exists!">
   <cfargument name="UserId" type="string" required="yes" default="" hint="The new username to be compaired with the old usernames">
   <cfquery datasource="discountsoccer" name="queryID" password="Nx3ae383">
   		select UserID
        from customersinfo 
   </cfquery>
   
   <cfset bool = false>
   <cfloop query="queryID" startrow="1"  endrow="#queryID.recordCount#">
       <cfif arguments.UserID eq queryID.UserID>
       <cfset bool = true>
       </cfif>
   </cfloop>
   <cfreturn bool/>
   
   </cffunction>
   
</cfcomponent>