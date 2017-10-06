*============================================================================
		UK Postcodes: https://www.doogal.co.uk/PostcodeDownloads.php
		Ireland Postcodes: http://download.geonames.org/export/zip/
=============================================================================;
Libname OBData "C:\inetpub\wwwroot\sasweb\Data\Perm";
%Macro Import(Dsn);
PROC IMPORT OUT= WORK.&Dsn(Keep = Postcode Latitude Longitude District) 
            DATAFILE= "\\vmware-host\Shared Folders\steffanvanmolendorff On My Mac\TempSAS\sasweb\Data\Perm\&Dsn..csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
%Mend Import;
%Import(England1_Postcodes);
%Import(England2_Postcodes);
%Import(England3_Postcodes);
%Import(Scotland_Postcodes);
%Import(Wales_Postcodes);
%Import(Ireland_Postcodes);

Data Work.Postcodes;
	Length Postcode $ 7;
	Set Work.England1_Postcodes
	Work.England2_Postcodes
	Work.England3_Postcodes
	Work.Scotland_Postcodes
	Work.Wales_Postcodes
	Work.Ireland_Postcodes;

	Postcode = Scan(Postcode,1,'');
Run;

Proc Sort Data = Work.Postcodes
	Out = OBData.Postcodes;
	By Postcode;
Run;
