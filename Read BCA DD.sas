Options MLOGIC MPRINT SOURCE SOURCE2 SYMBOLGEN;

Libname OBData "C:\inetpub\wwwroot\sasweb\Data\Temp";

%Macro Import(Filename,Dsn);

/*
Data OBData.&Dsn    ;
   %let _EFIERR_ = 0; 
   infile "&Filename" delimiter = ',' Termstr=CRLF
MISSOVER DSD lrecl=32767 firstobs=2 ;
         informat XPath $1000. ;
         informat FieldName $91. ;
         informat ConstraintID $60. ;
         informat MinOccurs $52. ;
         informat MaxOccurs $56. ;
         informat Data_Type $50. ;
         informat Length $5. ;
         informat MinLength $1000. ;
         informat MaxLength $1000. ;
         informat Pattern $25. ;
         informat CodeName $1000. ;
         informat CodeDescription $1000. ;
         informat EnhancedDefinition $1024. ;
         informat XMLTag $25. ;
         format XPath $1000. ;
         format FieldName $91. ;
         format ConstraintID $60. ;
         format MinOccurs $52. ;
         format MaxOccurs $56. ;
         format Data_Type $50. ;
         format Length $5. ;
         format MinLength $1000. ;
         format MaxLength $1000. ;
         format Pattern $25. ;
         format CodeName $1000. ;
         format CodeDescription $1000. ;
         format EnhancedDefinition $1024. ;
         format XMLTag $25. ;

		If Substr(Xpath,1,1) EQ '"' then
	  	Do;
			_Infile_ = Tranwrd(_Infile_,',','');
	  	End;

      input
                  XPath $
                  FieldName $
                  ConstraintID $
                  MinOccurs $
                  MaxOccurs $
                  Data_Type $
                  Length $
                  MinLength $
                  MaxLength $
                  Pattern $
                  CodeName $
                  CodeDescription $
                  EnhancedDefinition $
                  XMLTag $
      ;
   if _ERROR_ then call symputx('_EFIERR_',1);  
   run;
*/



     data Work.&Dsn;
     %let _EFIERR_ = 0; 
     infile "&Filename" delimiter = ','
  	MISSOVER DSD lrecl=32767 firstobs=2 Termstr=CRLF;
        informat XPath $1000. ;
        informat FieldName $91. ;
        informat ConstraintID $25. ;
        informat MinOccurs best32. ;
        informat MaxOccurs $9. ;
        informat DataType $25. ;
        informat Length $5. ;
        informat MinLength $1000. ;
        informat MaxLength $1000. ;
        informat Pattern $25. ;
        informat CodeName $1000. ;
        informat CodeDescription $1000. ;
        informat EnhancedDefinition $1024. ;
        informat XMLTag $25. ;
        format XPath $1000. ;
        format FieldName $91. ;
        format ConstraintID $25. ;
        format MinOccurs best12. ;
        format MaxOccurs $9. ;
        format DataType $25. ;
        format Length $5. ;
        format MinLength $1000. ;
        format MaxLength $1000. ;
        format Pattern $25. ;
        format CodeName $1000. ;
        format CodeDescription $1000. ;
        format EnhancedDefinition $1024. ;
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
	Set Work.&Dsn;

	If XPath NE '';

	If "&Dsn" EQ 'BCA' Then 
	Do;
		Hierarchy = Tranwrd(Substr(Trim(Left(XPath)),16),'/','-');
	End;

	&DSN._Lev1 = Hierarchy;
Run;

Proc Sort Data = OBData.&Dsn
	Out = OBData.API_&Dsn.;
	By Hierarchy;
Run;

%Mend Import;
%Import(C:\inetpub\wwwroot\sasweb\Data\Temp\UML\bcal_001_001_01DD.csv,BCA);


