<cfcomponent>

	<cffunction name="ItemsLow" access="remote" returntype="query">
    <cfquery name="ItemsLow" datasource="discountsoccer" >
    Select ItemName, Quan
 	from itemssc
    where Quan < 10
    </cfquery>	
	<cfreturn ItemsLow>
	</cffunction>
    
    <cffunction name="ItemsByName" access="remote" returntype="query">
    <cfargument default="" required="yes" type="string" name="ItemNumber">
    <cfquery name="Item" datasource="discountsoccer" >
    Select ItemName, ItemNumber, Prices, PreferedPrice, Quan, Description, Category, SizeSML
 	from itemssc
    where ItemNumber = '#arguments.ItemNumber#'
    </cfquery>	
	<cfreturn Item>
	</cffunction>
    
    <cffunction name="exchangeMailer" access="remote" returntype="query">
    
    <cfargument default="" required="yes" type="string" name="customersEmail">
    <cfargument default="" required="yes" type="string" name="tempFileName"> 
    <cfargument default="" required="yes" type="string" name="emailAddress">
    
    <cfquery name="getPasswordAndUserName" datasource="discountsoccer" password="Nx3ae383">
    Select Password, UserName
    From customersInfo
    Where UserID
    </cfquery>
    
    <cfmail from="Mailer@ReliableCleanRoomProducts.com" to="#arguments.emailaddress#" failto="Mailer@ReliableCleanRoomProducts.com" 
    subject="Do Not Reply" username="Mailer" password="Mailer2009" server="www.DiscountSoccerSupply.com" >
    
    This Message was Created by a Mailer. Please DO NOT Reply to this Message.
    
    Reliable Clean Room Products User Name and Password Retrieval System.
    
    UserName:#GetPasswordAndUserName.UserName# 
    
    Password:#GetPasswordAndUserName.Password#
    
    
    Click Here If You would like to change you UserName and Password.
    http://www.reliablecleanroomproducts.com/TempFiles/#arguments.tempFileName#
    </cfmail>
    <cfset msg="Success! The Email Will Appear In Your Mail Box Shortly!">
	<cfreturn variables.msg/>
	</cffunction>
    
    <cffunction name="UpdateAboutUs" access="public" returntype="void">
    <cfargument default="" required="yes" type="string" name="FormData">
    	<cfquery datasource="discountsoccer" name="AboutUs">
    		Update aboutus
    		Set Description='#arguments.FormData#'
    		Where name='AboutUs'
    	</cfquery>	
	</cffunction>
    
    <cffunction name="UpdateKeyWords" access="remote" returntype="query">
    <cfargument default="" required="yes" type="string" name="FormData">
    	<cfquery name="UpdateKeyWords" datasource="discountsoccer" >
		Update keywords
        Set keywordname='keyword', keyword='#arguments.formdata#'
        WHERE keywordname='keyword'
    	</cfquery>	
	</cffunction>
    
    <cffunction name="unWrapOrderInfomation" access="remote" returntype="void">
    <cfargument required="no" type="string" name="OrderNumber">
    
	<cfset Unwrapped = ArrayNew(1)>
    <cfset Quantity = ArrayNew(1)>
    <cfset Price = ArrayNew(1)>
    <cfset Number = ArrayNew(1)>
	
    	<cfquery name="Items" datasource="discountsoccer">
    		Select Items
    		from Orders
    		where OrderNumber='#arguments.OrderNumber#'
    	</cfquery>
    
		<cfscript>
			Unwrappped=ListToArray('#Items.Items#','  - ');
			Quantity=ListToArray('Unwrapped[1]');
			Price=ListToArray('Unwrapped[2]');
			Number=ListToArray('Unwrapped[3]');
		</cfscript>
    
    </cffunction> 
   
</cfcomponent>