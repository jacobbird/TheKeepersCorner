<html>
<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
<head>
<title>List of Customers on File</title>
</head>

<body>

<cfinvoke component="CustomerCareComponent" method="getAddresses" returnvariable="getAddressesRet" />

<table width="905" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td colspan="5" align="left" style="font-size:24px; color:#333333; font-family: "Times New Roman", Times, serif;"><cfinclude template="HeaderAdminConfidential.html"></td>
  </tr>
<tr><img src="images/Area Fill/TopBarLeft.jpg" width="357" height="182" border="0">
  <td colspan="5" align="center"  class="PageHeaders"> Customer List For All WebSite Members:</td>
</tr>

<cfoutput>
<cfloop query="getAddressesRet" startrow="1" endrow="#getAddressesRet.recordcount#">
<tr >
  <th>&nbsp;</th>
  <th>&nbsp;</th>
  <th>&nbsp;</th>
  <th>&nbsp;</th>
  <th>&nbsp;</th>
</tr>
<tr bgcolor="000000" class="CustomerNumber">
  <th colspan="2" align="left">&nbsp; Customer Number: #key#</th>
  <th>&nbsp;</th>
  <th colspan="2" align="right"> CustomerID: #UserID# &nbsp; &nbsp;</th>
  </tr>
<tr>
  <th>&nbsp;</th>
  <th>&nbsp;</th>
  <th>&nbsp;</th>
  <th>&nbsp;</th>
  <th>&nbsp;</th>
</tr>
<tr bgcolor="999999"><th width="146">Company Name</th><th width="187">First Name</th><th width="206">Last Name</th><th width="186">Phone Number</th><th width="158">Last Web Transaction</th></tr>

<tr bgcolor="EEEEEE">
  <td align="center">#CompanyName#</td>
  <td align="center">#FirstName#</td>
  <td align="center">#LastName#</td>
  <td align="center">#PhoneNumber#</td>
  <td align="center">#TimeStamp#</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>

<tr bgcolor="999999">
  <th>Street</th>
  <th>Number</th>
  <th>City</th>
  <th>State</th>
  <th>Zip</th>
</tr>
<tr bgcolor="EEEEEE">
  <td align="center">#Street#</td>
  <td align="center">#Number#</td>
  <td align="center">#City#</td>
  <td align="center">#State#</td>
  <td align="center">#Zip#</td>
</tr>
<tr>
  <td height="21">&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr bgcolor="999999">
  <th height="21">Mail Street</th>
  <th>Mail Number</th>
  <th>Mail City</th>
  <th>Mail State</th>
  <th>Mail Zip</th>
</tr>
<tr bgcolor="EEEEEE">
  <td height="21" align="center">#MailStreet#</td>
  <td align="center">#MailNumber#</td>
  <td align="center">#MailCity#</td>
  <td align="center">#MailState#</td>
  <td align="center">#MailZip#</td>
</tr>
<tr>
  <td height="21">&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr bgcolor="999999">
  <th height="21">eMail Address</th>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr bgcolor="EEEEEE">
  <td height="21">#eMailAddress#</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr><td height="21">&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
</cfloop>
</cfoutput>
</table>
</body></html>

