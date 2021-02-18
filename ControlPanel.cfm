<!-- This Code is Copywritten (c) 2009 All Rights Reserved to Clean, Simple, and Smart dba "Out of Site Development" --> 
<cfset migiCart=session.cart.getCart()>

<cfparam name="Cookie.AccessType"  	type="string"   default=""		>
<cfparam name="Cookie.UserID"      	type="string"   default=""		>
<cfparam name="url.action"         	type="string"   default="none"	>
<cfparam name="url.category"       	type="string"   default=""		>
<cfparam name="url.key" 			type="string" 	default=""		>
<cfparam name="url.s" 				type="string" 	default="none"	>
<cfparam name="Form.Search"        	type="string"   default="none"	>
<cfparam name="Variables.UserName"  type="string"  	default=""		>
<cfparam name="variables.vanquish" 	type="string" 	default="0"		><!--xxxxx-->

<!--<cfinclude template="ShoppingCartComparator.cfm"> <!--Make into one include-->
<cfinclude template="StorePagesActionsList.cfm">	  <!--Make into one include-->	
<cfinclude template="SetThreeXNextN.cfm">			  <!--Make into one include-->

<cfscript>
startrowItems 	= 	round(rand() * getAllAsQuery.RecordCount) + 1; 
endrowItems 	= 	startrowItems + 3;
</cfscript>

<cfif structKeyExists(COOKIE, "FullName")>
	<cfset UserName = "Welcome: You are currently Logged In as #Cookie.UserID#! ">
</cfif>

<cfif structKeyExists(COOKIE, "FullName")>

<cfinvoke 
 component="CustomerCareComponent"
 method="populateFields"
 returnvariable="populateFieldsRet">
 <cfinvokeargument name="UserID" value="#Cookie.UserID#" />
</cfinvoke>

<cfelse>

<cfinvoke 
 component="CustomerCareComponent"
 method="populateFields"
 returnvariable="populateFieldsRet">
 <cfinvokeargument name="UserID" value="NoID" />
</cfinvoke>

</cfif>

<cfquery name="getKeywords" datasource="discountsoccer">
Select keyword
from keywords
where keywordname='keywords'
</cfquery>

<html> 
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Window-target" content="fiduciary">
        <cfoutput query="getKeywords">
        <meta http-equiv="keywords" content="#keyword#">
		</cfoutput>
		<title>The Warehouse</title>
		<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
		<script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>
		<script src="SpryAssets/SpryEffects.js" type="text/javascript"></script>
		<script type="text/javascript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  				window.open(theURL,winName,features);
			}
			function MM_findObj(n, d) { //v4.01
  				var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    			d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  				if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  				for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  				if(!x && d.getElementById) x=d.getElementById(n); return x;
			}
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
function MM_effectShake(targetElement)
{
	Spry.Effect.DoShake(targetElement);
}

