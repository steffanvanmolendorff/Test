Libname OBData "c:\inetpub\wwwroot\sasweb\data\perm";
/* Show the configuration file and the encoding setting for the SAS session */
proc options option=config; run;
proc options group=languagecontrol; run; 

/* Show the encoding value for the problematic data set */
%let dsn=OBData.PCA;
%let dsid=%sysfunc(open(&dsn,i));
%put &dsn ENCODING is: %sysfunc(attrc(&dsid,encoding));
%let rc=%sysfunc(close(&dsid));
