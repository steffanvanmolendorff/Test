Data Work.Shoes;
	Set Sashelp.Shoes;
Run;

%Let _WebUser = steffan@vanmolendorff.com;
%Macro ExportXL(Path);
options emailsys=smtp emailhost=smtp.stackmail.com emailport=25 emailpw="@Octa7700";
FILENAME Mailbox EMAIL "&_WebUser"
Subject='Test Mail message' ATTACH="&Path";

DATA _NULL_;
FILE Mailbox;
PUT "Hello";
PUT "Please find Report as an attachment";
PUT "Thank you";
RUN;

%Mend ExportXL;
%ExportXL(C:\inetpub\wwwroot\sasweb\Data\Results\BOI\API_BOI_ATM.csv);
