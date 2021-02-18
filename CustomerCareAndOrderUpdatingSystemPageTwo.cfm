
	<!-- 
	 Here code checks the login information of an employee to verify that the credentials are correct. The two parameters both set default 
	 values for the cookies assigned to the process. The cookies are of type string and are defaulted to the value none. The rest of the 
     code asks if either the Admin Cookie exists or the whether the AccessType Cookie is equivlent to the value warehouse! If neither of 
     these conditions are met that an abort is invoked and the page redirects to a secured Employee Login form. This is the typical Login 
     code used for all of the employee login pages. 
    -->
    
	<cftry>
			<cfparam default="none" name="COOKIE.ACCESSTYPE" type="string">
		<cfif structKeyExists(COOKIE, "admin") or COOKIE.AccessType eq "Customer Care" or COOKIE.AccessType eq "Both">
		<cfelse>
			<cfparam name="originURL" default="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
			<cfset originURL = "http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystemPageTwo.cfm">
			<cflocation URL="EmployeeLogin.cfm?originURL=#variables.originURL#">
			<cfabort>
		</cfif>
	<cfcatch type="missinginclude">
     	<!--the message to be displayed -->
        <h1>You've Thrown a Relocation <b>Error</b></h1>
        <!--the diagnostic message from Cold Fusion 8.-->
        <p>#cfcatch.message#</p>
        <p>Caught an exception, type = #cfcatch.type#</p>
        <p>The content of the tag stack is:</p>
        <cfdump var="#cfcatch.tagcontext#">   
    					</cfcatch>
    						</cftry>

	<!-- 
	 Here a variable is set to the object "sections" created during the request on the application. The "sections" object 
     contains several methods, namely, ones which open and close the sections located on the page. These methods may now be accessed 
     from this page and arguments may be fed to them in an object-oriented style!
	-->

	<cfset sectionOperations = session.sections>
    
    <!-- 
	 Here a variable is set to the object "rows" created during the request on the application. The "sections" object 
     contains several methods, namely, ones which open and close the sections that are located on the page. These methods may now 
     be accessed from this page and arguments may be fed to them in an object-oriented style!
	-->
	
	<cfset rowOperations = session.rows>
	
    <!-- Here parameters are used to set default values for variables that require a default value. -->
    <!--URL variables -->
	<cfparam name="url.action" 			type="string" 	default="none">
    <cfparam name="url.scrubs"  		type="string" 	default="30">
    <cfparam name="url.startRowTwo"		type="numeric" 	default="1" >
    <cfparam name="url.action"  		type="string" 	default="">
    
    <!--FORM variables -->
	<cfparam name="form.Select"	type="string" default="">
    <cfparam name="form.searchArea"	type="string" default="">
    
    <!--VARIABLES variables-->
	<cfparam name="variables.errmsg" 	type="string" default="">
    <cfparam name="variables.msg" 		type="string" default="">
    <cfparam name="variables.x" 		type="numeric" default="0">
    <cfparam name="variables.y" 		type="numeric" default="0">

	<!-- ??? -->
	<cfinvoke component="AdministrationComponent" method="getCustomerInformation" returnvariable="getCustomerInformationRet" />
    <!-- ??? -->
	<cfinvoke component="CustomerCareComponent" method="orderQueryone" returnvariable="orderQueryoneRet" />
	<!-- 
     Here is the first of two switches and is a switch that controlls the opening and closing of page sections. It accesses the "sectionOperations" 
     object which inturn calls its' two methods: "sectionOpen" and "sectionClose" to open and close page sections.
    -->
 	<!-- A Patch to fix the URL.startRow ERROR temporay until a more permanent solution is found! -->
    
    <cfif not structKeyExists(url, "startRow") or url.startRow is "undefined" or url.startRow lte 0>
    	<cfset url.startRow = 1>
    </cfif>
 	
    <cfif form.select is "">
    	<cfset form.select = "UserID">
    </cfif>
	<!-- 
     Here is the second of three switches. This switch regulates four actions on the page: SearchCustomers, MakeStandard, MakePerferred and 
     a simple Redirect.   
    -->
	
    <cfswitch expression="#url.action#">
		<cfcase value="SearchCustomers">
       
        <cfif Form.SearchArea eq "" and structKeyExists(url, "UserID")>
        	<cfset Form.SearchArea = "#url.UserID#">
        		<cfset Form.Select = "UserID">
        			</cfif>
                    
		<cfif not form.Select eq "Select">
			<cfinvoke component="AdministrationComponent" method="getCustomerInformation" returnvariable="getCustomerInformationRet">
				<cfinvokeargument name="SearchParameterOne" value="#Form.Select#">
				<cfinvokeargument name="SearchParameterTwo" value="#Form.SearchArea#">
                	</cfinvoke>
						<cfset x = 0>
							<cfset y = 0>
		<cfelse>
			<cfset errmsg eq "Must Specify a Search Parameter!">
            	<cfset x = 0>
					<cfset y = 0>
						</cfif>
							</cfcase>

		
        <cfcase value="MakeStandard">
			<cfinvoke component="AdministrationComponent" method="MakeStandard">
				<cfinvokeargument name="UserID" value="#URL.Key#">
					</cfinvoke>
						<cflocation url="CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=SearchCustomers&UserID=#url.key#">
							</cfcase>

		
        <cfcase value="MakePreferred">
			<cfinvoke component="AdministrationComponent" method="MakePreferred">
				<cfinvokeargument name="UserID" value="#URL.Key#">
					</cfinvoke>
						<cflocation url="CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=SearchCustomers&UserID=#url.key#">
							</cfcase>
                            
               
        <cfcase value="Activate">
			<cfquery name="Activated" datasource="discountsoccer">
            	Update customersinfo
            		set activated='yes'
            			where UserID='#url.Key#'
            				</cfquery>
								<cflocation url="CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=SearchCustomers&UserID=#url.key#">
									</cfcase>
                                    
        
        
        
        <cfcase value="ResendActivationEmail">
        	<cfset UserIDEn = Encrypt("#Url.UserID#", "Nx383487", "blowfish", "Hex")>              
			<cfftp connection="ActivateYourAccount"  action="open" port="22" server="76.12.83.231" username="photo" password="photo">
				<cfset link = "http://www.discountsoccersupply.com/store.cfm?action=activate&userID=#UserIDEn#">
