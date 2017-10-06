%Global _APINamme;

%Macro Main(API_DSN,File);

Libname OBData "C:\inetpub\wwwroot\sasweb\Data\Perm";
Options MPrint MLogic Source Source2 Symbolgen;

*--- Set system options to track comments in the log file ---;
*Options DMSSYNCHK;

*--- The Main macro will execute the code to extract data from the API end points ---;
%Macro Schema(Url,JSON,API_SCH);
*--- Set a temporary file name to extract the content of the Schema JSON file into ---;
Filename API Temp LRECL=100000;
 
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

*--- Capture any error codes at this point, specifically if the Schema file did no load ---;
%If &SYSERR > 0 %Then
%Do;
	%Let SYSTEM_ERROR = &SYSERR;
%End;

*--- Create the Bank Schema dataset ---;
Data Work.&JSON;
	Set LibAPIs.Alldata(Where=(V NE 0));
Run;

%Mend Schema;
%Schema(http://localhost/sasweb/data/temp/json/&File..json,&API_DSN,Swagger_&API_DSN);


%Mend Main;
%Macro SelectAPI();
/*
	%Main(BCA,business_current_account);
	%Main(PCA,personal_current_account);
	%Main(ATM,atm);
	%Main(BCH,branch);
	%Main(SME,sme_loan);
	%Main(CCC,commercial_credit_card);
*/
	%Main(SWA,master_swagger);

%Mend SelectAPI;
%SelectAPI();
