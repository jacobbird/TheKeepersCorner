<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Are You Sure You Want To Delete This Item?</title>
<cfparam default="" name="url.action" type="string">
<cfparam default="" name="url.orderNumber" type="string">
<cfparam default="" name="form.orderNumber" type="string">
<cfoutput>

<cfswitch expression="#url.action#">
	<cfcase value="erase">

		<cfquery name="erase" datasource="discountsoccer">
			delete from itemssc
			where itemnumber='#url.itemnumber#'
		</cfquery>

		<script type="text/javascript">
			window.close();
		</script>

	</cfcase>
</cfswitch>

</cfoutput>
<script type="text/javascript">
function CloseWindow(){
window.close();
}
</script>
<style type="text/css">
<!--
.style1 {
	font-size: x-large;
	font-weight: bold;
	color: #330066;
}
.style2 {color: #333366}
-->
</style>
</head>

<body leftmargin="0" topmargin="0">
<table width="377" border="1" cellspacing="0" cellpadding="0">
 <cfoutput>
  <tr>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
  </tr>
  <tr>
    <td width="17" bgcolor="FF9933">&nbsp;</td>
    <td width="19" bgcolor="FF9933">&nbsp;</td>
    <td width="288" bgcolor="FF9933">&nbsp;</td>
    <td width="22" bgcolor="FF9933">&nbsp;</td>
    <td width="19" bgcolor="FF9933">&nbsp;</td>
  </tr>
  <tr>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933"><p class="style1">Do you want to <u>perminently erase</u> this item from the records?</p>
    <p class="style2">#url.orderNumber#</p></td>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
  </tr>
  <tr>
    <td height="26" bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
    <td align="right" height="25" bgcolor="FF9933"><cfform name="form1" action="http://www.discountsoccersupply.com/AreYouSureYouWantToDeleteThisItemTwo.cfm?action=erase&ItemNumber=#url.ItemNumber#"><cfinput type="hidden" name="OrderNubmer" value="#url.OrderNumber#"><cfinput type="button" name="No I am Not Sure." value="No I am Not Sure." onClick="CloseWindow();"><cfinput type="Submit" name="Yes I am Sure." value="Yes I am Sure."></cfform></td>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
  </tr>
  <tr>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
    <td bgcolor="FF9933">&nbsp;</td>
  </tr>
 </cfoutput>
</table>
</body>
</html>
