<!--Copywrite (c) All Rights Reserved: Clean, Simple, and Smart dba "Out of Site Development", "Out of Site Software", "Out of Site"-->
<cfparam default="" name="URL.Action" type="string">
<cfparam default="none" name="COOKIE.ACCESSTYPE" type="string">
<cfparam default="" name="form.newItem" type="string">
<cfparam default="" name="form.newQuantity" type="string">
<cfparam default="" name="form.newPrice" type="string">
<cfparam default="" name="form.item" type="string">
<cfparam default="" name="url.action" type="string">
<cfparam default="0" name="url.NumberOfNewItems" type="numeric">
<cfparam default="" name="variables.msg" type="string">
<cfparam default="" name="variables.descriptions" type="string">
<cfparam default="1" name="variables.x" type="numeric">
<cfparam default="1" name="variables.y" type="numeric">
<cfparam default="0" name="variables.numberOfItemsToAdd" type="numeric">
<cfparam default="" name="variables.ItemNumbers">
<cfparam default="1" name="variables.CounterUp">
<cfparam default="0" name="variables.IndexNew">
<cfparam default="0" name="variables.IndexOld">
<cfparam default="no" name="url.removed">

<cfset cartTwoTry = session.cartTwo.getCart(url.OrderNumber)>	
<cfset cartTwoLength = ArrayLen(cartTwoTry)>

<cfif  url.action eq "relocate" and url.removed eq "yes">
	
<cfelse>
	<cfset cartTwo = session.cartTwo.getCart(url.OrderNumber)>
</cfif>


<cfif not url.action eq "removeItem" and not url.action eq "relocate"> 
	<cfset session.cartTwo.reset(url.OrderNumber)> 
</cfif>



<cfset totalweight=0>

<!--Here are defined the defualt parameters for the page-->
<cfinvoke component="customercarecomponenttwo" method="getorderinformation" returnvariable="getorderinformationret">
<cfinvokeargument name="OrderNumber" value="#URL.OrderNumber#">
</cfinvoke>

<cfparam default="#getorderinformationret.shippingmethod#" name="form.SandHSelectBox">

<cfset numberOfItemsToAdd = url.NumberOfNewItems>
<!--This code checks login credentials and sends user to a login forum if non-exist. -->
<cfif structKeyExists(COOKIE, "admin") or COOKIE.AccessType eq "Customer Care" or COOKIE.AccessType eq "Both">
	<cfelse>
		<cfparam name="originURL" default="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
			<cfset originURL = "CustomerCareAndOrderUpdatingSystem.cfm">
				<cflocation URL="EmployeeLogin.cfm?originURL=#variables.originURL#">
					<cfabort>
						</cfif>

<html>
	<head>
		<title>Edit Orders Page</title>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<link href="UniversalFormatter.css" rel="stylesheet" type="text/css" />	
	
	<cftry>	      
		<cfset ItemNumbers = arraynew(1)>
			<cfset Quantities = arrayNew(1)>
				<cfset Prices = arrayNew(1)>
					<cfset cartInfo = arrayNew(1)>
						<cfset cartInfo = ListToArray("#getorderinformationret.Items#" , "   - " )>
							<cfset ItemNumbers = ListToArray("#variables.CartInfo[1]#")>
								<cfset Quantities = ListToArray("#variables.CartInfo[2]#")>
									<cfset Prices = ListToArray("#variables.CartInfo[3]#")>
                                    	<cfset Shipped = ListToArray("#variables.CartInfo[4]#")>
                                        	<cfcatch type="any">
                                        		</cfcatch>
                                        			</cftry>

<cfscript>
switch(form.SandHSelectBox){
case "01":{SelectedShippingService = "UPS - Next Day Air"; break;}
case "02":{SelectedShippingService = "UPS - 2nd Day Air"; break;}
case "03":{SelectedShippingService = "UPS - Ground"; break;}
case "12":{SelectedShippingService = "UPS - 3rd Day Select"; break;}
default:{SelectedShippingService = "UPS - Ground"; break;}
}
</cfscript>
                                    	

