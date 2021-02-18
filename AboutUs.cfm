<!-- This Code is Copywritten (c) 2009 All Rights Reserved to 'Out Of Site Software'  --> 

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

<cfinvoke component="customercarecomponent" method="aboutus" returnvariable="aboutusret" />

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<meta http-equiv="Window-target" content="fiduciary">
				<title>About DiscountSoccerSupply.com</title>
					<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
						<script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>
							<script type="text/javascript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  				window.open(theURL,winName,features);
				}
			
			//function MM_findObj(n, d) { //v4.01
  				//var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    			//d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  				//if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  				//for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  				//if(!x && d.getElementById) x=d.getElementById(n); return x;
				//}
			
			function MM_preloadImages() { //v3.0
  				var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
   				var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    			if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
				}
//-->
</script>

<!-- Here a link is made to the Cascading Style Sheets effectivly importing the font styles used on the page. -->
	<link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" />
		<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">

<!-- Here are some style which have been left on the page -->
<style type="text/css">
<!--
		
			.style4 {color: #333333}
.style5 {
	font-size: 36px;
	color: #333333;
	font-family: "Times New Roman", Times, serif;
	font-weight: bold;
}
.style6 {
	font-size: 18px
}
-->
</style>

</head>

<body onLoad="MM_preloadImages('images/ButtonBank/Purchase_BTN_OVER.jpg','images/ButtonBank/Home_OVER.jpg')" leftmargin="14" rightmargin="0" topmargin="0">

<table height="922" width="1338" border="0" cellpadding="0" cellspacing="0">
<tr valign="top">
	  <td height="19" align="left" valign="top" bgcolor="00FF00">&nbsp;</td>
	  <td height="19" align="left" valign="top" bgcolor="00FF00">&nbsp;</td>
	  <td height="19" align="right" valign="top" bgcolor="00FF00">&nbsp;</td>
  </tr>
	<tr valign="top">
    	<td height="140" valign="top" align="left"><br><img src="Images/soccerlogo.jpg" alt="Logo" width="211" height="141"></td>
    			<td height="140" valign="top" align="left" width="907" background="images/Area Fill/TopBarFill.jpg"><img src="Images/DiscountSoccerSupplyLogo.jpg" alt="Splash" width="850" height="186"></td>
    			<td height="140" width="220" align="right" valign="top">
					<cfif not structKeyExists(COOKIE, "FullName")>
				</cfif></td>
    			</tr>
    
    			<tr valign="top" height="1" width="850">
    				<td height="0" background="images/ButtonBank/ButtonBarFiller.jpg">                		</td>
							<td height="0" background="images/ButtonBank/ButtonBarFiller.jpg" align="center"><img onClick="window.open('homepage.cfm','_self')" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/HomeButton.jpg" alt="Home Button" width="105" height="44"><img onClick="window.open('Store.cfm','_self')" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/WarehouseButton.jpg" alt="Warehouse Button" width="162" height="44"><img onClick="window.open('News.cfm','_self')" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/NewsButton.jpg" alt="News Button" width="96" height="44"><img onClick="window.open('AboutUs.cfm','_self')" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/AboutUs.jpg" alt="About Us Button" width="148" height="44"><img onClick="window.open('ContactUs.cfm','_self')" onMouseOver="style.cursor='hand'"  src="Images/ButtonBank/ContactUs.jpg" alt="Contact Us Button" width="166" height="44"></td>
							<td height="1" width="220" valign="top" align="left">            					</td>
									</tr>
  
	<tr valign="top">
    	<td width="211" height="611" valign="top" bgcolor="FFFFFF" class="ArialStoreWhite">      		</td>
				<td width="907" align="left" valign="top" bgcolor="FFFFFF" class="ArialStoreWhite style5">
				  <p>About Us				</p>
				  <p class="style6">&nbsp; &nbsp; We are on a mission to bring you discount soccer supply. We know that you love to get a deal and we are set on bringing soccer deals to you via DiscountSoccerSupply.com . We are searching the globe and keeping our overhead low just for you, you family members and you soccer teams. Whether your coaching youth soccer or going semi-pro this is you one stop shop for soccer stuff. Check out the &quot;More&quot; section for cones and other practice supplies. The &quot;Goals&quot; section also includes nets, stakes and velcro ties and everything else is totally easy. Be sure to check out out team section where we offer team uniforms and practice supplies all in one easy to purchase package. We are happy to have you on our site and hope that you willsend in suggestions or comments which you may have from the ContactUs page. Again thankyou and enjoy your shopping experience.</p>
				<td align="left" bgcolor="FFFFFF" valign="top"></td>
  							</tr>
                            
  	<tr>
    	<td colspan="3" height="42" align="center" valign="middle" bgcolor="00FF00">
        	<span class="ArialStoreWhite style4"> &nbsp; Home |   Store  |  &nbsp;Invoicing  &nbsp;|  Bulk Orders |  &nbsp;Terms and Conditions  &nbsp;|
        			&nbsp;Contact Us</span> <span class="style5 style4"></td>
							</tr>
								</table>
</body>