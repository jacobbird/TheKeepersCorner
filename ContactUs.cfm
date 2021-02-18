<!-- This Code is Copywritten (c) 2009 All Rights Reserved to Clean, Simple, and Smart dba "Out of Site Development" --> 

<cfparam default="" name="Cookie.UserID"  type="string">
<cfset UserName = "">
<cfif structKeyExists(COOKIE, "FullName")>
<cfset UserName = "Welcome: You are currently Logged In as #Cookie.UserID#! ">
</cfif>

<cfparam name="url.action" type="string" default="none">
<cfparam name="Form.Search" type="string" default="none">
<cfparam name="Cookie.AccessType" type="string" default="">
<cfparam name="url.category" type="string" default="">
<cfparam name="url.key" type="string" default="">
<cfparam name="variables.vanquish" type="string" default=0>

<cfif url.action eq "sendEmail">
<cfmail from="#form.mailFrom#" to="jacob_bird@hotmail.com" subject="#form.subject#" server="76.12.83
231" port="25">
#form.body#
</cfmail>
 
</cfif>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Window-target" content="fiduciary">
		<title>Contact Us</title>
		<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
		<script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>
		<script type="text/javascript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  				window.open(theURL,winName,features);
			}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
//-->
</script>

<link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" />
<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
<link href="UniversalFormatterTwo.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style4 {color: #333333}
-->
</style>
</head>

<body background="images/Area Fill/bIGbG.jpg" onLoad="MM_preloadImages('images/ButtonBank/Purchase_BTN_OVER.jpg')" leftmargin="14" rightmargin="0" topmargin="0">
<table width="1338" height="1000" border="0" cellpadding="0" cellspacing="0">
  
  <tr valign="top" >
    <td height="19" align="left" valign="top" bgcolor="#00FF00">&nbsp;</td>
    <td height="19" align="left" valign="top" bgcolor="#00FF00">&nbsp;</td>
    <td height="19" align="right" valign="top" bgcolor="#00FF00">&nbsp;</td>
  </tr>
  <tr valign="top" >
    <td height="140" valign="top" align="left" background="images/Area Fill/TopBarFill.jpg"><br>
    <img src="Images/soccerlogo.jpg" width="211" ></td>
    <td height="140" valign="top" align="left" background="images/Area Fill/TopBarFill.jpg"><img src="Images/DiscountSoccerSupplyLogo.jpg" width="850" height="186"></td>
    <td width="280" height="140" align="right" valign="top"> <cfif not structKeyExists(COOKIE, "FullName")>
		      <a href="BuyersLoginPage.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','images/ButtonBank/SignIn_OVER.gif',1)">
		        <font color="#000000" style="font-style:normal">Sign In</font></a> |
		      <a href="http://www.discountsoccersupply.com/NewBuyersPage.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','images/ButtonBank/NewMember_OVER.gif',1)">
		        <font color="#000000" style="font-style:normal">New Member?</font></a><br>
		          <cfelse>
		      <a href="LogOut.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image37','','images/ButtonBank/SignOut_OVER.gif',1)">
		        <font color="#000000" style="font-style:normal">Sign Out</font></a> | 
		      <a href="ControlPanel.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image38','','images/ButtonBank/ControlPanel_OVER.gif',1)">
		        <font color="#000000" style="font-style:normal">Control Panel</font></a>
		      </cfif></td>
  </tr>
  <tr valign="top" height="1">
    <td height="0"></td>
    <td height="0" align="center"><img onClick="window.open('homepage.cfm','_self')" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/HomeButton.jpg" alt="Home Button" width="105" height="44"><img onClick="window.open('Store.cfm','_self')" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/WarehouseButton.jpg" alt="Warehouse Button" width="162" height="44"><img onClick="window.open('News.cfm','_self')" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/NewsButton.jpg" alt="News Button" width="96" height="44"><img onClick="window.open('AboutUs.cfm','_self')" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/AboutUs.jpg" alt="About Us Button" width="148" height="44"><img onClick="window.open('ContactUs.cfm','_self')" onMouseOver="style.cursor='hand'"  src="Images/ButtonBank/ContactUs.jpg" alt="Contact Us Button" width="166" height="44"></td>
    <td height="1" valign="top" align="left">  </td>
</tr>
<cfform name="form" action="http://www.discountsoccersupply.com/ContactUs.cfm?action=sendEmail">
  <tr valign="top">
    <td width="208" valign="top" bgcolor="#FFFFFF" class="ArialStoreWhite">    </td>
	<td width="850" align="center" valign="top" bgcolor="#FFFFFF" class="ArialStoreWhite"><br><span class="style4">
	    <cfoutput></cfoutput></span><cfoutput>
	    <p align="justify" class="style4"><br><br><br>Your eMail Address:<br><br><cfinput type="text" name="mailTo">
        </p>
	    <p align="justify" class="style4">Topic:<br>
        <br><cfselect name="Subject"><option>Customer Support</option><option>Technical Support</option><option>General Questions</option>
        <option>Partnership Program</option><option>Account Requests</option>
        </cfselect></p>
        <p align="justify" class="style4">Message:<br>
          <br><cftextarea name="body" cols="72" rows="11" wrap="virtual"></cftextarea></p>
        <p align="justify">
          <span class="style4">
		<cfinput type="hidden" name="mailFrom" 
        value="mailerJan@ReliableCleanRoomProducts.com">
		<cfinput type="hidden" name="MailTo_required" value="You must enter a recipient">
        <cfinput type="hidden" name="MailFrom_required" value="You must enter a send">
        <cfinput type="hidden" name="Subject_required" value="You must enter a subject">
        <br>
        <cfinput type="submit" name="submit" value="Submit">
          </span><br><br><br><br><br>
        </p>
	  </cfoutput></td>
    <td align="left" bgcolor="#FFFFFF" valign="top"></td>
  </tr></cfform>
  <tr>
    <td colspan="3" height="42" bgcolor="00FF00" align="center" valign="bottom">
      <p><span class="ArialStoreWhite">&nbsp; <span class="style4">Home |   Store  |  &nbsp;Invoicing   |  &nbsp;Terms and Conditions  &nbsp;|
        &nbsp;Contact Us</span></span> <span class="style5">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
   	  &nbsp;    </span></p>    </td>
 </tr>
</table>
</body>