<cfset totalWeight = .25>
<cfif cartTwoLength gt 0>
<cfloop from="1" to="#cartTwoLength#" index="counter">
    <cftry>
	<cfset ItemNumber=#cartTwo[counter].ItemName#>
    	<cfquery name="getWeight" datasource="discountsoccer">
			SELECT weight
            FROM Itemssc
            WHERE ItemNumber = '#ItemNumber#'
		</cfquery>
        
		<cfset totalWeight = #totalWeight# + (#GetWeight.Weight# * #cartTwo[counter].Quantity#)>
        <cfcatch type="any">
        <cfset totalWeight = #totalWeight#>
        </cfcatch>
        </cftry>
	</cfloop>
</cfif>
    
    

<cfoutput>	
    <cfif not cartTwoLength eq 0>
    <cftry>
    <cf_usupsshippingratecalculator ShipToWeight="#TotalWeight#" ShipToService="#form.SandHSelectBox#" ShipToZip="#getorderinformationret.MailZip#" ReturnVariable="ShippingRate"/> 
    <cfcatch type="any">
    <cfset ShippingRate = 0>
    </cfcatch>
    </cftry>
    <cfelse>
    <cfset ShippingRate = 0>
    </cfif>
    
</cfoutput>
<script type="text/javascript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<cfswitch expression="#url.action#"> 
<!--Here are the actions listed -->    
	<cfcase value="sendEmailUpdate">
    
    	<script type="text/javascript">
			<cfoutput>
				var #ToScript(url.OrderNumber, "orders")#;
			</cfoutput>
				var address = "OrderChangedAttachment.cfm?OrderNumber="+orders;
				window.open(address ,'OrderChangedPDF','width=200, height=75, scrollbars=no, resizeable=no, menubar=no, toolbar=no');
		</script>
        	<cfset x = 0>
 				<cfset y = 1100>
    				</cfcase>

	<cfcase value="relocate">
    	<cfset x = 0>
 			<cfset y = 1100>
    			</cfcase>
    
    <cfcase value="addItem">
 		<cfset numberOfItemsToAdd = url.NumberofNewItems + 1>
        	<cfset x = 0>
 				<cfset y = 1100>
                	<cfoutput>
                    <script type="text/javascript">
					window.location.assign("EditOrderInformationPage.cfm?action=relocate&OrderNumber=#url.OrderNumber#&NumberOfNewItems=#NumberofItemsToAdd#")
                    </script>
                    </cfoutput>
					</cfcase>
                    
	<cfcase value="reset">
    	<cfset numberofItemsToAdd = 0>
			<cfset session.cartTwo.reset(url.OrderNumber)>
        		<cfset x = 0>
 					<cfset y = 1100>
                    	<cflocation url="EditOrderInformationPage.cfm?action=relocate&OrderNumber=#url.OrderNumber#&NumberOfNewItems=#NumberofItemsToAdd#">	
    						</cfcase>
                        
	<cfcase value="removeItem">
    	<cfset numberofItemsToAdd = url.NumberofNewItems>
           	<cfif cartTwoLength eq 1>
            	<cfset removered = "yes">
                	<cfelse>
                    	<cfset removered = "no">
           					</cfif>
 							<cfset session.cartTwo.removeItem(url.position)>				
								<cfset x = 0>
 								<cfset y = 1100>
                   					<cflocation url="EditOrderInformationPage.cfm?action=relocate&OrderNumber=#url.OrderNumber#&NumberOfNewItems=#NumberofItemsToAdd#&removed=#removered#">
										</cfcase>
                      
    <cfcase value="clearCart">
    	<cfset numberofItemsToAdd = 1>
		   <cfset session.cartTwo.clearCart()> 		
           		<cfset x = 0>
 						<cfset y = 1100>
                   			<cflocation url="EditOrderInformationPage.cfm?action=relocate&OrderNumber=#url.OrderNumber#&NumberOfNewItems=#NumberofItemsToAdd#">	           					</cfcase>
                
    <cfcase value="removeNewItem">
 		<cfset x = 0>
 			<cfset y = 1100>
            	<cfif url.numberOfNewItems gt 0>
					<cfset numberOfItemsToAdd = url.NumberofNewItems - 1>
                		</cfif>
							</cfcase>

	<cfcase value="update">
			<cfset x = 0>
 				<cfset y = 1100>
                     <cftry>                                                                                           
                <!-- Must create new arrays to hold cart information  -->
        				              <cfset ItemNumbers = arraynew(1)>
										<cfset Quantities = arrayNew(1)>
										  <cfset Prices = arrayNew(1)>      
                            				<cfset Shipped = arrayNew(1)>
                                              
                                   		 <cfloop from="1" to="#form.indexOld#" index="counter">                 
                                            <cfset ItemNumbers[counter] = StructFind(form,"Item#variables.counter#")>
                                            <cfset Quantities[counter] = StructFind(form,"Quantity#variables.counter#")>
                                            <cfset Prices[counter] = StructFind(form,"Price#variables.counter#")>
                                            <cfset Shipped[counter] = StructFind(form,"Shipped#variables.counter#")> 
										 </cfloop>
                                       		                              		
                                         <cfloop from="1" to="#form.indexNew#" index="counter">                                                               
											<cfset indexNew = form.indexOld + variables.counter> 
                                            <cfset newItem = StructFind(form, "newItem#variables.counter#")>
											<cfset newQuantity = StructFind(form, "newQuantity#variables.counter#")>
                                            <cfset newPrice = StructFind(form, "newPrice#variables.counter#")>
											<cfif not newItem eq "">
                                            <cfif not newQuantity eq "">
                                            <cfif not newPrice eq "">
                                           	<cfset ItemNumbers[variables.indexNew] = StructFind(form,"newItem#variables.counter#")>
                                           	<cfset Quantities[variables.indexNew]  = StructFind(form,"newQuantity#variables.counter#")>
                                           	<cfset Prices[variables.indexNew]      = StructFind(form,"newPrice#variables.counter#")>
                                            <cfset Shipped[variables.indexNew]     = StructFind(form,"newShipped#variables.counter#")>
											</cfif>
                                            </cfif>
                                            </cfif>
   									     </cfloop>
                                           
                                             
                                         <cfscript>
										  	session.cartTwo.addItems(url.orderNumber, variables.ItemNumbers, variables.Quantities, variables.Prices, variables.Shipped);									
                                         </cfscript>
                                         
										 

        								<cfquery name="Updatetotal" datasource="discountsoccer">
                                            update orders
        									set Total='#form.Total#', Tax='#form.Tax#'
        									where orderNumber='#url.orderNumber#'
        								</cfquery>
                                        <cfcatch type="any">
                                        	session.cartTwo.clearCart();
                                        </cfcatch>
                                        </cftry>
                                        
                                       <cflocation url="EditOrderInformationPage.cfm?OrderNumber=#URL.OrderNumber#&action=reset&sr=#variables.totalWeight#">
                          </cfcase>

	<cfcase value="updateTwo"> 
            <cfset x = 0>
 			<cfset y = 1100>                        
			<cfset s = structnew()>
			<cfset s.firstname = Form.firstname>
			<cfset s.middleinitial = Form.middleinitial>
			<cfset s.lastname = Form.lastname>
			<cfset s.companyname = Form.companyname>
			<cfset s.emailaddress = Form.emailaddress>
			<cfset s.phonenumber = Form.phonenumber>
			<cfset s.taxid = Form.taxidentificationnumber>
			<cfset s.Userid = Form.Userid>
			<cfset s.street = Form.street>
			<cfset s.number = Form.number>
			<cfset s.city = Form.city>
			<cfset s.state = Form.state>
			<cfset s.zip = Form.zip>
			<cfset s.mailstreet = Form.mailstreet>
			<cfset s.mailnumber = Form.mailnumber>
			<cfset s.mailcity = Form.mailcity>
			<cfset s.mailstate = Form.mailstate>
			<cfset s.mailzip = Form.mailzip>
			<cfset s.cctype = Form.cctype>
			<cfif isNumeric(Form.ccnumber)>
			<cfset s.ccnumber = Form.ccnumber>
			<cfset lf = right(form.CCnumber,4)>
			<cfset s.ccnumberlastfour = "XXXX XXXX XXXX #variables.lf#">
			<cfelse>
			<cfset s.ccnumber = getorderinformationret.ccnumber>
			<cfset s.ccnumberlastfour = getorderinformationret.ccnumberlastfour>
			</cfif>
			<cfset s.ccdate = Form.ccexpirationdate>
			<cfset s.ccthreedigit = Form.ccthreedigits>
			<cfset s.ccnameoncard = Form.ccnameoncard>
			<cfif not URL.ordernumber eq "none">
			<cfset s.ordernumber = URL.ordernumber>
			<cfelse>
			<cfset s.ordernumber = Form.ordernumber>
			</cfif>
			<cfset s.shipped = Form.shipped>
			<cfinvoke component="customercarecomponenttwo" method="updateorderinformation" returnvariable="updateorderinformationret">
			<cfinvokeargument name="s" value="#s#">
			</cfinvoke>
			<cflocation url="EditOrderInformationPage.cfm?OrderNumber=#URL.OrderNumber#">
			<cfset msg="success.">
								<!-- Make one array for each column and pass into the session. -->    			 
	</cfcase>
	<cfcase value="ChangeShippingService">
             	<cfif not ArrayLen(cartTwo) eq 0> 
                <cftry>               
                <cf_usupsshippingratecalculator ShipToWeight="#TotalWeight#" ShipToService="#form.SandHSelectBox#" ShipToZip="#getorderinformationret.MailZip#" ReturnVariable="ShippingRate"/>
                <cfcatch type="any">
                </cfcatch>
                </cftry>
        		<cfquery datasource="discountsoccer" name="update">
        			UPDATE orders
        			SET shippingMethod = '#form.SandHSelectBox#'
        			WHERE orderNumber = '#getorderinformationret.OrderNumber#'
        		</cfquery>
                <cfelse>
                <cfquery datasource="discountsoccer" name="update">
        			UPDATE orders
        			SET shippingMethod = '#form.SandHSelectBox#'
        			WHERE orderNumber = '#getorderinformationret.OrderNumber#'
        		</cfquery>
                <cfset ShippingRate = 0> 
                </cfif>           
    </cfcase>
