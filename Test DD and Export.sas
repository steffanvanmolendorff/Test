Data OBData.X;
	Set OBData.BCA_Code_Compare(Where=(
	CodeName_Flag = 'Mismatch' or
	CodeListName_Flag = 'Mismatch' or
	CodeDesc_Flag = 'Mismatch' or
	Inversion_Flag = 'Mismatch'));
Run;

Proc Export Data = OBData.X
 	Outfile = "C:\inetpub\wwwroot\sasweb\Data\Results\BCA_CodeList_DD_Comparison1.csv"
	DBMS = CSV REPLACE;
	PUTNAMES=YES;
Run;


