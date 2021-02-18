<cfparam name="url.index" default="0" type="numeric">
<cfparam name="variables.msg" default="" type="string">

<cfset migiCart = session.cart.getCart()>
<cfset a=false>
<cfset length=#arraylen(migiCart)#>

<cfset UniqueIdentifier = CreateUUID()>

<cfscript>
descr = "";
quantity = "";
</cfscript>

<script type="text/javascript">
		<!--
		<cfoutput>
			var #ToScript(variables.UniqueIdentifier,"UniqueIdentifier")#
		</cfoutput>	
		var url="http://www.discountsoccersupply.com/ConfirmationPage.cfm?UI="+UniqueIdentifier;
		
		function E()
		{		
		setTimeout("window.close()",4000);
		}
		
		function RefreshCart(){
		window.close();
		window.open('http://www.discountsoccersupply.com/cart.cfm','_blank','resizeable=yes, scrollbars=yes, toolbar=no, menubar=no, width=932 ,height=300, top=150');
		}

		function MM_preloadImages() { //v3.0
  			var d=document; 
			if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    		var i,j=d.MM_p.length,a=MM_preloadImages.arguments; 
			for(i=0; i<a.length; i++);
    		if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
		}

		function MM_findObj(n, d) { //v4.01
  			var p,i,x;  if(!d) d=document; 
			if((p=n.indexOf("?"))>0&&parent.frames.length) {
    		d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  			if(!(x=d[n])&&d.all) x=d.all[n]; 
			for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  			for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  			if(!x && d.getElementById) x=d.getElementById(n); 
			return x;
		}

		function MM_nbGroup(event, grpName) { //v6.0
  			var i,img,nbArr,args=MM_nbGroup.arguments;
  			if (event == "init" && args.length > 2) {
    		if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      		img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      		if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      		nbArr[nbArr.length] = img;
      		for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
       		if (!img.MM_up) img.MM_up = img.src;
        	img.src = img.MM_dn = args[i+1];
        	nbArr[nbArr.length] = img;
    	}}
  		} else if (event == "over") {
    		document.MM_nbOver = nbArr = new Array();
    		for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      		if (!img.MM_up) img.MM_up = img.src;
      		img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])? args[i+1] : img.MM_up);
      		nbArr[nbArr.length] = img;
    	}
  		} else if (event == "out" ) {
    		for (i=0; i < document.MM_nbOver.length; i++) {
      		img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  		} else if (event == "down") {
    		nbArr = document[grpName];
    		if (nbArr)
      		for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    		document[grpName] = nbArr = new Array();
    		for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      		if (!img.MM_up) img.MM_up = img.src;
      		img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
      		nbArr[nbArr.length] = img;
  		} }
		}
		//-->
	</script>
    
<cfif isdefined("url.action")>
    <cfif url.action is "checkout">
		<cfif ArrayLen(migiCart) gt 0>
			<script type="text/javascript"> 
				E();
			</script>
        <cfelse>
      		<cfset msg = "The cart is empty please purchase merchendise!">
        </cfif>
    </cfif>
	
	<cfif url.action is "update">
    	<cfset length = arraylen(migiCart)>            
            <cfloop from="1" to="#variables.length#" index="counter">
            <cfset quantity = structFind(form,"quantity#variables.counter#")>                  
            	<cfinvoke component="ShoppingCart" method="Update">
        			<cfinvokeargument name="id" value="#variables.counter#">
                <cfinvokeargument name="quantity" value="#variables.quantity#">
        	</cfinvoke>
    	</cfloop>
	</cfif>
    
    <cfif url.action is "ClearCart">
         <cfset session.cart.ClearCart()>
         <cflocation url="Cart.cfm">
	</cfif>
    
    <cfif url.action is "RemoveItem">
		<cfset session.cart.removeItem(url.position)>
        <cflocation url="Cart.cfm">
    </cfif>
</cfif>

	<cfset subtotal=0>
        <cfloop from="1" to="#variables.length#" index="counter">
		<cfset subtotal= #variables.subtotal# + (#migiCart[counter].price# * #migiCart[counter].quantity#)>
		</cfloop>
	<cfset Tax = .0825 * #variables.subtotal#>
	<cfset Total = #variables.tax# + #variables.subtotal#>
 	 

<html>
	<head>
		<link href="UniversalFormatter.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
	<style type="text/css">
<!--
.style2 {font-size: 14px}
.style3 {font-size: 12px}
-->
    </style>
	
    	<title>Shopping Cart</title> 
		
</head>

<body onLoad="MM_preloadImages('images/cdwn.jpg','images/cover.jpg','images/ButtonBank/theRemoveButton_OVER.gif')" bgcolor="004400">

