ods excel file="c:\temp\CMA9_BCA.xlsx" 
 /* will apply an appearance style */
 style=pearl
 options(
  /* for multiple procs/sheet */
  sheet_interval="none" 
  /* name the sheet tab */
  sheet_name="CARS summary"
 );
 
/* add some formatted text */
ods escapechar='~';
ods text="~S={font_size=14pt font_weight=bold}~Cars Summary and Histogram";
 
Proc Print Data=OBData.CMA9_BCA;
	Title1 "Open Banking - BCA";
	Title2 "BCA Comparison Report - %Sysfunc(UPCASE(Today()))";
Run;
 
ods excel close;
