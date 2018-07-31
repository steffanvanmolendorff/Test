proc options;run;
*--- The Main macro will execute the code to extract data from the API end points ---;
%Macro API(Url,Bank,API);

Filename API Temp;
 
*--- Proc HTTP assigns the GET method in the URL to access the data ---;
Proc HTTP
	Url = "&Url."
 	Method = "GET"
 	Out = API;
Run;


*--- The JSON engine will extract the data from the JSON script ---; 
Libname LibAPIs JSON Fileref=API Ordinalcount = All;

*--- Proc datasets will create the datasets to examine resulting tables and structures ---;
Proc Datasets Lib = LibAPIs; 
Quit;

Data Work.&Bank._API;
	Set LibAPIs.Alldata;
Run;

%Mend API;
%API(http://localhost/sasweb/data/temp/ob/sqm/v1_0/PCA_GB_Full.json,GB,SQM);
/*
%API(http://localhost/sasweb/data/temp/ob/sqm/v1_0/astros.json,OB,SQM);
%API(http://localhost/sasweb/data/temp/ob/sqm/v1_0/test.json,OB,SQM);
%API(http://localhost/sasweb/data/temp/ob/sqm/v1_0/atms.json,OB,ATM);
%API(http://localhost/sasweb/data/temp/ob/sqm/v1_0/sqm_swagger.json,OB,SQM);
%API(http://localhost/sasweb/data/temp/ob/sqm/v1_0/pcs_gb_agg.json,OB,SQM);


%API(http://localhost/sasweb/data/temp/ob/sqm/v1_0/account_v1_1_swagger.json,ACC1,AC1);
%API(http://localhost/sasweb/data/temp/ob/sqm/v1_0/account_v2_0_swagger.json,ACC2,AC2);
*/