function MM_timelinePlay(tmLnName, myID) { //v1.2
  //Copyright 1998, 1999, 2000, 2001, 2002, 2003, 2004 Macromedia, Inc. All rights reserved.
  var i,j,tmLn,props,keyFrm,sprite,numKeyFr,firstKeyFr,propNum,theObj,firstTime=false;
  if (document.MM_Time == null) MM_initTimelines(); //if *very* 1st time
  tmLn = document.MM_Time[tmLnName];
  if (myID == null) { myID = ++tmLn.ID; firstTime=true;}//if new call, incr ID
  if (myID == tmLn.ID) { //if Im newest
    setTimeout('MM_timelinePlay("'+tmLnName+'",'+myID+')',tmLn.delay);
    fNew = ++tmLn.curFrame;
    for (i=0; i<tmLn.length; i++) {
      sprite = tmLn[i];
      if (sprite.charAt(0) == 's') {
        if (sprite.obj) {
          numKeyFr = sprite.keyFrames.length; firstKeyFr = sprite.keyFrames[0];
          if (fNew >= firstKeyFr && fNew <= sprite.keyFrames[numKeyFr-1]) {//in range
            keyFrm=1;
            for (j=0; j<sprite.values.length; j++) {
              props = sprite.values[j]; 
              if (numKeyFr != props.length) {
                if (props.prop2 == null) sprite.obj[props.prop] = props[fNew-firstKeyFr];
                else        sprite.obj[props.prop2][props.prop] = props[fNew-firstKeyFr];
              } else {
                while (keyFrm<numKeyFr && fNew>=sprite.keyFrames[keyFrm]) keyFrm++;
                if (firstTime || fNew==sprite.keyFrames[keyFrm-1]) {
                  if (props.prop2 == null) sprite.obj[props.prop] = props[keyFrm-1];
                  else        sprite.obj[props.prop2][props.prop] = props[keyFrm-1];
        } } } } }
      } else if (sprite.charAt(0)=='b' && fNew == sprite.frame) eval(sprite.value);
      if (fNew > tmLn.lastFrame) tmLn.ID = 0;
  } }
}

function MM_timelineGoto(tmLnName, fNew, numGotos) { //v2.0
  //Copyright 1998, 1999, 2000, 2001, 2002, 2003, 2004 Macromedia, Inc. All rights reserved.
  var i,j,tmLn,props,keyFrm,sprite,numKeyFr,firstKeyFr,lastKeyFr,propNum,theObj;
  if (document.MM_Time == null) MM_initTimelines(); //if *very* 1st time
  tmLn = document.MM_Time[tmLnName];
  if (numGotos != null)
    if (tmLn.gotoCount == null) tmLn.gotoCount = 1;
    else if (tmLn.gotoCount++ >= numGotos) {tmLn.gotoCount=0; return}
  jmpFwd = (fNew > tmLn.curFrame);
  for (i = 0; i < tmLn.length; i++) {
    sprite = (jmpFwd)? tmLn[i] : tmLn[(tmLn.length-1)-i]; //count bkwds if jumping back
    if (sprite.charAt(0) == "s") {
      numKeyFr = sprite.keyFrames.length;
      firstKeyFr = sprite.keyFrames[0];
      lastKeyFr = sprite.keyFrames[numKeyFr - 1];
      if ((jmpFwd && fNew<firstKeyFr) || (!jmpFwd && lastKeyFr<fNew)) continue; //skip if untouchd
      for (keyFrm=1; keyFrm<numKeyFr && fNew>=sprite.keyFrames[keyFrm]; keyFrm++);
      for (j=0; j<sprite.values.length; j++) {
        props = sprite.values[j];
        if (numKeyFr == props.length) propNum = keyFrm-1 //keyframes only
        else propNum = Math.min(Math.max(0,fNew-firstKeyFr),props.length-1); //or keep in legal range
        if (sprite.obj != null) {
          if (props.prop2 == null) sprite.obj[props.prop] = props[propNum];
          else        sprite.obj[props.prop2][props.prop] = props[propNum];
      } }
    } else if (sprite.charAt(0)=='b' && fNew == sprite.frame) eval(sprite.value);
  }
  tmLn.curFrame = fNew;
  if (tmLn.ID == 0) eval('MM_timelinePlay(tmLnName)');
}

function MM_timelineStop(tmLnName) { //v1.2
  //Copyright 1998, 1999, 2000, 2001, 2002, 2003, 2004 Macromedia, Inc. All rights reserved.
  if (document.MM_Time == null) MM_initTimelines(); //if *very* 1st time
  if (tmLnName == null)  //stop all
    for (var i=0; i<document.MM_Time.length; i++) document.MM_Time[i].ID = null;
  else document.MM_Time[tmLnName].ID = null; //stop one
}

