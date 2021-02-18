<!--Written by Clean, Simple, and Smart Design dba "Out of Site Development" this code is freeware available as open source! Coded on Jan-08-2009 5:54pm-->

<!-- This is intended for use with ColdFusion 8 programming it is a "custom tag" the returns a date n number of days prior to the current date. The attributes are "DaystoSubtract" and "ReturnVariable"  and the output is formatted in timestamp format so that is is easily used with other time stampes. The maximum number of days to subtract is 1000 but can be adjusted in cfparam taglocated on line 8... -->

<!--errorcatching code-->

<cftry>
<cfparam name="attributes.ReturnVariable" default="" type="string">
<cfcatch type="missinginclude">
<h3> Attributes DaystoSubtract and ReturnVariable are Required <b>Error</b></h3>\
<cfoutput>
<p>#cfcatch.Message#</p>
<p>Caught and exception, type = #cfcatch.Type#</p>
<cfdump var="#cfcatch.tagcontext#">
</cfoutput>
</cfcatch>
</cftry>

<!-- The following code calculates the new date from the old one and output a returnvariable to the calling application...-->

<cfset TodaysDate = now()>
<cfset TodaysTime = left(right(now(),10),8)>
<cfset TodaysDay = left(right(now(),13),2)>
<cfif  TodaysDay lte 9>
<cfset TodaysDay = numberformat(left(right(now(),13),2))>
</cfif>
<cfset TodaysMonth = left(right(now(),16),2)>
<cfif  TodaysMonth lte 9>
<cfset TodaysMonth = numberformat(left(right(now(),16),2))>
</cfif>
<cfset TodaysYear = left(right(now(),21),4)>
<cfset TodaysHours = left(right(#variables.TodaysTime#,2),2)>
<cfset TodaysMinutes = left(right(#variables.TodaysTime#,5),2)>
<cfset TodaysSeconds = left(right(#variables.TodaysTime#,8),2)>

<cfif TodaysDay lt 10>
<cfset TodaysDayString = ToString(TodaysDay)>
<cfset TodaysDayExtendedString = "0"&"#variables.TodaysDayString#">
<cfelseif TodaysDay gte 10>
<cfset TodaysDayString = ToString(TodaysDay)>
<cfset TodaysDayExtendedString = "#variables.TodaysDayString#">
</cfif>

<cfif TodaysMonth lt 10>
<cfset TodaysMonthString = ToString(TodaysMonth)>
<cfset TodaysMonthExtendedString = "0"&"#variables.TodaysMonthString#">
<cfelse>
<cfset TodaysMonthString = ToString(TodaysMonth)>
<cfset TodaysMonthExtendedString = "#variables.TodaysMonthString#">
</cfif>

<cfset TodaysValue="#variables.TodaysYear##variables.TodaysMonthExtendedString##variables.TodaysDayExtendedString#">

<cfset "CALLER.#attributes.returnVariable#" = NumberFormat(variables.TodaysValue)>


<!--The End-->