<table width="518" cellspacing="0" cellpadding="0" border=0>
	<tr>
		<td width="439" height="315">	
			<cfform name="form" action="Cart.cfm?action=update" method="post">
			<table width="888" class="ArialStoreWhite" cellpadding="0" cellspacing="0" border="0" >
			  <cfoutput>
			    <tr>
			      <td height="28">&nbsp;<table width="888" class="ArialStoreWhite" cellpadding="0" cellspacing="0" border="0" >
                      <tr>
                        <th height="20" colspan="7" align="left" bgcolor="##FFFFFF" class="ArialStore"> &nbsp; <span class="style2"> Shopping Cart #variables.msg#</span> </th>
                      </tr>
                      <tr>
                        <th colspan="7" align="left">&nbsp;</th>
                      </tr>
                      <tr>
                        <th width="104" align="center"><span class="style2">Part Number</span></th>
                        <th width="104" align="center"><span class="style2"> Name</span></th>
                        <th width="225" align="center"><span class="style2">Description</span></th>
                        <th width="104" align="center"><span class="style2">Price</span></th>
                        <th width="104" align="center"><span class="style2">U/M</span></th>
                        <th colspan="2" align="center"><span class="style2">Quantity</span></th>
                      </tr>
                      <cfset index = 0 >
                      <cfloop from="1" to="#arraylen(migiCart)#" index="counter">
                        <cfset index = index+1>
                        <cfset descr = removechars(#migiCart[counter].ItemName.getDesc()#,25,3000)>
                        <tr>
                          <td align="center"><span class="style3">#migiCart[counter].ItemName.getItemNumber()#</span></td>
                          <td align="center">#migiCart[counter].ItemName.getItemName()#</td>
                          <td align="center">#variables.descr#</td>
                          <td align="center">#dollarformat(migiCart[counter].ItemName.getPrice())#</td>
                          <td align="center">#migiCart[counter].ItemName.getSizeSML()#</td>
                          <td colspan="2" align="center"><cfinput type="text" name="Quantity#variables.index#" value="#migiCart[counter].quantity#" size="3" 
            range="0,300">
                            &nbsp; <a href="Cart.cfm?action=removeItem&position=#counter#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('EraseItem','','images/ButtonBank/theRemoveButton_OVER.gif',1)"><img src="images/ButtonBank/theRemoveButton_OUT.gif" name="EraseItem" width="20" height="21" border="0"></a> </td>
                        </tr>
                      </cfloop>
                      <tr height="20">
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
                        <td width="179" align="right"><cfinput name="refresh" type="button" value="Refresh Cart" onClick="RefreshCart();"></td>
                        <td width="68" align="right">&nbsp;</td>
                      </tr>
                      <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td align="right"><cfinput name="submit" type="submit" value="Update Cart "></td>
                        <td align="right">&nbsp;</td>
                      </tr>
                      <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td colspan="2" align="right">&nbsp;</td>
                      </tr>
                      <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td align="right"></td>
                        <td align="right">Sub-Total: &nbsp;</td>
                        <td align="right">#dollarformat(variables.subtotal)#</td>
                        <td align="right">&nbsp;</td>
                      </tr>
                      <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td align="right"></td>
                        <td align="right">Tax: &nbsp;</td>
                        <td align="right">#dollarformat(variables.tax)#</td>
                        <td align="right">&nbsp;</td>
                      </tr>
                      <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td align="right"></td>
                        <td align="right">&nbsp;</td>
                        <td align="right">&nbsp;</td>
                        <td align="right">&nbsp;</td>
                      </tr>
                      <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td align="right">&nbsp;</td>
                        <td align="right"><strong>Total:</strong> &nbsp;</td>
                        <td align="right">#dollarformat(variables.total)#</td>
                        <td align="right">&nbsp;</td>
                      </tr>
                      <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td colspan="2" align="right">&nbsp;</td>
                      </tr>
                      <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><cfinput type="hidden" name="UI"  value="#variables.UniqueIdentifier#"></td>
                        <td>&nbsp;</td>
                        <td align="right"><cfinput name="MakePurchase" type="button" value="Make Purchase" onClick="window.open('http://www.discountsoccersupply.com/cart.cfm?action=checkout','_self','resizeable=yes, scrollbars=yes, toolbar=no, menubar=no, 		width=932 ,height=235, top=150');window.open('http://www.discountsoccersupply.com/EnterYourMailingAddress.cfm?action=init','window20','resizeable=yes,scrollbars=yes,toolbar=no, menubar=no,width=932,height=725,');"></td>
                        <td align="right">&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="28">&nbsp; &nbsp;
                            </td>
                        <td height="28" colspan="6" valign="middle">&nbsp; &nbsp; Once you begin the checkout process you <strong>will not</strong> be able 
                          to go back! Please Click &quot;Make Purchase&quot; only after 
                          your <br>
                          &nbsp; &nbsp; shopping has been completed!</td>
                      </tr>
                  </table></td>
		        </tr>
              </cfoutput>
            </table>
			</cfform></td>
  </tr>
  <tr>
  <td></td>
  </tr>
</table>
</body>
</html>

