%Macro Import(Filename,Dsn);
Data WORK.&Dsn    ;
   %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
   infile "&Filename" delimiter = ',' Termstr=CRLF
MISSOVER DSD lrecl=32767 firstobs=2 ;
      informat XPath $250. ;
      informat Name $14. ;
      informat ConstraintID $2. ;
      informat MinOccurs best32. ;
      informat MaxOccurs $9. ;
      informat Data_type $26. ;
      informat Length $1. ;
      informat MinLength $ 25. ;
      informat MaxLength $ 25. ;
      informat Pattern $20. ;
      informat Code_Name $25. ;
      informat EnhancedDefinition $1024. ;
      informat XMLTag $4. ;
      format XPath $250. ;
      format Name $14. ;
      format ConstraintID $2. ;
      format MinOccurs best12. ;
      format MaxOccurs $9. ;
      format Data_type $26. ;
      format Length $1. ;
      format MinLength $ 25. ;
      format MaxLength $ 25. ;
      format Pattern $20. ;
      format Code_Name $25. ;
      format EnhancedDefinition $1024. ;
      format XMLTag $4. ;

	  input @;

	  If Substr(Xpath,1,1) EQ '"' then
	  Do;
/*			_Infile_ = Tranwrd(_Infile_,',','');*/
	  End;

   input
               XPath $
               Name $
               ConstraintID $
               MinOccurs
               MaxOccurs $
               Data_type $
               Length $
               MinLength $
               MaxLength $
               Pattern $
               Code_Name $
               EnhancedDefinition $
               XMLTag $
   ;
   if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
   run;

   /*
Data OBData.&Dsn;
	Length Pattern Hierarchy $ 500;
	Set Work.&Dsn;

	If XPath NE '';

	If "&Dsn" EQ 'ATM' Then 
	Do;
		Hierarchy = Tranwrd(Substr(Trim(Left(XPath)),16),'/','-');
	End;

	If "&Dsn" EQ 'BRA' Then 
	Do;
		Hierarchy = Tranwrd(Substr(Trim(Left(XPath)),19),'/','-');
	End;

	If "&Dsn" EQ 'PCA' Then 
	Do;
		Hierarchy = Tranwrd(Substr(Trim(Left(XPath)),16),'/','-');
	End;

Run;

Proc Sort Data = OBData.&Dsn;
	By Hierarchy;
Run;
*/
%Mend Import;
/*%Import(C:\inetpub\wwwroot\sasweb\Data\Temp\UML\&API_DSN.l_001_001_01DD.csv,&API_DSN);*/
%Import(C:\inetpub\wwwroot\sasweb\Data\Temp\UML\pcal_001_001_01DD.csv,PCA);*/






   /**********************************************************************
   *   PRODUCT:   SAS
   *   VERSION:   9.4
   *   CREATOR:   External File Interface
   *   DATE:      23JUN17
   *   DESC:      Generated SAS Datastep Code
   *   TEMPLATE SOURCE:  (None Specified.)
   ***********************************************************************/;
      data WORK.PCA    ;
      %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
      infile 'C:\inetpub\wwwroot\sasweb\Data\Temp\UML\pcal_001_001_01DD.csv' delimiter = ',' 
		MISSOVER DSD lrecl=32767 firstobs=2 Termstr=CRLF;
         informat XPath $113. ;
         informat FieldName $91. ;
         informat ConstraintID $60. ;
         informat MinOccurs $52. ;
         informat MaxOccurs $56. ;
         informat Data_Type $25. ;
         informat Length $1. ;
         informat MinLength best32. ;
         informat MaxLength best32. ;
         informat Pattern $1. ;
         informat CodeName $8. ;
         informat CodeDescription $149. ;
         informat EnhancedDefinition $358. ;
         informat XMLTag $11. ;
         format XPath $113. ;
         format FieldName $91. ;
         format ConstraintID $60. ;
         format MinOccurs $52. ;
         format MaxOccurs $56. ;
         format Data_Type $25. ;
         format Length $1. ;
         format MinLength best12. ;
         format MaxLength best12. ;
         format Pattern $1. ;
         format CodeName $8. ;
         format CodeDescription $149. ;
         format EnhancedDefinition $358. ;
         format XMLTag $11. ;
      input
                  XPath $
                  FieldName $
                  ConstraintID $
                  MinOccurs $
                  MaxOccurs $
                  Data_Type $
                  Length $
                  MinLength
                  MaxLength
                  Pattern $
                  CodeName $
                  CodeDescription $
                  EnhancedDefinition $
                  XMLTag $
      ;
      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
      run;


