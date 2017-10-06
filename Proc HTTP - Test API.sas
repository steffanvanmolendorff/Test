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
Libname LibAPIs JSON Fileref=API;

*--- Proc datasets will create the datasets to examine resulting tables and structures ---;
Proc Datasets Lib = LibAPIs; 
Quit;

Data Work.&Bank._API;
	Set LibAPIs.Alldata;
Run;

%Mend API;
/*
%API(https://atlas.api.barclays/open-banking/v1.3/personal-current-accounts,Barclays,PCA);
%API(https://obp-api.danskebank.com/open-banking/v1.2/atms,Danske,ATM);

%API(https://api.santander.co.uk/retail/open-banking;
*/
*%API(https://atlas.api.barclays/open-banking/v1.3/atms,Barclays,ATM);
*%API(https://atlas.api.barclays/open-banking/v1.3/personal-current-accounts,Barclays,PCA);

*%API(https://api.santander.co.uk/retail/open-banking/v1.2/atms,Santander,ATM);

*%API(https://api.hsbc.com/open-banking/v1.2/personal-current-accounts,HSBC,PCA);

%API(https://openapi.bankofireland.com/open-banking/v1.2/business-current-accounts,Bank_of_Ireland,BCA);
*%API(https://openapi.bankofireland.com/open-banking/v1.2/business-current-accounts,Bank_of_Ireland,BCA);
*%API(https://openapi.coutts.co.uk/open-banking/v1.3/business-current-accounts,Coutts,BCA);
*%API(https://openapi.adambank.co.uk/open-banking/v1.3/business-current-accounts,Adam_Bank,BCA);


/*
Proc JSON Out = 'C:\inetpub\wwwroot\sasweb\data\results\test_json.json';
	Export Work.Barclays_API;
Run;