function MM_initTimelines() { //v4.0
    //MM_initTimelines() Copyright 1997 Macromedia, Inc. All rights reserved.
    var ns = navigator.appName == "Netscape";
    var ns4 = (ns && parseInt(navigator.appVersion) == 4);
    var ns5 = (ns && parseInt(navigator.appVersion) > 4);
    var macIE5 = (navigator.platform ? (navigator.platform == "MacPPC") : false) && (navigator.appName == "Microsoft Internet Explorer") && (parseInt(navigator.appVersion) >= 4);
    document.MM_Time = new Array(3);
    document.MM_Time[0] = new Array(0);
    document.MM_Time["Timeline1"] = document.MM_Time[0];
    document.MM_Time[0].MM_Name = "Timeline1";
    document.MM_Time[0].fps = 15;
    document.MM_Time[0].lastFrame = 0;
    document.MM_Time[1] = new Array(0);
    document.MM_Time["Timeline2"] = document.MM_Time[1];
    document.MM_Time[1].MM_Name = "Timeline2";
    document.MM_Time[1].fps = 15;
    document.MM_Time[1].lastFrame = 0;
    document.MM_Time[2] = new Array(0);
    document.MM_Time["Timeline3"] = document.MM_Time[2];
    document.MM_Time[2].MM_Name = "Timeline3";
    document.MM_Time[2].fps = 15;
    document.MM_Time[2].lastFrame = 0;
    for (i=0; i<document.MM_Time.length; i++) {
        document.MM_Time[i].ID = null;
        document.MM_Time[i].curFrame = 0;
        document.MM_Time[i].delay = 1000/document.MM_Time[i].fps;
    }
}
//-->
</script>
		<link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css" />
		<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
		<style type="text/css">
			<!--
			.style1 {color: #FFFFFF}
			-->
		</style>
        <style type="text/css">
<!--
#apDiv1 {
	position:absolute;
	left:1702px;
	top:211px;
	width:489px;
	height:352px;
	z-index:1;
}
#apDiv2 {
	position:absolute;
	left:257px;
	top:75px;
	width:460px;
	height:426px;
	z-index:80;
	visibility: visible;
	background-image: url(images/Fireworks/GreenFireworks.gif);
}
#apDiv3 {
	position:absolute;
	left:598px;
	top:-73px;
	width:302px;
	height:49px;
	z-index:1;
}
-->
        </style>
</head>


<cfoutput>
<body background="images/Area Fill/bIGbG.jpg" onLoad="MM_timelinePlay('Timeline1');MM_preloadImages('images/ButtonBank/SignIn_OVER.gif','images/ButtonBank/NewMember_OVER.gif','images/ButtonBank/Purchase_BTN_OVER.jpg','images/ButtonBank/Chemicals_OVER.jpg','images/ButtonBank/Documents_OVER.gif','images/ButtonBank/Filtration_Over.gif','images/ButtonBank/Gloves_Over.gif', 'images/ButtonBank/Janitorial_OVER.gif','images/ButtonBank/Laboratory_OVER.jpg' ,'images/ButtonBank/Mats_OVER.gif', 'images/ButtonBank/Swabs_OVER.gif' ,'images/ButtonBank/Tape_OVER.gif', 'images/ButtonBank/Wipers_OVER.gif','images/ButtonBank/Misc_OVER.gif','images/ButtonBank/Vacuums_OVER.gif', 'images/ButtonBank/SignOut_OVER.gif','images/ButtonBank/Store_OVER.jpg', .jpg','images/ButtonBank/ESD_OVER.gif','images/ButtonBank/Bags_OVER.jpg','images/ButtonBank/Apparel_OVER.jpg');scrollTo(#variables.x#,#variables.y#);MM_timelineStop('Timeline1');MM_preloadImages('images/ButtonBank/controlpanel.jpg');MM_preloadImages('images/ButtonBank/controlpanel.gif');MM_preloadImages('images/ButtonBank/ControlPanel_OVER.gif');MM_preloadImages('images/ButtonBank/AccountandBilling_OVER.jpg');MM_preloadImages('images/ButtonBank/BillingInforrmation_OVER.jpg');MM_preloadImages('images/ButtonBank/CreditCardInformation_OVER.jpg');MM_preloadImages('images/ButtonBank/CurrentOrders_OVER.jpg');MM_preloadImages('images/ButtonBank/OrderHistory_OVER.jpg');MM_preloadImages('images/ButtonBank/CustomerInformation_OVER.jpg');MM_preloadImages('Images/ButtonBank/AccountInfoOver.jpg');MM_preloadImages('Images/ButtonBank/CustomerInfoOver.jpg');MM_preloadImages('Images/ButtonBank/CreditCardInfoOver.jpg');MM_preloadImages('Images/ButtonBank/NewOrdersOver.jpg');MM_preloadImages('Images/ButtonBank/OldOrdersOver.jpg')" leftmargin="0" rightmargin="0" topmargin="0">
<table height="1801" border="0" cellpadding="0" cellspacing="0">


