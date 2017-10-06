%Global _Host;
%Let _Host = Localhost;
%Put _Host = &_Host;
*--- The Main macro will execute the code to extract data from the API end points ---;
%Macro Schema(Url);
*--- Set a temporary file name to extract the content of the Schema JSON file into ---;
Filename API Temp;
 
*--- Proc HTTP assigns the GET method in the URL to access the data contained within the Schema ---;
Proc HTTP
	Url = "&Url."
 	Method = "GET" Verbose
 	Out = API;
Run;
 
*--- The JSON engine will extract the data from the JSON script ---; 
Libname LibAPIs JSON Fileref=API;

*--- Proc datasets will create the datasets to examine resulting tables and structures ---;
Proc Datasets Lib = LibAPIs; 
Quit;

*--- Create the Bank Schema dataset ---;
Data Work.BCA Work.X;
	Set LibAPIs.Alldata(Where=(V NE 0));
Run;

%Mend Schema;
/*%Schema(http://&_Host/sasweb/data/temp/V2_2/json/bca_swagger.json);*/
/*%Schema(http://&_Host/sasweb/data/temp/V2_2/json/business_current_account.json);*/
%Schema(http://&_Host/sasweb/data/temp/V2_2/json/business_current_account_1.json);
