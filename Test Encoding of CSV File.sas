*--- Uncomment to run locally on laptop ---;

%Global _APINamme;
%Global _APIVersion;
%Global _SRVNAME;
%GLOBAL _Host;

%Let _SRVNAME = localhost;
%Let _Host = &_SRVNAME;
%Put _Host = &_Host;

%Let _APIName = PCA;
%Let _APIVersion = V2_2;

%Global _Host;
%Global _Path;

%Let _Host = &_SRVNAME;
%Put _Host = &_Host;

%Let _Path = http://&_Host/sasweb;
%Put _Path = &_Path;

%Macro Main(API_DSN,File);

Libname OBData "C:\inetpub\wwwroot\sasweb\Data\Perm";
Options MPrint MLogic Source Source2 Symbolgen;

%Macro Import(Filename,Dsn);
/**********************************************************************
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      22JUN17
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
***********************************************************************/
     data OBData.&Dsn;
     %let _EFIERR_ = 0; 
     infile "&Filename" delimiter = ','
  	MISSOVER DSD lrecl=32767 firstobs=2 Termstr=CRLF;
        informat XPath $1000. ;
        informat FieldName $91. ;
        informat ConstraintID $25. ;
        informat MinOccurs best32. ;
        informat MaxOccurs $9. ;
        informat DataType $50. ;
        informat Length $5. ;
        informat MinLength $25. ;
        informat MaxLength $25. ;
        informat Pattern $250. ;
        informat CodeName $1000. ;
        informat CodeDescription $1000. ;
        informat EnhancedDefinition $1000. ;
        informat XMLTag $25. ;
        format XPath $1000. ;
        format FieldName $91. ;
        format ConstraintID $25. ;
        format MinOccurs best12. ;
        format MaxOccurs $9. ;
        format DataType $50. ;
        format Length $5. ;
        format MinLength $25. ;
        format MaxLength $25. ;
        format Pattern $250. ;
        format CodeName $1000. ;
        format CodeDescription $1000. ;
        format EnhancedDefinition $1000. ;
        format XMLTag $25. ;

		If Substr(Xpath,1,1) EQ '"' then
	  	Do;
			_Infile_ = Tranwrd(_Infile_,',','');
	  	End;

     input
                 XPath $
                 FieldName $
                 ConstraintID $
                 MinOccurs
                 MaxOccurs $
                 DataType $
                 Length $
                 MinLength
                 MaxLength
                 Pattern $
                 CodeName $
                 CodeDescription $
                 EnhancedDefinition $
                 XMLTag $
     ;
     if _ERROR_ then call symputx('_EFIERR_',1);  
     run;


Data OBData.&Dsn/*(Drop = Hierarchy Position Want Rename=(Hierarchy1 = Hierarchy))*/;
	Length Pattern Hierarchy $ 1000 &DSN._Lev1 $ 1000;
	Set OBData.&Dsn;

	If XPath NE '';

	If "&Dsn" EQ "BCH" Then 
	Do;
		Hierarchy = Tranwrd(Substr(Trim(Left(XPath)),19),'/','-');
	End;
	Else If "&Dsn" EQ "SME" Then 
	Do;
		Hierarchy = Tranwrd(Substr(Trim(Left(XPath)),20),'/','-');
	End;
	Else If "&Dsn" EQ "&_APIName" Then 
	Do;
		Hierarchy = Tranwrd(Substr(Trim(Left(XPath)),21),'/','-');
	End;

	&DSN._Lev1 = Compress('Brand-'||Hierarchy);

*--- Delete the Hierarchy records which list the Mnemonics codes as the Swagger file does not have the Hierarchy values with Mnemonics ---;
	Mnemonics = Substr(Reverse(Trim(Left(Hierarchy))),5,1);
	If Mnemonics NE ':';
	If &DSN._Lev1 NE '';

*--- Remove double quotes from the EnhancedDefinition column to ensure these type of mismatches are suppressed in the reports ---;
	EnhancedDefinition = Tranwrd(EnhancedDefinition,'"','');

Run;

*--- Include this step to change the \\ to \ to match the data in the Swagger File ---;
	Data OBData.&Dsn(Drop = Pattern Rename=(Pattern1 = Pattern));
		Set OBData.&Dsn;
	
		If Trim(Left(Pattern)) NE '' Then
		Do;
			Pattern1 = Tranwrd(Trim(Left(Pattern)),"\\","\");
		End;
		Else Do;
			Pattern1 = Pattern;
		End;
		
	Run;

/*
*--- Update the Data structure to match the Swagger file ---;
	Data OBData.&Dsn(Drop = DataStructure Hierarchy Rename=(Datastructure1 = Hierarchy));
		Length DataStructure DataStructure1 $ 1028;
		Set OBData.&Dsn;
		If Substr(Hierarchy,1,3) EQ 'PCA' and DataStructure NE '' Then
		Do;
			DataStructure = Substr(Hierarchy,28);
			DataStructure1 = Compress('Brand-PCA-PCAMarketingState'||'-'||DataStructure);
		End;
		Else Do;
			DataStructure1 = Hierarchy;
		End;
	Run;
*/



Proc Sort Data = OBData.&Dsn
	Out = OBData.API_&Dsn.;
	By Hierarchy;
Run;

%Mend Import;
%Import(C:\inetpub\wwwroot\sasweb\Data\Temp\od\ob\&_APIVersion\&API_DSN.l_001_001_01DD.csv,&API_DSN);

%Main(&_APIName,personal_current_account);
