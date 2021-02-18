
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
			<cfset originURL = "http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystem.cfm">
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
	<cfparam name="form.RadioButtons"	type="string" default="">
    <cfparam name="form.searchParameterOne"	type="string" default="">
    <cfparam name="form.searchParameterTwo"	type="string" default="">
    <cfparam name="form.searchParameterThree"	type="string" default="">
    <cfparam name="form.searchColumnOne"	type="string" default="UserID">
    <cfparam name="form.searchColumnTwo"	type="string" default="Zip">
    <cfparam name="form.searchColumnThree"	type="string" default="Date">
    
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

	<cfswitch expression="#url.action#">
		<cfcase value="CloseSectionE">
			<cfscript>
				sectionOperations.sectionClose("SectionE");
					</cfscript>
						</cfcase>
                    
		<cfcase value="OpenSectionE">
			<cfscript>
				sectionOperations.sectionOpen("SectionE");
					</cfscript>
						</cfcase>

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
     Here is the second of three switches. This switch regulates four actions on the page: SearchCustomers, MakeStandard, MakePerferred and 
     a simple Redirect.   
    -->
	
    <cfswitch expression="#url.action#">
		<cfcase value="SearchCustomers">
			<cfif not form.radiobuttons eq "">
				<cfinvoke component="AdministrationComponent" method="getCustomerInformation" returnvariable="getCustomerInformationRet">
					<cfinvokeargument name="SearchParameterOne" value="#Form.RadioButtons#">
						<cfinvokeargument name="SearchParameterTwo" value="#Form.SearchArea#">
                			</cfinvoke>
								<cfset x = 0>
									<cfset y = 1000>
		<cfelse>
			<cfset errmsg eq "Must Specify a Search Parameter!">
            	<cfset x = 0>
					<cfset y = 1000>
						</cfif>
							</cfcase>

		<cfcase value="MakeStandard">
			<cfinvoke component="AdministrationComponent" method="MakeStandard">
				<cfinvokeargument name="UserID" value="#URL.Key#">
					</cfinvoke>
						<cflocation url="CustomerCareAndOrderUpdatingSystem.cfm">
							</cfcase>

		<cfcase value="MakePerferred">
			<cfinvoke component="AdministrationComponent" method="MakePrefered">
				<cfinvokeargument name="UserID" value="#URL.Key#">
					</cfinvoke>
						<cflocation url="CustomerCareAndOrderUpdatingSystem.cfm">
							</cfcase>
                        
		<cfcase value="Redirect">
			<cflocation url="MemberEditPage.cfm?Key=#URL.Key#">
				</cfcase>

		<cfcase value="Search">
			<cfset s = structnew() >
				<cfset s.searchparameterone = "#form.searchparameterone#">
					<cfset s.searchparametertwo = "#form.searchparametertwo#" >
						<cfset s.searchparameterthree = "#form.searchparameterthree#" >
			<cfset s.searchcolumnone = "#form.searchcolumnone#" >
				<cfset s.searchcolumntwo = "#form.searchcolumntwo#" >
					<cfset s.searchcolumnthree = "#form.searchcolumnthree#" >
                    	<cfinvoke component="CustomerCareComponent" method="orderQueryone" 
                         returnvariable="orderQueryOneRet" argumentcollection="#s#" />
							</cfcase>

		<cfcase value="none">
    		<cfinvoke component="CustomerCareComponent" method="orderQueryone" returnvariable="orderQueryOneRet" />
    			</cfcase>
    				</cfswitch>
    
	<!--
     Here is the thrid of four switches. This switch controlls the number of query rows per page. Options are 15, 30, 60, 100. 
     The user entery is recorded using the url structure and accessed using links towards the bottom of the query results. 
    -->
	<cfif structKeyExists(url, "RowsPerPageD")>
	<cfswitch expression="#url.RowsPerPageD#">
		<cfcase value="5">		
			<cfscript>
				rowOperations.numberOfRowsUpdate(4, #url.RowsPerPageD#);
					</cfscript>
            			</cfcase>
		<cfcase value="10">
        	<cfscript>
				rowOperations.numberOfRowsUpdate(4, #url.RowsPerPageD#);
					</cfscript>
        				</cfcase>
		<cfcase value="15">
       		<cfscript>
				rowOperations.numberOfRowsUpdate(4, #url.RowsPerPageD#);
					</cfscript>
        					</cfcase>      
            	
		<cfcase value="30">
        	<cfscript>
				rowOperations.numberOfRowsUpdate(4, #url.RowsPerPageD#);
					</cfscript>
        				</cfcase>
							</cfswitch>
                            	</cfif>
                            
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
    
    <!-- A Patch to fix the URL.startRow ERROR temporay until a more permanent solution is found! -->
    
    <cfif not structKeyExists(url, "startRow") or url.startRow is "undefined" or url.startRow lte 0>
    	<cfset url.startRow = 1>
    </cfif>
 
    <!-- 
	 Here several local variables are set using two objects which have been instantiated in the application and locally accessed 
     using the session. 
    -->
     
        <cfset SectionD = sectionOperations.getSectionInformation("SectionD")>          
		<cfset SectionE = sectionOperations.getSectionInformation("SectionE")>        		
		<cfset NumberOfRowsPerPage = rowOperations.getRowInformation()>                          
        
	<!-- 
     Here follows some code which is used for the next-N portion of the page. The "totalrows" are obtained through the session, whereas, 
     the "startrow"  information is gathered from the url. The "enRow" is contructed from the information given and the next-N technology 
     is on its way!
    -->

		<cfset totalRows 	= orderQueryOneRet.recordCount>
		<cfset endRow    	= min(URL.startRow + NumberOfRowsPerPage[4], totalRows)>
		<cfset startrow  	= URL.startRow>
		<cfset startRowNext = startRow+ NumberOfRowsPerPage[4]>
		<cfset startRowBack = URL.startRow - NumberOfRowsPerPage[4]>
        
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
        	<table width="1099" border="0" cellpadding="0" cellspacing="0" onMouseOver="cursor:pointer" >   
		  		<tr  valign="top">
	  				<td height="29" colspan="7" align="right" bgcolor="FF9933"><cfform>                            
						<!-- Here is a Short Form that controls the logout buttons for the page. -->
							<cfif structKeyExists(COOKIE, "admin")>
   								<cfinput name="LogOutC" type="button" value="Log Out" 
      									onClick="window.open('LogOutC.cfm','_self')">&nbsp;&nbsp;
									<cfelse>
										<cfinput name="LogOutB" type="button" value="Log Out" 
      												onClick="window.open('LogOutB.cfm','_self')">
												&nbsp;&nbsp;
													</cfif>
														</cfform>                                                        	</td>
		  														</tr>
	
    		<tr>
	  			<td height="19" colspan="3" align="left" valign="top" bgcolor="##DDDDDD">&nbsp;</td>
<td height="19" colspan="4" align="right" bgcolor="##DDDDDD">&nbsp;</td>
			  </tr>
			
    		
            <tr valign="top">
	  			<td height="200" colspan="7" align="Center" valign="middle" bgcolor="##FFFFFF"><font style="font-size:36px; color:##333333">A DiscountSoccerSupply.com: Customer Care</font></td>
		  			</tr>
			
			<tr >
	  			<td colspan="7" align="left" valign="bottom" bgcolor="##DDDDDD">&nbsp;</td>
           	 		</tr>
                    
            <tr bgcolor="FFFFFF">
	  			<td height="30" colspan="7" background="images/Area Fill/MiddleBar.jpg" class="formheaders">&nbsp; &nbsp;
                	<span onMouseOver="style.cursor='default'"
                    	onClick="window.open('http://www.discountsoccersupply.com/CustomerCareandOrderUpdatingSystemPageTwo.cfm','_self')">
                        	Search by Member</span>                            	</td>
		  							</tr>
	
    		<tr bgcolor="FFFFFF">
	  			<td colspan="7" align="left" background="images/Area Fill/MiddleBar.jpg" class="formheaders">
                	&nbsp;  &nbsp;<span onMouseOver="style.cursor='default'" 
                    	onClick="window.open('http://www.discountsoccersupply.com/CustomerCareandOrderUpdatingSystem.cfm','_self')">
                        	&gt;Search by Order</span></td>
		  						</tr>
			
            <tr>
	  			<td colspan="7" align="right" bgcolor="DDDDDD">&nbsp;<span style="color:##666666" onMouseOver="style.cursor='default'">
                	You are currently logged in as #cookie.UserID#</span>&nbsp; &nbsp;<br><br></td>
		  				</tr>
            
           	<tr>
	  			<td height="23" colspan="3" align="left" bgcolor="DDDDDD" class="PageHeaders"> &nbsp; Search by Order                	</td>
      					<td height="23" align="left" bgcolor="DDDDDD">&nbsp;</td>
      						<td height="23" colspan="3" align="right" valign="top" bgcolor="DDDDDD">&nbsp;</td>
		  							</tr>
        
        <!-- 
         This line demarkates the beginning of Section E. This section contains a form that allows precise searching of an unlimited 
         number of orders, as wellas, a button that provides a popup link to the edit order information page. The query, invoked by 
         this form, uses three parameters to provide accuracy of searches. The arguments are passes to the function using an invoke 
         statement found towards the top of the page. The action for this form is "search" and is the case to look into when adjusting 
         this section thanks!       
        -->                                
		
		
		<cfif sectionOperations.getSectionInformation("SectionE") eq "Open">
			<tr bgcolor="FFFFFF" class="formheaders">
	  			<td height="35" align="left" bgcolor="DDDDDD" onMouseOver="style.cursor='default'">&nbsp; &nbsp; </td>
	  				<td height="35" align="left" bgcolor="DDDDDD" onMouseOver="style.cursor='default'">Parameter One</td>
	  				<td colspan="2" align="left" bgcolor="DDDDDD" onMouseOver="style.cursor='default'">Parameter Two </td>
			  <td colspan="2" align="left" bgcolor="DDDDDD" onMouseOver="style.cursor='default'">Parameter Three</td>
			  <td width="179" align="left" bgcolor="DDDDDD" >&nbsp;</td>
		  </tr>
    
    	<cfform name="form" action="something" id="searchOrdersForm" method="post">
			<tr bgcolor="##FFFFFF">
        		<td height="29" align="left" bgcolor="DDDDDD" >&nbsp; &nbsp;&nbsp;</td>
  		
        		<td height="29" align="left" bgcolor="DDDDDD" ><cfinput type="text" name="searchparameterone" typeahead="no" showautosuggestloadingicon="true" value="#form.searchparameterone#">
        		  <cfselect enabled="No" name="searchColumnOne" multiple="no">
                  <cfif structKeyExists(form, "searchColumnOne")>
                    <option value="#form.searchColumnOne#">#form.searchColumnOne#</option>
                  </cfif>
                  <option value="UserID">UserID</option>
                  <option value="CompanyName">Company Name</option>
                  <option value="LastName">Last Name</option>
                  <option value="TaxID">TaxID</option>
                  </cfselect></td>
        		<td colspan="2" align="left" bgcolor="DDDDDD" >
                	<cfinput type="text" name="searchParameterTwo" typeahead="no" showautosuggestloadingicon="true" 
                     value="#form.searchparametertwo#">&nbsp;
       	  				<cfselect enabled="No" name="searchColumnTwo" multiple="no">
                        	<cfif structKeyExists(form, "searchColumnTwo")>
                            	<option value="#form.searchColumnTwo#">#form.searchColumnTwo#</option>
                            </cfif>
                            <option value="State">State</option>
                            <option value="Zip">Zip</option>
       	 					<option value="Street">Street</option>
                            <option value="OrderNumber">OrderNumber</option>
   	    						</cfselect>                                	</td>
                            
	  			<td colspan="2" align="left" bgcolor="DDDDDD" ><cfinput type="text" name="searchparameterthree" typeahead="no" showautosuggestloadingicon="true" 
                     value="#form.searchparameterthree#">&nbsp;
        				<cfselect enabled="No" name="searchColumnThree" multiple="no">
                        	<cfif structKeyExists(form, "searchColumnThree")><cfelse>
                            	<option value="#form.searchColumnThree#">#form.searchColumnThree#</option>
                            </cfif>
                            <option value="FirstName">First Name</option>
            				<option value="Date">Date</option>
        						</cfselect>                                	</td>
                                    
		        <td align="left" bgcolor="DDDDDD">
                	<cfinput type="button" name="Search" value="Search" 
                    	onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystem.cfm?action=search','searchOrdersForm','1');">                        	</td>
								</tr>
                    
			<tr bgcolor="##CCCCCC" valign="middle">
    			<td align="left" bgcolor="DDDDDD">
					&nbsp;&nbsp;<cfif not variables.startRow is 1>
                		<img src="images/icons/PrevButton.jpg" alt="Previous Page" width="20" height="19" onMouseOver="cursor:default" onClick="searchOrders('http:/www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystem.cfm?action=search','searchOrdersForm','#variables.startRowBack#');">
								</cfif>                                	</td>
                                         
					<td colspan="5" align="right" bgcolor="DDDDDD">&nbsp;</td>
		        		<td align="right" bgcolor="DDDDDD"><cfif variables.startRowNext lte orderQueryOneRet.recordCount>
                            <img src="images/icons/NextButton.jpg" alt="Next Page" width="20" height="19" onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystem.cfm?action=search','searchOrdersForm','#variables.startRowNext#');"></cfif>&nbsp;&nbsp;             </td>
											</tr>
    
				<cfset index = 0>
    				<cfloop query="orderQueryOneRet" startrow="#variables.startrow#" endrow="#variables.endrow#">
    					<cfset index = index + 1>
      			
					  <cfif index mod 2>
           					<cfset rowColor="##CCCCCC">
								<cfelse>
        							<cfset rowColor="##CCCCCC">
					  					</cfif>
	
    		          <tr>
    		            <th colspan="7">&nbsp;</th>
  		            </tr>
    		          <tr>
      			<th colspan="7" bgcolor="##DDDDDD">OrderNumber: #OrderNumber#</th>
    				</tr>
    
    		<tr bgcolor="#variables.rowColor#">
	  			<th colspan="7">&nbsp;</th>
					</tr>
	
    <!-- Here the results of the "search" query are displayed. From here a link is provided to the edit order information page.  -->
    
    		<tr bgcolor="#variables.rowColor#">
	  			<th width="60" onMouseOver="style.cursor='default'">UserID</th>
	  				<th width="258" onMouseOver="style.cursor='default'">Last Name</th>
  			  <th width="155" onMouseOver="style.cursor='default'">First Name</th>
			  				<th width="147" onMouseOver="style.cursor='default'">M.I.</th>
			  <th colspan="2" onMouseOver="style.cursor='default'">TaxID</th>
	  								<th onMouseOver="style.cursor='default'">Date</th>
 					  </tr>
                                        
			<tr bgcolor="#variables.rowColor#">
	  			<td align="center" onMouseOver="style.cursor='default'">#UserID#</td>
	  				<td align="center" onMouseOver="style.cursor='default'">#LastName#</td>
	  					<td align="center" onMouseOver="style.cursor='default'">#FirstName#</td>
	  						<td align="center" onMouseOver="style.cursor='default'">#MiddleInitial#</td>
	  							<td colspan="2" onMouseOver="style.cursor='default'" align="center">#TaxID#</td>
	  								<td align="center" onMouseOver="style.cursor='default'">#Date#</td>
					  					</tr>
	
    		<tr align="center" bgcolor="#variables.rowColor#">
	  			<td>&nbsp;</td>
	  				<td>&nbsp;</td>
	  					<td>&nbsp;</td>
	  						<td>&nbsp;</td>
	  							<td width="139">&nbsp;</td>
			  <td width="161">&nbsp;</td>
	  									<td>&nbsp;</td>
					  </tr>
	
    		<tr align="center" bgcolor="#variables.rowColor#">
            	<th onMouseOver="style.cursor='default'">Street</th>
	  				<th onMouseOver="style.cursor='default'">State</th>
	  					<th onMouseOver="style.cursor='default'">Zip</th>
	  						<th onMouseOver="style.cursor='default'" colspan="3">CC Number</th>
	  							<th onMouseOver="style.cursor='default'">&nbsp;</th>
                      				</tr>
                                    
			<tr align="center" bgcolor="#variables.rowColor#">
	  			<td onMouseOver="style.cursor='default'">#Street#</td>
	  				<td onMouseOver="style.cursor='default'">#State#</td>
	  					<td onMouseOver="style.cursor='default'">#Zip#</td>
	  						<td onMouseOver="style.cursor='default'" colspan="3">#CCNumberLastFour#</td>
	  							<td onMouseOver="style.cursor='default'">&nbsp;
	    							<cfinput type="Button" name="Edit" value="Edit" id="Edit" 
                                     onClick="window.open('EditOrderInformationPage.cfm?OrderNumber=#OrderNumber#','window11','resizeable=yes, scrollbars=yes, toolbar=no, menubar=no, width=999 ,height=800' )">&nbsp;			  </td>
					  						</tr>
    
    		<tr bgcolor="#variables.rowColor#">
      			<td bgcolor="##FFFFFF" colspan="7">&nbsp;</td>
      				</tr>
						</cfloop>
		 					</cfform>
		  						</cfif>
    		
            <!-- Here lies the end of Section E :```0( -->
            
            <tr>
              <td colspan="7" align="left">&nbsp;</td>
            	</tr>
                
            <tr bgcolor="##CCCCCC">
     			<td colspan="7" align="left" onMouseOver="style.cursor='default'">
				
            <!-- 
             Here are the links that control the number of rows displayed for the query in Section E. These links use the javascript 
             function to resubmit the form "searchOrdersForm" which has previously been populated with the former form information 
             hence preserving the original seach whilst adjusting the number of rows per page. The nice thing about this is that all
             six search parameters remain visable in the form feilds while the changes are taking place and all of the action remain 
             on the page as opposed to accessing the session! 
            -->
          
				<cfif sectionOperations.getSectionInformation("SectionE") eq "Open">&nbsp;&nbsp;&nbsp;
                	<i onMouseOver="style.cursor='default'" onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystem.cfm?action=search&RowsPerPageD=5','searchOrdersForm');">5</i> 
                    <i onMouseOver="style.cursor='default'"  onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystem.cfm?action=search&RowsPerPageD=10','searchOrdersForm','#url.startRow#');">10</i> 
                    <i onMouseOver="style.cursor='default'"  onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystem.cfm?action=search&RowsPerPageD=15','searchOrdersForm','#url.startRow#');">15</i> 
                    <i onMouseOver="style.cursor='default'"  onClick="searchOrders('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystem.cfm?action=search&RowsPerPageD=30','searchOrdersForm','#url.startRow#');">30</i>&nbsp;&nbsp;&nbsp;
											</cfif>                                            	</td>
		  											</tr>
    		
            	<tr>
	  				<td colspan="7"  bgcolor="FF9933">&nbsp;</td>
		  				</tr>
							</table>
  								</body>
									</cfoutput>
										</html>