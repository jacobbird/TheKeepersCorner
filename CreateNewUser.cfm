<cfif structKeyExists(COOKIE, "admin")>
<cfelse>
<cfparam name="originURL" default="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
<cflocation URL="AdminLogin.cfm?originURL=#urlEncodedFormat(originURL)#">
<cfabort>
</cfif>

<html>
<body>
<center>
<cfparam name="URL.state" default="" type="string">
<cfform name="form1" id="form1" method="post" action="NewUser.cfm">
<table width="518" border="0" cellpadding="4">
  <tr>
    <td colspan="2" align="Center"><p> Add New Users Page:</p>
    <p><strong>Important:</strong> remember that <u>all users</u> will be able to change data on the server!! Only add user if you want them to be able to change data!!</p></td>
  </tr>
  <tr>
    <td width="150" align="right">First Name:</td>
    <td width="346">
      <label>
      <cfinput type="text" name="FirstName" id="FirstName" required="yes">
      </label>    </td>
  </tr>
  <tr>
    <td align="right">Last Name:</td>
    <td>
      <label>
      <cfinput type="text" name="LastName" id="LastName" required="yes">
      </label>    </td>
  </tr>
  <tr>
    <td height="35" align="right">UserName:</td>
    <td>
      <label>
      <cfinput type="text" name="UserID" id="UserID" required="yes">
      </label>    </td>
  </tr>
  <tr>
    <td align="right">Password:</td>
    <td>
      <label>
      <cfinput type="password" name="Password" id="Password" maxlength="12" required="yes">
      </label>   </td>
  </tr>
  <tr>
    <td align="right">re-type Password:</td>
    <td>
      <label>
      <cfinput type="password" name="Password2" id="Password2" maxlength="12" required="yes">
      </label>   </td>
  </tr>
  <tr>
    <td align="right">Access Type:</td>
    <td><label>
      <cfselect name="AccessType" id="AccessType" width="200"  >
      <option value="Warehouse">Warehouse</option>
      <option value="Customer Care">Customer Care</option>
      <option value="Both">Both</option>
      </cfselect>
    </label></td>
  </tr>
  <tr>
    <td height="76">Enter a <strong>&quot;remider phrase&quot;</strong> to remind you of your password if it has been forgetten.</td>
    <td><label>
      <cfinput type="text" name="reminder" id="reminder">
    </label></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><cfinput type="submit" name="Button" value="Submit" id="Button">
    <cfinput type="hidden" name="hiddenField" value="employee"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><cfset message='#URL.state#'><cfoutput>#variables.message#</cfoutput>&nbsp;</td>
  </tr>
</table> 
</cfform>
</body>
</html>