<cfset body =  
"Dear Valued Customer,
 
	This is a form eMail please do not reply. Follow the link to activate your 
	DiscountSoccerSupply.com Account. If you have and problems please call us
	at. 1(909)919-7970.
	
	#variables.link#
	
	Thankyou from!
	DiscountSoccerSupply.com">
    
    <cfmail from="MailerJan@DiscountSoccerSupply.com"  to="#url.eMailAddress#"  subject="Activate Your Soccer Account"  
     server="76.12.83.231" port="25">
		#variables.body#
	</cfmail> 

 
<cfftp action="close" connection="ActivateYourAccount"> 
   <cflocation url="CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=SearchCustomers&UserID=#url.key#">     
        </cfcase>
        
        <cfcase value="Redirect">
			<cflocation url="MemberEditPage.cfm?Key=#URL.Key#">
				</cfcase>                
    				</cfswitch>
    
		<!-- 
     Here is the first of two switches and is a switch that controlls the opening and closing of page sections. It accesses the "sectionOperations" 
     object which inturn calls its' two methods: "sectionOpen" and "sectionClose" to open and close page sections.
    -->

	<cfswitch expression="#url.action#">
		<cfcase value="CloseSectionF">
			<cfscript>
				sectionOperations.sectionClose("SectionF");
					</cfscript>
						</cfcase>
                    
		<cfcase value="OpenSectionF">
			<cfscript>
				sectionOperations.sectionOpen("SectionF");
					</cfscript>
						</cfcase>
                        	</cfswitch>
	
    <!--
 	 Here is the fourth of four switches. This switch controlls the number of query rows per page. Options are 15, 30, 60, 100. 
   	 The user entery is recorded using the url structure and accessed using links towards the bottom of the query results. 
   	-->
    <cfif structKeyExists(url, "RowsPerPageE")>   
	<cfswitch expression="#url.RowsPerPageE#">
		<cfcase value="5">		
			<cfscript>
				rowOperations.numberOfRowsUpdate(5, #url.RowsPerPageE#);
					</cfscript>
            			</cfcase>
		<cfcase value="10">
        	<cfscript>
				rowOperations.numberOfRowsUpdate(5, #url.RowsPerPageE#);
					</cfscript>
        				</cfcase>
		<cfcase value="15">
       		<cfscript>
				rowOperations.numberOfRowsUpdate(5, #url.RowsPerPageE#);
					</cfscript>
        				</cfcase>      
            	
		<cfcase value="30">
        	<cfscript>
				rowOperations.numberOfRowsUpdate(5, #url.RowsPerPageE#);
					</cfscript>
        				</cfcase>
							</cfswitch>
                            	</cfif>
   
    <!-- 
	 Here several local variables are set using two objects which have been instantiated in the application and locally accessed 
     using the session. 
    -->
           
		<cfset SectionF = sectionOperations.getSectionInformation("SectionF")>        		
		<cfset NumberOfRowsPerPage = rowOperations.getRowInformation()>                          
        
	<!-- 
     Here follows some code which is used for the next-N portion of the page. The "totalrows" are obtained through the session, whereas, 
     the "startrow"  information is gathered from the url. The "enRow" is contructed from the information given and the next-N technology 
     is on its way!
    -->

		<cfset totalRows 	= getCustomerInformationRet.recordCount>
		<cfset endRow    	= min(URL.startRow + NumberOfRowsPerPage[5], totalRows)>
		<cfset startrow  	= URL.startRow>
		<cfset startRowNext = startRow+ NumberOfRowsPerPage[5]>
		<cfset startRowBack = URL.startRow - NumberOfRowsPerPage[5]>
        
    <!-- The Next-N Syntax for the Second Query on the Page. -->
        
        <cfset totalRowsTwo 	= NumberOfRowsPerPage[5]>
		<cfset endRowTwo    	= min(URL.startRowTwo + NumberOfRowsPerPage[5], totalRowsTwo)>
		<cfset startrowTwo  	= URL.startRowTwo>
		<cfset startRowNextTwo  = endRowTwo + 1>
		<cfset startRowBackTwo  = URL.startRowTwo - NumberOfRowsPerPage[5]>


	<!--
     Here is the beginning of the html section of the code
    -->

<html>
	<head>
		<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
		<!-- Here is were the form actions for the "searchOrderForm" are adjusted using javascript function fun fun fun! -->
    		<script type="text/javascript">
				function searchOrders(actionLink, formID, startRow)
					{															
						var x=document.getElementById(formID);
						x.action=actionLink+"&startRow="+startRow;
						x.submit();
								}
									</script>                                        
										</head>
                                        
<cfoutput>
	<body  background="images/Area Fill/backgroundGeneral.jpg" topmargin="0" onLoad="scrollTo(#variables.x#,#variables.y#)">
    	<center>
		
        <table width="1091" border="0" cellpadding="0" cellspacing="0" onMouseOver="cursor:pointer">   
		  <tr valign="top">
	  			<td height="29" colspan="8" align="right" bgcolor="FF9933"><!-- Here is a Short Form that controls the logout buttons for the page. --> 
                
                
                <cfform>                            
						<cfif structKeyExists(COOKIE, "admin")>
   							<cfinput name="LogOutC" type="button" value="Log Out" 
      									onClick="window.open('LogOutC.cfm','_self')">&nbsp;&nbsp;
									<cfelse>
										<cfinput name="LogOutB" type="button" value="Log Out" 
      												onClick="window.open('LogOutB.cfm','_self')">
												&nbsp;&nbsp;
													</cfif>
														</cfform></td>
		  													</tr>
	
    		<tr>
	  			<td height="19" colspan="4" align="left" valign="top" bgcolor="##DDDDDD">&nbsp;</td>
      						<td height="19" colspan="4" align="right" bgcolor="##DDDDDD">&nbsp;</td>
		  							</tr>
			

            <tr>
	  			<td height="200" colspan="8" align="center" valign="middle" bgcolor="##FFFFFF"><font style="font-size:36px; color:##333333">A DiscountSoccerSupply.com: Customer Care</font></td>
      					</tr>
			 
             <tr bgcolor="FFFFFF">
			 	<td colspan="8" align="left" bgcolor="##DDDDDD" class="CustomerNumber">&nbsp;</td>
	      			</tr>
                    
			 <tr bgcolor="FFFFFF">
	  			<td colspan="8" align="left" background="images/Area Fill/MiddleBar.jpg" class="formheaders"><span onMouseOver="style.cursor='default'" onClick="window.open('http://www.discountsoccersupply.com/CustomerCareandOrderUpdatingSystem.cfm','_self')">
                	&nbsp;  &nbsp; Search by Order</span></td>
		  				</tr>
		
        	<tr bgcolor="FFFFFF">
	  			<td height="25" colspan="8" background="images/Area Fill/MiddleBar.jpg" class="formheaders"><span onMouseOver="style.cursor='default'" onClick="window.open('http://www.discountsoccersupply.com/CustomerCareandOrderUpdatingSystemPageTwo.cfm','_self')">&nbsp; &nbsp;&gt; Search by Member</span></td>
		  				</tr>
                        			
            <tr valign="top">
	  			<td height="39" colspan="8" align="right" bgcolor="DDDDDD">&nbsp;&nbsp;&nbsp;<span style="color:##666666" onMouseOver="style.cursor='default'">You are currently logged in as #cookie.UserID#</span></td>
			  </tr>
			
			
            <tr>
	  			<td colspan="5" align="left" valign="middle" background="images/Area Fill/Top-Left.jpg" onMouseOver="style.cursor='default'" class="PageHeaders">
                	&nbsp;&nbsp;Search by Member</td>
                    
			    <td align="center" background="images/Area Fill/Top-Middle.jpg">&nbsp;</td>
	  				<td width="165" align="center" background="images/Area Fill/Top-Middle.jpg">&nbsp;</td>
	  					<td width="100" align="right" valign="top" background="images/Area Fill/Top-Middle.jpg">&nbsp;</td>
		  						</tr>
                                           
    <!-- 
     Here is the beginning of Section F. Section F is a comparatively simple section. Section F allows the user to search for members 
     by any one of a number of criteria displayed in radio buttons. The results are displayed below where three buttons allow some simple
     functions to occure: MakePerferred, MakeStandard and a script function that controll a popup window!.
    -->
    
					<cfif sectionOperations.getSectionInformation("SectionF") eq "Open">
						<cfoutput>
 							<cfform name="searchMembersForm" action="something" method="post">
  
  
  			<tr height="50" bgcolor="##FFFFFF" class="formheaders">
    			<td width="37" height="35" align="left" bgcolor="##CCCCCC" onMouseOver="style.cursor='default'">&nbsp; &nbsp;</td>
									<td width="202" align="left" bgcolor="##CCCCCC" onMouseOver="style.cursor='default'">Parameter One</td>
									<td height="35" align="left" bgcolor="##CCCCCC" onMouseOver="style.cursor='default'">&nbsp;</td>
									<th height="35" align="left" bgcolor="##CCCCCC">&nbsp;</th>
									<th height="35" align="left" bgcolor="##CCCCCC">&nbsp;</th>
									<th height="35" align="left" bgcolor="##CCCCCC">&nbsp;</th>
									<th height="35" align="left" bgcolor="##CCCCCC">&nbsp;</th>
									<th height="35" align="left" bgcolor="##CCCCCC">&nbsp;</th>
  			</tr>
  
  			<tr height="50" valign="top">
    			<th height="28" align="left" bgcolor="##CCCCCC"> &nbsp; &nbsp;</th>
			    <th height="28" colspan="2" align="left" bgcolor="##CCCCCC"><cfinput type="text" name="SearchArea" id="SearchArea" value="#form.SearchArea#">
&nbsp;
<cfselect enabled="no" name="Select" multiple="no" >
<cfif structKeyExists(form, "Select")>
  <option>#Form.Select#</option>
</cfif>
<option value="CompanyName">Company Name</option>
<option value="LastName">Last Name</option>
<option value="FirstName">First Name</option>
<option value="EmailAddress">eMail Address</option>
<option value="UserID">UserID</option>
</cfselect>&nbsp; <cfinput type="button" name="Search" value="Search" onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=SearchCustomers','searchMembersForm',1);"></th>
		      <th align="center" bgcolor="##CCCCCC">&nbsp;</th>
    						<th align="center" bgcolor="##CCCCCC">&nbsp;</th>
    							<th align="center" bgcolor="##CCCCCC">&nbsp;</th>
    								<th bgcolor="##CCCCCC"></th>
			  							<th align="right" bgcolor="##CCCCCC">&nbsp;&nbsp;</th>
											</tr>
										


  			
             <tr>
               <td colspan="4" bgcolor="##CCCCCC">&nbsp;&nbsp;<cfif not variables.startRow is 1>
               
               <img src="images/icons/PrevButton.jpg" alt="Previous Page" width="20" height="19" onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=SearchCustomers','searchMembersForm','#variables.startRowBack#');"></cfif></td>
               <td colspan="4" bgcolor="##CCCCCC" align="right"><cfif variables.startRowNext lte getCustomerInformationRet.recordCount>
               
               <img src="images/icons/NextButton.jpg" alt="Next Page" width="20" height="19" onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=SearchCustomers','searchMembersForm','#variables.startRowNext#');">
               </cfif>                 &nbsp;&nbsp;</td>
               </tr>
                                         
  			<cfloop query="getCustomerInformationRet" startrow="#variables.startRow#" endrow="#variables.endRow#">
    			<cfoutput>
                <!-- Here is some code that determines the background color of each row in the query getCustomerInformationRet. -->
					<cfif getCustomerInformationRet.CurrentRow mod 2>
                    	<cfset backgroundColor="##CCCCCC">
                    <cfelse>
                    	<cfset backgroundColor="##CCCCCC">
                  </cfif>
                    <tr>
                      <td colspan="8" align="center" onMouseOver="style.cursor='default'">&nbsp;</td>
                    </tr>
                  <tr>
               <td bgcolor="##DDDDDD" colspan="8" align="center" onMouseOver="style.cursor='default'"><b> #UserID# </b> #LastName#, #FirstName#</td>
           </tr>
             <tr height="50" bgcolor="#variables.backgroundColor#">
    			<th height="28" align="center" onMouseOver="style.cursor='default'" >&nbsp;</th>
    				<th height="28" align="center" onMouseOver="style.cursor='default'" >Company Name</th>
    				<th align="center" onMouseOver="style.cursor='default'">UserID</th>
    					<th align="center" onMouseOver="style.cursor='default'">First Name</th>
    						<th align="center" onMouseOver="style.cursor='default'">Last Name</th>
    							<th width="169" align="center" onMouseOver="style.cursor='default'">Type</th>
    								<th align="center" onMouseOver="style.cursor='default'" colspan="2">
                                    
                                    <cfinput type="button" name="Edit" value="Standard" id="Edit3" 
    									onClick="window.location='CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=MakeStandard&Key=#UserID#'">&nbsp;
                                    <cfinput type="button" name="Edit" value="Preferred" id="Edit4" onClick="window.location='CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=MakePreferred&Key=#UserID#'">
                                    &nbsp; 
                                    <cfinput type="button" name="Activated" value="Activate" id="Activated" onClick="window.location='CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=Activate&Key=#UserID#'"></th>
											</tr>
                	<tr height="50" bgcolor="#variables.backgroundColor#">
      					<td height="30" align="center" onMouseOver="style.cursor='default'">&nbsp;</td>
      						<td height="30" align="center" onMouseOver="style.cursor='default'">#CompanyName#</td>
      						<td align="center" onMouseOver="style.cursor='default'">#UserID#</td>
      							<td align="center" onMouseOver="style.cursor='default'">#FirstName#</td>
      								<td align="center" onMouseOver="style.cursor='default'">#LastName#</td>
      									<td align="center" onMouseOver="style.cursor='default'">#AccessType#</td>
      										<td align="center" onMouseOver="style.cursor='default'" colspan="2">
                                            	<cfinput type="button" name="Edit" value="Edit Customer's Info"	id="Edit2" 
                                					onClick="window.open('Editcustomerinformationpage.cfm?UserID=#UserID#',
    'Window1','menubar=no,width=988,height=720,toolbar=no,scrollbars=yes')">&nbsp;
    											<cfinput type="button" name="Remove" value="Remove" id="Edit2" 
                                					onClick="window.open('RemoveCustomer.cfm?UserID=#UserID#',
    '_Blank','menubar=no,width=400,height=400,toolbar=no,scrollbars=yes')">    													</td>
				 											</tr>
           	  													</cfoutput>
    				
                    <tr height="50" bgcolor="#variables.backgroundColor#">
    					<td height="23" colspan="2" align="center">&nbsp;</td>
    						<td width="151" align="center">&nbsp;</td>
					  			<td width="127" align="center">&nbsp;</td>
					  				<td width="140" align="center">&nbsp;</td>
    									<td align="center">&nbsp;</td>    				
                    						<td colspan="2" align="center"><cfinput type="button" name="          ResendActivationeMail          " 
                                            	value="Re-Send Activation Email" onClick="window.open('CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=ResendActivationEmail&UserID=#UserID#&eMailaddress=#eMailaddress#&Key=#UserID#','_self')">&nbsp;</td>
			  										</tr>
                                                                                
    				<tr>
                    	<td bgcolor="##FFFFFF" colspan="8">&nbsp;</td>
                        	</tr>
							</cfloop>
						  </cfform>
					   </cfoutput>
		  			</cfif>
					<!-- Here lies the end of section F. -->
                    <tr>
                      <td colspan="8" align="left" valign="top">&nbsp;</td>
                    </tr>
                    <tr>
	  					<td colspan="8" bgcolor="##CCCCCC" align="left" valign="top"><cfif sectionOperations.getSectionInformation("SectionF") eq "Open">
	  					  &nbsp;&nbsp;&nbsp; <i onMouseOver="style.cursor='default'" onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=searchCustomers&RowsPerPageE=5','searchMembersForm','#url.startRow#');">5</i> <i onMouseOver="style.cursor='default'" onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=searchCustomers&RowsPerPageE=10','searchMembersForm','#url.startRow#');">10</i> <i onMouseOver="style.cursor='default'" onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=searchCustomers&RowsPerPageE=15','searchMembersForm','#url.startRow#');">15</i> <i onMouseOver="style.cursor='default'" onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystemPageTwo.cfm?action=searchCustomers&RowsPerPageE=30','searchMembersForm','#url.startRow#');">30</i>&nbsp;&nbsp;&nbsp;
                        </cfif>&nbsp;&nbsp;                                                                         	     </td>
		  		</tr>                                                					
                    <tr>
						<td colspan="8" bgcolor="FF9933">&nbsp;</td>
		  					</tr>	
								</table>
  </body>
										</cfoutput>
											</html>