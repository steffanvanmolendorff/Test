options emailhost=
 (
   "smtp.office365.com" 
   /* alternate: port=487 SSL */
   port=587 STARTTLS 
   auth=login
   /* your Gmail address */
   id="steffan.vanmolendorff@qlick2.com"
   /* optional: encode PW with PROC PWENCODE */
   pw="@FDi2014" 
 )
;
 
filename myemail EMAIL
  to="steffan.vanmolendorff@qlick2.com" 
  subject="Read SAS blogs";
 
data _null_;
  file myemail;
  put "Dear Friend,";
  put "I recommend that you read https://blogs.sas.com ";
  put "for lots of SAS news and tips.";
run;
 
filename myemail clear;