<tr valign="top" >
  <td height="29" align="left" valign="top" bgcolor="FF9933">&nbsp;</td>
  <td height="29" align="left" valign="top" bgcolor="FF9933">&nbsp;</td>
  <td width="314" height="29" align="left" valign="top" bgcolor="FF9933">&nbsp;</td>
</tr>
<tr valign="top" >
	  <td height="140" valign="top" align="left" background="images/Area Fill/TopBarFill.jpg"><br><img src="Images/soccerlogo.jpg" width="210"></td>
      <td height="140" valign="top" align="left" background="images/Area Fill/TopBarFill.jpg"><img src="Images/DiscountSoccerSupplyLogoTwo.jpg" width="850" height="186"></td>
<td height="140" align="right" valign="top" background="images/Area Fill/TopBarFill.jpg">
            
			<cfif not structKeyExists(COOKIE, "FullName")>
			  <a href="BuyersLoginPage.cfm" onMouseOut="MM_swapImgRestore()" 
                     onMouseOver="MM_swapImage('Image13','','images/ButtonBank/SignIn_OVER.gif',1)">
              Sign In</a>&nbsp;|&nbsp;<a 
                href="http://www.discountsoccersupply.com/NewBuyersPage.cfm" onMouseOut="MM_swapImgRestore()" 
                onMouseOver="MM_swapImage('Image14','','images/ButtonBank/NewMember_OVER.gif',1)">New Member</a><br>
			  <cfelse>
			  <a href="LogOut.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image37','','images/ButtonBank/SignOut_OVER.gif',1)">Sign Out</a>&nbsp;|&nbsp;<a href="##" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image38','','images/ButtonBank/ControlPanel_OVER.gif',1)">Control Panel</a>
            </cfif></td>
    </tr>
	  <tr valign="middle" height="1">
   		<td height="35" align="center"><cfloop from="1" index="counter" to="#arraylen(migiCart)#"><cfset vanquish = vanquish + #migiCart[counter].quantity#>
       	      </cfloop><cfform>&nbsp; Items: &nbsp;#vanquish#<cfinput type="button" name="View Shopping Cart"  value="Cart" onClick="window.open('cart.cfm','window1','resizeable=yes, scrollbars=yes, toolbar=no, menubar=no, width=932 ,height=300, top=150')">&nbsp;</cfform></td>
	    <td height="35" background="images/ButtonBank/ButtonBarFiller.jpg" align="center"><img onClick="window.open('index.html',_self)" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/HomeButton.jpg" alt="Home Button" width="105" height="44"><img onClick="window.open('Store.cfm',_self)" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/WarehouseButton.jpg" alt="Warehouse Button" width="162" height="44"><img onClick="window.open('News.cfm',_self)" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/NewsButton.jpg" alt="News Button" width="96" height="44"><img onClick="window.open('AboutUs.cfm',_self)" onMouseOver="style.cursor='hand'" src="Images/ButtonBank/AboutUs.jpg" alt="About Us Button" width="148" height="44"><img onClick="window.open('ContactUs.cfm',_self)" onMouseOver="style.cursor='hand'"  src="Images/ButtonBank/ContactUs.jpg" alt="Contact Us Button" width="166" height="44"></td>
	    <td height="35" valign="top" align="left" background="images/ButtonBank/ButtonBarFiller.jpg">
	    <cfform name="form" method="post" action="Store.cfm?action=search">
        <p style="font-size:26px">
        &nbsp;<cfinput type="text" name="Search" id="Search"><cfinput type="submit" value="Search" name="submit">
        </p></cfform></td>
	</tr>
	  <tr valign="top">
   		<td width="211" valign="top" bgcolor="00FF00"  
             class="ArialStoreWhite"><img src="Images/ControlPanelImage.jpg" width="211" height="189" border="0"><a href="AccountandBillingInformation.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('AccountAndBillingInfo','','Images/ButtonBank/AccountInfoOver.jpg',1)" target="iframe"><img src="Images/ButtonBank/AccountInfo.jpg" alt="Account and Billing" name="AccountAndBillingInfo" width="211" height="44" border="0"></a><br>
	      <a href="CustomersInformation.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('CustomerInformation','','Images/ButtonBank/CustomerInfoOver.jpg',1)" target="iframe"><img src="Images/ButtonBank/CustomerInfo.jpg" alt="Customer Information" name="CustomerInformation" width="211" height="44" border="0"></a><br>
	      <a href="CreditCardInformation.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Credit Card Information','','Images/ButtonBank/CreditCardInfoOver.jpg',1)" target="iframe"><img src="Images/ButtonBank/CreditCardInfo.jpg" alt="Credit Card Information" name="Credit Card Information" width="211" height="44" border="0"></a><br>
	      <a href="CurrentOrders.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('CurrentOrders','','Images/ButtonBank/NewOrdersOver.jpg',1)" target="iframe"><img src="Images/ButtonBank/NewOrders.jpg" alt="New Orders" name="CurrentOrders" width="211" height="44" border="0"></a><br>
        <a href="OrderHistory.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Old Orders','','Images/ButtonBank/OldOrdersOver.jpg',1)" target="iframe"><img src="Images/ButtonBank/OldOrders.jpg" alt="Old Orders" name="Old Orders" width="211" height="44" border="0"></a></td>
   		<td width="850" align="char" valign="top" height="100" bgcolor="##FFFFFF"><iframe height="1500" width="100%" name="iframe" src="AccountAndBillingInformation.cfm" scrolling="no" frameborder="0"></iframe></td>
		<td align="center" valign="top" class="ArialStoreWhite">
   		 <br>
   		  <p><span class="ArialStoreWhite"><strong>Items<br> 
		   you might be <br> 
	      interested in!</strong></span></p>
			 <span class="style5">
   		 	   <cfinclude template="FeaturedItemsForStore.cfm">
		  </span></td>
	</tr>
	  				       	
	 <tr>
   		<td colspan="3" height="42" bgcolor="FF9933" align="center" valign="bottom">
            <span class="ArialStoreWhite">
               <a href="HomePage.cfm">Home</a> 
            |  <a href="store.cfm">Store</a>  
            |  &nbsp;<a href="Invoicing.cfm">Invoicing</a>  &nbsp;|
               &nbsp;<a href="" onClick="window.open('TermsAndConditions.cfm','resizeable=false, 
                	scrollable=false, toolbar=false, width=550, height=475')">Terms and Conditions</a>
                      &nbsp;
            |  &nbsp;<a href="store.cfm">Contact Us</a></span> <span class="style5">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
   			   &nbsp;</span>        </td>
	</tr>
</table>
</body>
</cfoutput>
</html>