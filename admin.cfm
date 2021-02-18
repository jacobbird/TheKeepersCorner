<cfif structKeyExists(COOKIE, "admin")>
	<cfelse>
		<cfparam name="originURL" default="http://#CGI.HTTP_HOST##CGI.SCRIPT_NAME#">
			<cflocation URL="http://www.discountsoccersupply.com/AdminLogin.cfm?originURL=#urlEncodedFormat(originURL)#">
				<cfabort>
					</cfif>

<cfparam name="FORM.radiobutton" default="LastName" type="string">
	<cfparam name="FORM.searchArea" default="" type="string">
		<cfparam name="URL.action" default="" type="string">
			<cfparam name="variables.msg" default="" type="string">
				<cfparam name="variables.adjustedbegindate" default="nothing" type="string">
					<cfparam name="variables.adjustedenddate" default="nothing" type="string">

<cfswitch expression="#url.action#">
	<cfcase value="GetCustomerList">
		<cflocation  url="CustomerList.cfm">
			</cfcase>

	<cfcase value="OrderFinder">
        <cfset adjustedBeginDate = 0>
          	<cfset adjustedEndDate = 0>
       	
        
		<cfif not isNumeric("#Form.Year#") and not isNumeric("#Form.Month#") and not isNumeric("#Form.Day#")>
          <!-- If none of the selection boxes are changed and the text box remains the same the report returned is for A(allTime).-->
			<cfset adjustedBeginDate = ToString(NumberFormat(20090101))>
          		<cf_tsconverter returnvariable="converterEndDate">
					<cfset adjustedEndDate = ToString("#converterEndDate#")>
                    	<script><cfoutput>window.open('OrdersReport.cfm?BeginDate=#adjustedBeginDate#&EndDate=#adjustedEndDate#','_blank')			
							</cfoutput></script>
                        
		<cfelseif isNumeric("#Form.Year#") and not isNumeric("#Form.Month#") and not isNumeric("#Form.Day#")>
        <!-- If the Year Box has a year in it but both the month and day boxes remain the same than a report for that year is returned.-->
        		<cfset adjustedBeginDate = ToString(NumberFormat("#Form.Year#"&"0101"))>
					<cfset adjustedEndDate = ToString(NumberFormat((LsParseNumber("#Form.Year#")+1)*10000))>
                		<script><cfoutput>window.open('OrdersReport.cfm?BeginDate=#adjustedBeginDate#&EndDate=#adjustedEndDate#','_blank')
							</cfoutput></script>
        
		<cfelseif isNumeric("#Form.Year#") and isNumeric("#Form.Month#") and not isNumeric("#Form.Day#")>
        <!-- 
         If the Year Box has a year, the month box has a month, but the day box remains the same then return a report for a given month 
       	 inside of a given year.
         -->
        	<cfset adjustedBeginDate = ToString(NumberFormat("#Form.Year#"&"#Form.Month#"&"01"))>
          		<cfset newMonth = LSParseNumber("#Form.Month#") + 1>
                   	<cfset newYear = ToString(LSParseNumber("#Form.Year#"))>
						<cfif newMonth gte 13>
                    		<cfset newMonth = 1>
                        		<cfset newYear = ToString(LSParseNumber("#Form.Year#") + 1)>
                        			<cfset newMonth = "0"&ToString(newMonth)>
                            			<cfelse>
                                			
						<cfif newMonth lt 10>
                        	<cfset newMonth = "0"&ToString(newMonth)>
                        		<cfelse>
                             		<cfset newMonth = ToString(newMonth)>
                                     	</cfif>
											</cfif>                        
											    <cfset adjustedEndDate = ToString(NumberFormat("#newYear#"&"#newMonth#"&"01"))>
                                                	
						<script><cfoutput>window.open('OrdersReport.cfm?BeginDate=#adjustedBeginDate#&EndDate=#adjustedEndDate#','_blank')
							</cfoutput></script>
                                
		<cfelseif isNumeric("#Form.Year#") and isNumeric("#Form.Month#") and isNumeric("#Form.Day#")>
        	<!-- Returns a report for that year, month, and day! -->
        		<cfset adjustedBeginDate = ToString(NumberFormat("#Form.Year#"&"#Form.Month#"&"#Form.Day#"))>
					<cfset adjustedEndDate = ToString(NumberFormat("#Form.Year#"&"#Form.Month#"&"#Form.Day#"))>
                    	<script><cfoutput>window.open('OrdersReport.cfm?BeginDate=#adjustedBeginDate#&EndDate=#adjustedEndDate#','_blank')
							</cfoutput></script>
                                        
		<cfelseif not isNumeric("#Form.Year#") and isNumeric("#Form.Month#") and not isNumeric("#Form.Day#")>
        <!-- If no year is present but a month is present than the month choosen is the month for the current year. -->
			<cf_TSNumberOfDaysInTheCurrentMonth CurrentMonth="#Form.Month#" returnvariable="NumberOfDaysInTheMonth">
				<cfset adjustedBeginDate = ToString(NumberFormat("#Year(now())#"&"#Form.Month#"&"01"))>
          			<cf_tsconverter returnvariable="converterEndDate">
						<cfset adjustedEndDate = ToString(NumberFormat(LSParseNumber("#adjustedBeginDate#")+#NumberOfDaysInTheMonth#-1))>
              				<script><cfoutput>window.open('OrdersReport.cfm?BeginDate=#adjustedBeginDate#&EndDate=#adjustedEndDate#','_blank')
								</cfoutput></script>
		
		<cfelseif not isNumeric("#Form.Year#") and not isNumeric("#Form.Month#") and isNumeric("#Form.Day#")> 
        <!-- If no year or month is present but a day is present than the day choosen is the day in the current month of the current year. -->
			<cf_TSCurrentMonth returnvariable="CurrentMonth">
				<cfset adjustedBeginDate = ToString(NumberFormat("#Year(now())#"&"#variables.CurrentMonth#"&"#Form.Day#"))>
					<cfset adjustedEndDate = "#adjustedBeginDate#">
                    	<script><cfoutput>window.open('OrdersReport.cfm?BeginDate=#adjustedBeginDate#&EndDate=#adjustedEndDate#','_blank')
							</cfoutput></script>            
		
		<cfelseif not isNumeric("#Form.Year#") and isNumeric("#Form.Month#") and isNumeric("#Form.Day#")> 
        <!-- If a month and a day are choosen on no year than the month and the day is choosen for thte current year. -->
        	<cfset adjustedBeginDate = ToString(NumberFormat("#Year(now())#"&"#Form.Month#"&"#Form.Day#"))>					
				<cfset adjustedEndDate = ToString(NumberFormat("#Year(now())#"&"#Form.Month#"&"#Form.Day#"))>
                	<script><cfoutput>window.open('OrdersReport.cfm?BeginDate=#adjustedBeginDate#&EndDate=#adjustedEndDate#','_blank')
						</cfoutput></script>
                                    
        <cfelseif isNumeric("#Form.Year#") and not isNumeric("#Form.Month#") and isNumeric("#Form.Day#")>
		<!-- If a year and a day is choosen an error occurs specifying that the process must be redone! preserve data please -->
			<cfset msg="The date entered was invalid please re-enter a date you would like for your order report.">
				<script><cfoutput>window.open('OrdersReport.cfm?BeginDate=#adjustedBeginDate#&EndDate=#adjustedEndDate#','_blank')</cfoutput>
                	</script>	
						</cfif>
                			</cfcase>

	<cfcase value="PutKeywords">
		<cfquery name="db" datasource="discountsoccer">
			INSERT INTO keywords (keywordname, keyword)
        	VALUES ('keyword', '#form.keywords#')
        	WHERE keywordname = 'keyword'
				</cfquery>
                	</cfcase>
						</cfswitch>

	<cfquery name="db" datasource="discountsoccer">
		SELECT *
		FROM employeeinformation
		WHERE #FORM.radiobutton# LIKE '%#FORM.searchArea#%'
		ORDER BY #FORM.radiobutton# DESC
			</cfquery>

<cfif isdefined("FORM.button")>
	<cfcookie name="fullname" value="admin">
		<cflocation url="Admin.cfm">
			</cfif>
            
<html>
	<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
		<style type="text/css">
			<!--
				.style3 {color: #CCCCCC}	
					-->
						</style>

<body bgcolor="FFFFFF" topmargin="0"><center>
	
    <table width="986" border="0" cellpadding="0" cellspacing="0" bgcolor="FFFFFF">
  		
        <tr>
    		<td height="64" colspan="9" align="left" >&nbsp; &nbsp; &nbsp; 
            	<span style="color:FF9933; font-size:36px">DiscountSoccerSupply.com</span></td>
	  </tr>
  		
        <tr>
    		<td height="50" colspan="5" align="left" valign="top" bgcolor="000000">&nbsp; &nbsp; &nbsp; 
            	<span style="color:FFFFFF; font-size:36px">Site Administration Page:</span></td>
    				<td colspan="4" align="Right" valign="bottom" bgcolor="000000"></td>
  						</tr>
  
  		<tr>
    		<td rowspan="2" bgcolor="#CCCCCC" ><span class="style3"></span></td>
    			<td colspan="3" height="50" rowspan="2" bgcolor="#CCCCCC"><cfform name="form8" action="Admin.cfm"><span class="style3">
      				<cfinput type="button" name="LogOutC" value="Log Out" onClick="window.open('LogOutC.cfm','_self')">
    					</span></cfform><span class="style3"></span><span class="style3"></span></td>
    						<td bgcolor="#CCCCCC"><span class="style3"></span></td>
   								<td width="119" bgcolor="#CCCCCC"><span class="style3"></span></td>
    			
                <td bgcolor="#CCCCCC"><span class="style3"></span></td>
    				<td colspan="2" rowspan="2" bgcolor="#CCCCCC" valign="middle">
                    	<cfform name="form" id="form" action="MailersPDF.cfm">
    						<span class="style3">
    							<cfinput type="submit" name="button" id="button" value="      Mailers     "/>
    								<cfinput type="hidden" name="hidden" value="value"></span></cfform></td>
  										</tr>
  		<tr bgcolor="CCCCCC">
    		<td height="25"></td>
    			<td></td>
    				<td align="right">&nbsp;</td>
  						</tr>
  
  		<tr bgcolor="CCCCCC">
    		<td>&nbsp;</td>
    			<td colspan="6">&nbsp;</td>
    				<td colspan="2">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                    	<a href="http://www.discountsoccersupply.com/adminTwo.cfm">
                        	<img src="images/icons/NextButtonBlack.jpg" width="20" height="20" border="0"></a></td>
  								</tr>
  		
        <tr>
  			<cfform name="form" id="form" action="AdminInfo.cfm" >
    			<td height="32">&nbsp; &nbsp;    </td>
    				<td colspan="2" valign="bottom"><cfinput type="submit" name="button" id="button2" value="Change Administrator Info" />
      					<cfinput type="hidden" name="hidden" value="value"></td>
  							</cfform>
    							<td align="center">&nbsp;</td>
    			<td>&nbsp;</td>    
    				<td></td>
    					<td align="right">&nbsp;</td>
    						<cfform name="form" id="form" action="CreateNewUser.cfm" >
    							<td colspan="2" align="left" valign="bottom">
                                	<cfinput type="submit" name="button" id="button3" value=" Add New User" />
    									<cfinput type="hidden" name="hidden" value="value">      &nbsp;&nbsp;  
                                        	</td>
  												</cfform>
  													</tr>
  
  		<tr>
    		<td></td>
    			<td></td>
    				<td></td>
    					<td></td>
    						<td></td>
    							<td></td>
    								<td></td>
    									<td colspan="2"></td>
  											</tr> 
  		
        <tr>
    		<td></td>
    			<td></td>
    				<td></td>
    					<td></td>
    						<td></td>
    							<td></td>
    								<td></td>
    									<td colspan="2"></td>
  											</tr>
  
  		<tr bgcolor="000000">
    		<td height="32" align="left" class="WhiteWarning">&nbsp;</td>
    			<td height="32" colspan="3" align="left" class="WhiteWarning">Login Information </td>
    				<td></td>
    					<td></td>
    						<td></td>
    							<td colspan="2"></td>
  									</tr>
  								
       	<tr bgcolor="CCCCCC">
    		<td colspan="9" valign="middle">&nbsp;</td>
  				</tr>
  
  		<tr>
    		<td colspan="9" valign="middle" bgcolor="EEEEEE"><cfform name="form1" id="form1" method="post" action="Admin.cfm">
      			<label>
        			&nbsp; &nbsp; &nbsp; &nbsp;<cfinput type="text" name="searchArea" id="searchArea">
      					</label>      
      						<label>
        						<cfinput type="submit" name="searchDictionary" value="Search" id="searchDictionary">
      								</label>
      									<label>
        									<cfinput type="radio" name="radiobutton" value="LastName" id="radiobutton" required="yes">
        										Last Name</label>
      			<label>
        			<cfinput type="radio" name="radiobutton" value="FirstName" id="radiobutton2" required="yes">
        				First Name </label>
      						<cfinput type="radio" name="radiobutton" value="AccessType" id="radiobutton3" required="yes">
      							Access Type
      								<cfinput type="radio" name="radiobutton" value="UserID" id="radiobutton4" required="yes">
      									UserID </cfform></td>
  											</tr>
  
  		<tr bgcolor="EEEEEE">
    		<th>&nbsp;</th>
    			<th>&nbsp;</th>
    				<th>&nbsp;</th>
    					<th>&nbsp;</th>
    						<th>&nbsp;</th>
    							<th>&nbsp;</th>
    								<th>&nbsp;</th>
   										<th colspan="2">&nbsp;</th>
  											</tr>
  
  		<tr>
    		<th>&nbsp;</th>
    			<th>&nbsp;</th>
    				<th>&nbsp;</th>
    					<th>&nbsp;</th>
    						<th>&nbsp;</th>
    							<th>&nbsp;</th>
    								<th>&nbsp;</th>
    									<th colspan="2">&nbsp;</th>
  											</tr>
  
		<tr bgcolor="CCCCCC">
    		<th width="20">&nbsp;</th>
    			<th width="149">First Name</th>
    				<th width="138">Last Name</th>
    					<th width="92">User ID</th>
    						<th width="102">Password</th>
    							<th>Access Type</th>
    								<th width="216">Reminder</th>
    									<th colspan="2">&nbsp;</th>
  											</tr>
  
  	<cfoutput query="db">
    	<tr bgcolor="EEEEEE">
      		<td align="center">&nbsp;</td>
      			<td align="center">#db.FirstName#</td>
      				<td align="center">#db.LastName#</td>
      					<td align="center">#db.UserID#</td>
      						<td align="center">#db.password#</td>
      							<td align="center">#db.AccessType#</td>
      								<td align="center">#db.Reminder#</td>
      									<td colspan="2"><a href="Removeuser.cfm?UserID=#db.userID#">Remove User</a></td>
    										</tr>
   		<tr>
      		<td>&nbsp;</td>
      			<td></td>
      				<td></td>
      					<td></td>
      						<td></td>
      							<td></td>
      								<td></td>
      									<td colspan="2"></td>
    										</tr>
  												</cfoutput>
  
  		<tr>
    		<td>&nbsp;</td>
    			<td></td>
    				<td></td>
    					<td></td>
    						<td></td>
    							<td></td>
    								<td></td>
    									<td colspan="2"></td>
  											</tr>
  
  		<tr height="50" bgcolor="000000">
    		<td height="32" align="left" class="WhiteWarning">&nbsp; &nbsp;</td>
    			<td height="32" colspan="3" align="left" class="WhiteWarning"> Reports</td>
    				<td height="32" align="left" class="WhiteWarning">&nbsp;</td>
   						<td></td>
    						<td></td>
    							<td colspan="2"></td>
  									</tr>
  
  	<cfform name="form1" id="form1" method="post" action="Admin.cfm">
  		
        <tr height="50" bgcolor="EEEEEE">
    		<td align="center" >
    			<td height="58" colspan="6" align="left" >
                
                	<cfinput type="button" name="Submit" value=" Orders   Today   " onClick="window.open('http://www.discountsoccersupply.com/DailyOrders.cfm','OrdersToday',
'menubar=no,width=995,height=1200 ,toolbar=no, resizeable=yes, scrollbars=yes')">
      				<cfinput type="button" name="Submit" value="      Orders    Total       " onClick="window.open('http://www.discountsoccersupply.com/TotalOrders.cfm',
    'OrdersTotal','menubar=no,width=995,height=1200 ,toolbar=no, resizeable=yes, scrollbars=yes')">
      				<cfinput type="button" name="Submit" value="Customers  List  " onClick="window.open('http://www.discountsoccersupply.com/CustomerList.cfm','CustomerList',
'menubar=no,width=995,height=1200 ,toolbar=no, resizeable=yes, scrollbars=yes')">

    			<td colspan="2"></td>
  					</tr>
                     
                    	</cfform>
  
  		<tr height="50" bgcolor="EEEEEE">
    		<td align="center">
    			<td height="61" colspan="6" align="left">
                	
                    <cfform name="ComprehensiveOrderFinder" action="Admin.cfm?action=OrderFinder">
      					<label>
      						<cfinput type="Submit" name="Submit" value="       Get An Order Report      " >
      							</label>
      								<cfinput name="Year" type="text" value="Enter a Year Here.">
      				
                    <cfselect name="Month" multiple="no">
      					<option>All</option>
      						<option>01</option>
      							<option>02</option>
      								<option>03</option>
      									<option>04</option>
      										<option>05</option>
      						<option>06</option>
      							<option>07</option>
     								<option>08</option>
      									<option>09</option>
      										<option>10</option>
      											<option>11</option>
      												<option>12</option>
      													</cfselect>
      
      <cfselect name="Day" multiple="no">
      	<option>All</option>
        	<option>01</option>
        		<option>02</option>
        			<option>03</option>
        				<option>04</option>
        					<option>05</option>
        						<option>06</option>
        	<option>07</option>
        		<option>08</option>
        			<option>09</option>
        				<option>10</option>
        					<option>11</option>
        						<option>12</option>
        							<option>13</option>
        		<option>14</option>
        			<option>15</option>
        				<option>16</option>
        					<option>17</option>
        						<option>18</option>
        							<option>19</option>
        								<option>20</option>
        			<option>21</option>
        				<option>22</option>
        					<option>23</option>
        						<option>24</option>
        							<option>25</option>
        								<option>26</option>
        									<option>27</option>
        				<option>28</option>
        					<option>29</option>
        						<option>30</option>
        							<option>31</option>
      									</cfselect>
      										</cfform>    
      											</td>
    										<td colspan="2"></td>
  												</tr>
 
	<tr bgcolor="000000" >
    	<td height="31">&nbsp;</td>
    		<td height="31" colspan="3"><span class="WhiteWarning">Recent Orders</span></td>
    			<td height="31">&nbsp;</td>
    				<td height="31">&nbsp;</td>
    					<td height="31">&nbsp;</td>
    						<td width="43" height="31">&nbsp;</td>
    							<td width="107" height="31">&nbsp;</td>
  									</tr>
  	
    <tr>
    	<td height="31"></td>
    		<td></td>
    			<td></td>
    				<td></td>
    					<td></td>
    						<td></td>
    							<td></td>
    								<td colspan="2"></td>
  										</tr>

	<tr>
    	<td height="128" colspan="9" align="center">
        	<iframe name="RecentOrders" width="865px" height="500px" src="RecentOrders.cfm" marginwidth="0" marginheight="0"  frameborder="0">
            	</iframe>
                	</td>
  						</tr>

  	<tr>
    	<td height="18"></td>
    		<td></td>
    			<td></td>
    				<td></td>
    					<td></td>
    						<td></td>
    							<td></td>
    								<td colspan="2"></td>
  										</tr>
  											
<cfform>
    <tr bgcolor="#000000">
    	<td height="61" valign="middle" align="left" ></td>
    		<td height="61" colspan="8" align="left" valign="middle" class="WhiteWarning" >Links:  
      			<cfinput type="button" name="Submit" value="Customer Care Center" 
        			onClick="window.open('http://www.discountsoccersupply.com/CustomerCareAndOrderUpdatingSystem.cfm','Window6')">
      					<cfinput type="button" name="Submit" value="Warehouse and Inventory Controll" 
                        	onClick="window.open('http://www.discountsoccersupply.com/warehousepage.cfm','Window7')"></td>
  								</tr>
                                	</cfform>
										
                                </table>
									</body>
										</html>

<!-- The End -->