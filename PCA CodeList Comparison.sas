Libname OBData "C:\inetpub\wwwroot\sasweb\Data\Temp";
/*
PROC IMPORT OUT= WORK.PCA_CodeList_NonFees 
            DATAFILE= "C:\inetpub\wwwroot\sasweb\Data\Temp\UML\PCA_CodeList_NonFees.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

PROC IMPORT OUT= WORK.PCA_CodeList_Fees 
            DATAFILE= "C:\inetpub\wwwroot\sasweb\Data\Temp\UML\PCA_CodeList_Fees.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
*/

    data WORK.PCA_CODELIST_NONFEES    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'C:\inetpub\wwwroot\sasweb\Data\Temp\UML\PCA_CodeList_NonFees.csv'
	delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 TermStr = CRLF;
       informat CodelistName $50. ;
       informat Endpoint_CodeName $24. ;
       informat Endpoint_Code $4. ;
       informat Description $1000. ;
       informat Include_in_v2_0_ $1. ;
       informat Added_in_v2_0 $1. ;
       informat Notes $121. ;
       informat ISO20022_CodeLIst $1. ;
       informat ISO20022_CodeName $1. ;
       format CodelistName $50. ;
       format Endpoint_CodeName $24. ;
       format Endpoint_Code $4. ;
       format Description $1000. ;
       format Include_in_v2_0_ $1. ;
       format Added_in_v2_0 $1. ;
       format Notes $121. ;
       format ISO20022_CodeLIst $1. ;
       format ISO20022_CodeName $1. ;
    input
                CodelistName $
                Endpoint_CodeName $
                Endpoint_Code $
                Description $
                Include_in_v2_0_ $
                Added_in_v2_0 $
                Notes $
                ISO20022_CodeLIst $
                ISO20022_CodeName $
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
    run;




data WORK.PCA_CODELIST_FEES;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile 'C:\inetpub\wwwroot\sasweb\Data\Temp\UML\PCA_CodeList_Fees.csv' 
	delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 TermStr = CRLF;
       informat CodelistName $50. ;
       informat CodeName $24. ;
       informat CodeCategory $6. ;
       informat Code_Mnemonic $4. ;
       informat Description $1000. ;
       informat Include_in_v2_0_ $1. ;
       informat Added_in_v2_0 $1. ;
       informat Notes $89. ;
       informat ISO20022_CodeLIst $1. ;
       informat ISO20022_CodeName $1. ;
       format CodelistName $50. ;
       format CodeName $24. ;
       format CodeCategory $6. ;
       format Code_Mnemonic $4. ;
       format Description $1000. ;
       format Include_in_v2_0_ $1. ;
       format Added_in_v2_0 $1. ;
       format Notes $89. ;
       format ISO20022_CodeLIst $1. ;
       format ISO20022_CodeName $1. ;

	   Input @;
		If Substr(Description,1,1) EQ '"' then
	  	Do;
			_Infile_ = Tranwrd(_Infile_,',','');
	  	End;


		input
                CodelistName $
                CodeName $
                CodeCategory $
                Code_Mnemonic $
                Description $
                Include_in_v2_0_ $
                Added_in_v2_0 $
                Notes $
                ISO20022_CodeLIst $
                ISO20022_CodeName $
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
run;



Data Work.PCA_CodeList_Fees1(Drop = Description);
	Set Work.PCA_CodeList_Fees;
	CodeDescription = Description;
	If Include_in_v2_0_ = 'N' or CodeName EQ '' then Delete;
/*	Where CodeListName = 'OB_CardType1Code';*/
Run;

Data Work.PCA_CodeList_NonFees1(Drop = Description Rename=(EndPoint_CodeName = CodeName));
	Set Work.PCA_CodeList_NonFees;
	CodeDescription = Description;
	If Include_in_v2_0_ = 'N' or EndPoint_CodeName EQ '' then Delete;
/*	Where CodeListName = 'OB_CardType1Code';*/
Run;


Data Work.PCA_CodeList;
	Length CodelistName $ 50 CodeName CodeDescription $ 1000;
	Set Work.PCA_CodeList_Fees1(In=a Drop = Notes)
	Work.PCA_CodeList_NonFees1(In=b Drop = Notes);
	Length Infile $ 8;
	If a then InFile = 'Fees';
	If b then Infile = 'Non-Fees';
	CodeListName = Trim(Left(CodeListName));
	CodeName = Trim(Left(CodeName));
	CodeDescription = Trim(Left(CodeDescription));

/*	Where CodeListName = 'OB_CardType1Code';*/
Run;

Proc Sort Data = Work.PCA_CodeList(Keep = CodeName CodeListName CodeDescription) ;
	By CodeListName CodeName CodeDescription;
Run;



*--- Get data from API_PCA Data Dictionary data ---;
Proc Sort Data = OBData.API_PCA
	Out = Work.API_PCA(Keep = Hierarchy Data_Type CodeName CodeDescription
	Rename = (Data_Type = CodeListName)) NoDupKey;
	By Hierarchy Data_Type CodeName CodeDescription;
/*	Where Data_Type EQ 'OB_CardType1Code';*/
Run;


Data Work.API_PCA1(Drop = CodeListName Rename = (NewVar = CodeListName));
	Set Work.API_PCA;
	By Hierarchy CodeListName CodeName CodeDescription;

	Retain NewVar;	

	If Not Missing(CodeListName) Then NewVar = CodeListName;
Run;

Proc Sort Data = Work.API_PCA1
		Out = Work.API_PCA2 NoDupKey;
	By CodeListName CodeName CodeDescription;
Run;


Data OBData.PCA_Code_Compare;
	Length Count 4 Hierarchy $ 1000 CodeListName $ 50 CodeName CodeDescription $ 1000;
	Merge Work.API_PCA2(In=b Keep = Hierarchy CodeListName CodeName CodeDescription)
	Work.PCA_CodeList(In=a Keep = CodeListName CodeName CodeDescription);
	By CodeListName CodeName CodeDescription;
	If a and not b Then Infile = 'CodeList';
	If b and not a Then Infile = 'DD';
	If a and b Then Infile = 'Both';
	Count = _N_;

/*	Where CodeListName = 'OB_CardType1Code';*/

Run;