</cfswitch>
	
	<script type="text/javascript">
		<!--
		function ScrollWindow(x,y) {window.scrollTo(x,y);}
		function MM_findObj(n, d) { //v4.01
  			var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    		d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  			if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  			for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  			if(!x && d.getElementById) x=d.getElementById(n); return x;
			}

		//-->
		</script>
	</head>

<cfoutput>
  <body onLoad="MM_preloadImages('images/ButtonBank/theRemoveButton_OVER.gif','images/ButtonBank/Reset_OVER.gif','images/ButtonBank/getPriceButton_OVER.jpg'); ScrollWindow(#variables.x#,#variables.y#)">
<table width="960" border="0" cellspacing="0" cellpadding="0"> 
		  <tr class="formheaders">
   			  <td width="201">&nbsp;</td>
   			  <td width="210">&nbsp;</td>
   			  <td colspan="3" align="center" bgcolor="FFFF99">General Information:</td>
		  </tr>
		  <tr class="formheaders">
   			  <td colspan="2" rowspan="2" align="center" class="PageHeaders">Edit Orders Page</td>
   			  <td width="210" align="right" bgcolor="EEEEEE">&nbsp;</td>
   			  <td colspan="2" bgcolor="EEEEEE">&nbsp;</td>
		  </tr>
		  <tr  align="center">
   			  <td align="right" bgcolor="EEEEEE" class="formheaders">Shipped:</td>
           	  <td colspan="2" bgcolor="EEEEEE" class="formheaders">#getorderinformationret.shipped#</td>
  </tr>
  <tr class="formheaders">
    <td colspan="2" align="center">
    	<cfform>
    		<cfinput name="Generate Pick Ticket" type="button" value="Generate the Pick Ticket" onClick="window.open('https://secure.reliablecleanroomproducts.com/PickTicket.cfm?OrderNumber=#getorderinformationret.ordernumber#','window4','resizeable=yes, scrollbars=yes, toolbar=no, height=850 width=1100')">
        </cfform>    </td>
    <td align="right" bgcolor="EEEEEE">Purchase Date:</td>
    <td colspan="2" align="center" bgcolor="EEEEEE">#getorderinformationret.date#</td>
  </tr>
  		<cfform name="form" id="form" method="post" preservedata="yes" action="EditOrderInformationPage.cfm?action=UpdateTwo&OrderNumber=#getorderinformationret.ordernumber#&NumberofNewItems=#numberOfItemsToAdd#">
  <tr class="formheaders">
    <td></td>
    <td>&nbsp;</td>
    <td align="right" bgcolor="EEEEEE">Order Last Changed:</td>
    <td colspan="2" align="center" bgcolor="EEEEEE">#getorderinformationret.timestamp#</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td bgcolor="EEEEEE">&nbsp;</td>
    <td colspan="2" bgcolor="EEEEEE">&nbsp;</td>
  </tr>
  <tr bgcolor="FFFFFF">
    <td colspan="5">&nbsp; #variables.msg#</td>
  </tr>
  <tr class="CustomerNumber" bgcolor="000000">
    <td colspan="2">&nbsp;Customer Information </td>
    <td colspan="3" align="right" valign="top"> Order Number: 
    #getorderinformationret.ordernumber# &nbsp; &nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td background="images/Area Fill/Plain-Blue-Fill.jpg" colspan="5">&nbsp; #variables.msg#</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  
  <tr class="formlabels" bgcolor="CCCCCC">
    <td>&nbsp;Company Name</td>
    <td>First Name</td>
    <td>Middle Initial</td>
    <td colspan="2">Last Name</td>
  </tr>
  <tr bgcolor="EEEEEE">
    <td>&nbsp;
    <cfinput type="text" name="CompanyName" id="CompanyName" value="#getorderinformationret.CompanyName#"></td>
    <td><cfinput type="text" name="FirstName" id="CompanyName2" value="#getorderinformationret.FirstName#"></td>
    <td><cfinput type="text" name="MiddleInitial" id="CompanyName3" value="#getorderinformationret.MiddleInitial#"></td>
    <td colspan="2"><cfinput type="text" name="LastName" id="CompanyName4" value="#getorderinformationret.LastName#"></td>
  </tr>
  <tr class="formlabels">
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr class="formlabels" bgcolor="CCCCCC">
    <td>&nbsp;Email Address</td>
    <td>Phone Number</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr bgcolor="EEEEEE">
    <td>&nbsp;
    <cfinput type="text" name="EmailAddress" id="CompanyName5" value="#getorderinformationret.eMailAddress#"></td>
    <td><cfinput type="text" name="PhoneNumber" id="CompanyName6" value="#getorderinformationret.PhoneNumber#"></td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr class="formlabels" bgcolor="CCCCCC">
    <td>&nbsp;Tax Identification Number</td>
    <td>UserID</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr bgcolor="EEEEEE">
    <td>&nbsp;
    <cfinput type="text" name="TaxIdentificationNumber" id="CompanyName7" value="#getorderinformationret.TaxID#"></td>
    <td><cfinput type="text" name="UserID" id="CompanyName8" value="#getorderinformationret.UserID#"></td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr  bgcolor="000000" class="CustomerNumber">
    <td colspan="2">&nbsp;Billing Address Information</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr class="formlabels" bgcolor="CCCCCC">
    <td>&nbsp;Street</td>
    <td>Number</td>
    <td>City</td>
    <td colspan="2">State</td>
  </tr>
  <tr bgcolor="EEEEEE">
    <td>&nbsp;
      <cfinput type="text" name="Street" id="CompanyName18" value="#getorderinformationret.Street#"></td>
    <td><cfinput type="text" name="Number" id="CompanyName10" value="#getorderinformationret.Number#"></td>
    <td><cfinput type="text" name="City" id="CompanyName11" value="#getorderinformationret.City#"></td>
    <td colspan="2"><cfinput type="text" name="State" id="CompanyName12" value="#getorderinformationret.State#"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr class="formlabels" bgcolor="CCCCCC">
    <td>&nbsp;Zip</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr bgcolor="EEEEEE">
    <td>&nbsp;
    <cfinput type="text" name="Zip" id="CompanyName13" value="#getorderinformationret.Zip#"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr  bgcolor="000000" class="CustomerNumber">
    <td colspan="2">&nbsp;Mailing Address Information</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr class="formlabels" bgcolor="CCCCCC">
    <td>&nbsp;Street</td>
    <td>Number</td>
    <td>City</td>
    <td colspan="2">State</td>
  </tr>
  <tr bgcolor="EEEEEE">
    <td>&nbsp;
      <cfinput type="text" name="MailStreet" id="CompanyName9" value="#getorderinformationret.MailStreet#"></td>
    <td><cfinput type="text" name="MailNumber" id="CompanyName10" value="#getorderinformationret.MailNumber#"></td>
    <td><cfinput type="text" name="MailCity" id="CompanyName11" value="#getorderinformationret.MailCity#"></td>
    <td colspan="2"><cfinput type="text" name="MailState" id="CompanyName12" value="#getorderinformationret.MailState#"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr class="formlabels" bgcolor="CCCCCC">
    <td>&nbsp;Zip</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr bgcolor="EEEEEE">
    <td>&nbsp;
      <cfinput type="text" name="MailZip" id="CompanyName19" value="#getorderinformationret.MailZip#"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  
  <tr class="CustomerNumber" bgcolor="000000">
    <td colspan="2">&nbsp;Credit Card Information </td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr class="formlabels" bgcolor="CCCCCC">
    <td>&nbsp;CCNumber</td>
    <td>CC Name On Card</td>
    <td>CC Expiration Date</td>
    <td colspan="2">CC Three Digits</td>
  </tr>
  <tr bgcolor="EEEEEE">
    <td>&nbsp;
    <cfinput type="text" name="CCNumber" id="CompanyName14" value="#getorderinformationret.CCNumberlastfour#" maxlength="16"></td>
    <td><cfinput type="text" name="CCNameoncard" id="CompanyName15" value="#getorderinformationret.CCNameoncard#"></td>
    <td><cfinput type="text" name="CCExpirationDate" id="CompanyName16" value="#getorderinformationret.CCDate#"></td>
    <td colspan="2"><cfinput type="text" name="CCThreedigits" id="CompanyName17" value="#getorderinformationret.CCThreeDigit#"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr bgcolor="CCCCCC" class="formlabels">
    <td>&nbsp; CCType</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr bgcolor="EEEEEE">
    <td>&nbsp;
    <cfinput type="text" name="CCtype" value="#getorderinformationret.CCType#" typeahead="no" 
    			showautosuggestloadingicon="true"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;
    <cfinput type="hidden" name="Shipped" id="CompanyName22" value="#getorderinformationret.Shipped#"></td>
    <td colspan="2">&nbsp;<cfinput type="submit" name="Submit" value="  Submit Changes  " id="Submit"></td>
  </tr>
  </cfform>
  
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr class="CustomerNumber" bgcolor="000000">
    <td colspan="2">&nbsp;This Order Information:</td>
    <td colspan="3" align="right">OrderNumber:#getorderinformationret.ordernumber# &nbsp; &nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;
    Shipping Service</td>
    <td>&nbsp;Shipping</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>
    <cftry>
    <cfform name="ShippingandHandeling" action="EditOrderInformationPage.cfm?action=ChangeShippingService&OrderNumber=#url.OrderNumber#">
      &nbsp;
      <cfselect name="SandHSelectBox" id="SandHSelectBox" onChange="form.submit()">
      <option value="#SelectedShippingService#">#SelectedShippingService#</option>
      <option value="03">UPS - Ground</option>
      <option value="01">UPS - Next Day Air</option>
      <option value="02">UPS - 2nd Day Air</option>
      <option value="12">UPS - 3rd Day Select</option>
      </cfselect>
    </cfform>
    <cfcatch type="any">
    </cfcatch>
    </cftry>    </td>
    <td valign="top">&nbsp;#DollarFormat(variables.ShippingRate)#</td>
    <td colspan="3" valign="top">Must click &quot;Submit Changes&quot; to apply the new shipping cost to the &quot;Grand Total&quot;.</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr class="formlabels" bgcolor="CCCCCC">
    <td height="28">&nbsp;Items </td>
    <td>&nbsp;Quantity</td>
    <td>&nbsp;Description</td>
    <td>&nbsp;Price</td>
    <td><a href="EditOrderInformationPage.cfm?OrderNumber=#url.OrderNumber#&action=reset&NumberOfNewItems=0" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Reset','','images/ButtonBank/Reset_OVER.gif',1)"><img src="images/ButtonBank/Reset_OUT.gif" name="Reset" width="24" height="24" border="0"></a></td>
  </tr>
  <cfform name="form" id="form" method="post" preservedata="yes" action="EditOrderInformationPage.cfm?action=Update&OrderNumber=#getorderinformationret.ordernumber#&NumberofNewItems=#numberOfItemsToAdd#">
  <cfset GrandTotal = 0>
  <cftry>
  <cfloop from="1" to="#ArrayLen(cartTwo)#" index="counter">  	
    <cfquery name="OrderInformation" datasource="warehouse">
    	select *
        	from itemssc
        		where ItemNumber = '#cartTwo[counter].ItemName#'
    				</cfquery>  
  						<cftry>
							<cfset Desc = left("#OrderInformation.Description#",24)> 
                        <cfcatch type="any">
                        	<cfset Desc = "none available"> 
                        </cfcatch>
                        </cftry>
  						<tr bgcolor="EEEEEE">
    									<cfset indexOld = #counter#>
    						<td height="28">&nbsp;<cfinput type="text" name="Item#counter#" id="Item#counter#" 
                            			value="#cartTwo[counter].ItemName#"></td>
       						<td>&nbsp;<cfinput type="text" name="Quantity#counter#" id="Quantity#counter#" 
                            			value="#cartTwo[counter].Quantity#"></td>
   						    <td>&nbsp;<cfinput type="text" name="Description#counter#" id="Desc#counter#" readonly="yes"
                            			value="#variables.Desc#"></td>    
    						<td width="174">&nbsp;<cfinput type="text" name="Price#counter#" id="Price#counter#" 
    									value="#cartTwo[counter].Price#"><cfinput type="hidden" name="Shipped#counter#" id="Shipped#counter#" 
    									value="#cartTwo[counter].Shipped#"> &nbsp;</td>
    						<td width="165" valign="top">
    						<cfset GrandTotal = GrandTotal + (cartTwo[counter].Quantity * cartTwo[counter].Price)>
                            <a href="EditOrderInformationPage.cfm?OrderNumber=#url.OrderNumber#&action=removeItem&NumberOfNewItems=#variables.numberOfItemsToAdd#&position=#counter#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('TheRemoveButton','','images/ButtonBank/theRemoveButton_OVER.gif',1)"><img src="images/ButtonBank/theRemoveButton_OUT.gif" name="TheRemoveButton" width="24" height="24" border="0"></a>                            <a href="##" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('PriceGetter','','images/ButtonBank/getPriceButton_OVER.jpg',1)"><img src="images/ButtonBank/getPriceButton_OUT.jpg" name="PriceGetter" width="24" height="24" border="0"></a></td> 
                      </tr>
  				</cfloop>
                <cfcatch type="any">
                </cfcatch>
                </cftry>
                <cfset Tax = GrandTotal * .0825>
  				<cfset GrandTotal = GrandTotal + variables.ShippingRate + (GrandTotal * .0825)>
  				
                <cfquery name="Updatetotal" datasource="discountsoccer">
                	update orders
        			set Total='#variables.GrandTotal#', Tax='#variables.Tax#', Shipping='#variables.ShippingRate#'
        			where orderNumber='#url.orderNumber#'
        		</cfquery>
                
                
  <cfset newItemNumber = ArrayLen(ItemNumbers) + 1>
  	<cfif variables.numberOfItemsToAdd gt 0>
  		<cfloop from="1" to="#variables.numberOfItemsToAdd#" index="counter">
  			<tr bgcolor="EEEEEE">
            	<cfset indexNew=#counter#>
    			<td>&nbsp;<cfinput type="text" name="newItem#counter#" id="newItem" value=""></td>
    			<td>&nbsp;<cfinput type="text" name="newQuantity#counter#" id="newQuantity" value=""></td>
    			<td>&nbsp;<cfinput type="text" name="newDescriptions#counter#" id="newDescription" readonly="yes"  value=""><cfinput type="hidden" name="newShipped#counter#" id="newShipped" value="NotYet"></td>
    			<td height="28" valign="middle">&nbsp;<cfinput type="text" name="newPrice#counter#" id="newPrice2" value="">&nbsp;</td>
    			<td valign="top">
				
                <a href="EditOrderInformationPage.cfm?OrderNumber=#url.OrderNumber#&action=removeNewItem&NumberOfNewItems=#variables.numberOfItemsToAdd#&counter=#counter#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('TheRemoveButtonTwo','','images/ButtonBank/theRemoveButton_OVER.gif',1)"><img src="images/ButtonBank/theRemoveButton_OUT.gif" name="TheRemoveButtonTwo" width="24" height="24" border="0"></a>                </td>
  			</tr>
   		</cfloop>
  	</cfif>
        
        
        
  <tr>
    <td>&nbsp;
    <cfinput type="hidden" name="IndexOld" id="newPrice" value="#variables.IndexOld#"></td>
    <td>&nbsp;
    <cfinput type="hidden" name="IndexNew" id="newPrice" value="#variables.IndexNew#"></td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;
    <cfinput type="button" name="SendConfirmation" value="       Add Item       " onClick="window.open('EditOrderInformationPage.cfm?action=AddItem&numberOfNewItems=#numberOfItemsToAdd#&OrderNumber=#url.orderNumber#','_self')"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;Tax</td>
    <td colspan="2">&nbsp;Grand Total</td>
  </tr>  
  <tr>
    <td></td>
    <td>&nbsp;</td>
    <td>&nbsp;
    <cfinput type="text" name="Tax" id="CompanyName20" value="#NumberFormat(variables.Tax, 9999.99)#"></td>
    <td colspan="2">&nbsp;
    <cfinput type="text" name="Total" id="CompanyName21" value="#NumberFormat(variables.GrandTotal,99999.99)#"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2"><cfinput type="hidden" name="Shipping" id="CompanyName22" value="#variables.ShippingRate#"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2"><cfinput type="hidden" name="ShippingMethod" id="CompanyName23" value="#form.SandHSelectBox#"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;
    <cfinput type="button" name="SendConfirmation" value=" Email Confirmation" onClick="window.open('EditOrderInformationPage.cfm?action=sendEmailUpdate&numberOfNewItems=#numberOfItemsToAdd#&OrderNumber=#url.OrderNumber#','_self')"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;
    <cfinput type="button" name="PrintInvoice" value="    Print Changes    " onClick="window.open('https://secure.reliablecleanroomproducts.com/OrderChangedAttachmentTwo.cfm?OrderNumber=#url.OrderNumber#','_blank')"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2">&nbsp;
    <cfinput type="submit" name="Submit" value="  Submit Changes  " id="Submit2"></td>
  </tr>
  	</cfform>
  <tr>
    <td colspan="5">&nbsp;Total Weight: #TotalWeight# &nbsp; Zip Code: #getorderinformationret.MailZip# </td>
    </tr>
</table>
</body>
</cfoutput>
</html>