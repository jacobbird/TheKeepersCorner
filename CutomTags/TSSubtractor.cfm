<!--Written by Clean, Simple, and Smart Design dba "Out of Site Development" this code is freeware available as open source! Coded on Jan-08-2009 5:54pm-->

<!-- This is intended for use with ColdFusion 8 programming it is a "custom tag" the returns a date n number of days prior to the current date. The attributes are "DaystoSubtract" and "ReturnVariable"  and the output is formatted in timestamp format so that is is easily used with other time stampes. The maximum number of days to subtract is 1000 but can be adjusted in cfparam taglocated on line 8... -->

<!--errorcatching code-->

<cftry>
<cfparam name="attributes.DaystoSubtract" default="" type="numeric" max="1000" >
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

<cfif not attributes.DaystoSubtract eq 0>
<cfset TodaysDate = now()>
<cfset TodaysTime = left(right(now(),10),8)>
<cfset TodaysDay = NumberFormat(left(right(now(),13),2),99)>
<cfif TodaysDay lte 9>
<cfset TodaysDay = NumberFormat(left(right(now(),13),2),09)>
</cfif>
<cfset TodaysMonth = NumberFormat(left(right(now(),16),2),99)>
<cfif TodaysMonth lte 9>
<cfset TodaysMonth = NumberFormat(left(right(now(),16),2),09)>
</cfif>
<cfset TodaysYear = NumberFormat(left(right(now(),21),4),9999)>
<cfset StartDay = TodaysDay - #attributes.DaystoSubtract#>
<cfset StartMonth = TodaysMonth>
<cfset StartTime = TodaysTime>
<cfset StartYear = TodaysYear>

<cfif TodaysMonth eq 01>
<cfset NumberofDaysinthemonth = 31>
<cfelseif TodaysMonth eq 02>
<cfset NumberofDaysinthemonth = 28>
<cfelseif TodaysMonth eq 03>
<cfset NumberofDaysinthemonth = 31>
<cfelseif TodaysMonth eq 04>
<cfset NumberofDaysinthemonth = 30>
<cfelseif TodaysMonth eq 05>
<cfset NumberofDaysinthemonth = 31>
<cfelseif TodaysMonth eq 06>
<cfset NumberofDaysinthemonth = 30>
<cfelseif TodaysMonth eq 07>
<cfset NumberofDaysinthemonth = 31>
<cfelseif TodaysMonth eq 08>
<cfset NumberofDaysinthemonth = 31>
<cfelseif TodaysMonth eq 09>
<cfset NumberofDaysinthemonth = 30>
<cfelseif TodaysMonth eq 10>
<cfset NumberofDaysinthemonth = 31>
<cfelseif TodaysMonth eq 11>
<cfset NumberofDaysinthemonth = 30>
<cfelseif TodaysMonth eq 12>
<cfset NumberofDaysinthemonth = 31>
<cfelse>
<cfthrow message = "An unexpected error has occuerd please contact you site administrator: DateFinder ERROR 001 'Not a Valid Month'">
</cfif>

<cfif StartDay lt 10>
<cfset StartDayString = ToString(StartDay)>
<cfset StartDayExtendedString = "0"&"#variables.StartDayString#">
<cfelseif StartDay gte 10>
<cfset StartDayString = ToString(StartDay)>
<cfset StartDayExtendedString = "#variables.StartDayString#">
</cfif>

<cfif StartMonth lt 10>
<cfset StartMonthString = ToString(StartMonth)>
<cfset StartMonthExtendedString = "0"&"#variables.StartMonthString#">
<cfelse>
<cfset StartMonthString = ToString(StartMonth)>
<cfset StartMonthExtendedString = "#variables.StartMonthString#">
</cfif>


<cfif StartDay lte 0>

<cfset StartMonth = StartMonth - 1>

<cfif StartMonth lt 10>
<cfset StartMonthString = ToString(StartMonth)>
<cfset StartMonthExtendedString = "0"&"#variables.StartMonthString#">
<cfelse>
<cfset StartMonthString = ToString(StartMonth)>
<cfset StartMonthExtendedString = "#variables.StartMonthString#">
</cfif>

<cfset StartDay = StartDay + NumberofDaysinthemonth>

<cfif StartDay lt 10>
<cfset StartDayString = ToString(StartDay)>
<cfset StartDayExtendedString = "0"&"#variables.StartDayString#">
<cfelse>
<cfset StartDayString = ToString(StartDay)>
<cfset StartDayExtendedString = "#variables.StartDayString#">
</cfif>

<cfif StartMonth eq 0>

<cfset StartMonth = 12>

<cfset StartYear = StartYear -1>

</cfif>

</cfif>

<cfset tsnewdate = CreateODBCDateTime("#variables.StartYear#-#variables.StartMonthExtendedString#-#variables.StartDayExtendedString# #variables.TodaysTime#")>
<cfset "CALLER.#attributes.returnVariable#" = variables.tsnewDate>
<cfelse>
<cfthrow  message="An unexpected error has occuerd please contact you site administrator: DateFinder ERROR 002 'Attribute DaystoSubtract is required'">
</cfif>

<!--The End-->