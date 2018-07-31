Libname OBData "C:\inetpub\wwwroot\sasweb\Data\Perm";

%Macro ImportFiles(FileName);
PROC IMPORT OUT= WORK.&Filename 
            DATAFILE= "C:\inetpub\wwwroot\sasweb\Data\Temp\DS\&FileName..csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

Data Work.&FileName(Drop = Account_Name Rename=(New_Name = Account_Name));
	Length New_Name $50 Role_Types $25 Applicable $3;
	Set Work.&FileName;
	New_Name = Upcase(Account_Name);
	FileName = "&FileName";	
Run;

Proc Sort Data = Work.&FileName;
	By Account_Name;
Run;
%Mend ImportFiles;
%ImportFiles(DS_Access_RAW);
%ImportFiles(PRD_DS_ACCESS_RAW);
%ImportFiles(Split_121);

Data Work.DS_Split;
	Merge Work.DS_Access_Raw(In=a)
	Work.Split_121(In=b);
	By Account_Name;
	If a and b then Infile = 'BOTH';
	If a and not b then Infile = 'DST';
	If b and not a then Infile = 'S121';
Run;

Data Work.PRD_DS_Split;
	Merge Work.PRD_DS_Access_Raw(In=a)
	Work.Split_121(In=b);
	By Account_Name;
	If a and b then Infile = 'BOTH';
	If a and not b then Infile = 'PRD';
	If b and not a then Infile = 'S121';
Run;

Data Work.DS_Only;
	Set Work.DS_Split;
	If Infile EQ 'DST' and Trim(Left(Applicable)) NE 'N/A';
Run;

Data Work.PRD_DS_Only;
	Set Work.PRD_DS_Split;
	If Infile EQ 'PRD' and Trim(Left(Applicable)) NE 'N/A';
Run;

Data Work.PRD_DS_Both;
	Set DS_Split
	Work.PRD_DS_Split;
/*	If Infile EQ 'BOTH';*/
Run;

PROC EXPORT DATA= WORK.DS_Only
            OUTFILE= "C:\inetpub\wwwroot\sasweb\Data\Temp\DS\DS_Only.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

PROC EXPORT DATA= WORK.PRD_DS_Only 
            OUTFILE= "C:\inetpub\wwwroot\sasweb\Data\Temp\DS\PRD_DS_Only.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

PROC EXPORT DATA= WORK.PRD_DS_Both
            OUTFILE= "C:\inetpub\wwwroot\sasweb\Data\Temp\DS\PRD_DS_Both.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

/*
Data Work.PRD_DS_Split;
	Merge Work.Particpants_ds_access(In=a)
	Work.Production_DS(In=b)
	Work.Split_121(In=c);
	By Account_Name;
	If a and b and c then Infile = 'All3';
	If a and not b and not c then Infile = 'DST';
	If b and not a and not c then Infile = 'PRD';
	If c and not a and not b then Infile = 'S121';
Run;

