<cfquery name="getID" datasource="discountsoccer">
select UserID
from customerInfo
where eMailAddress = '#url.eMailAddress#'
</cfquery>

<cffile action="delete" file="tempFiles\tempFile#getID.userID#.cfm">
<script type="text/javascript">
window.close();
</script>