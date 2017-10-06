/**********************************************************************
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      21JUN17
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
***********************************************************************/
   data WORK.OBPaySet    ;
   %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
   infile 'C:\inetpub\wwwroot\sasweb\Data\Temp\OBPAYSET.csv' Delimiter = ',' MISSOVER DSD Lrecl=32767 Firstobs=2 Termstr=CRLF;
      informat Name $262. ;
      informat Occurrence $4. ;
      informat XPath $58. ;
      informat EnhancedDefinition $1024. ;
      informat Class $49. ;
      informat Codes $6. ;
      informat Pattern $12. ;
      informat TotalDigits $1. ;
      informat FractionDigits $1. ;
      format Name $262. ;
      format Occurrence $4. ;
      format XPath $58. ;
      format EnhancedDefinition $1024. ;
      format Class $49. ;
      format Codes $6. ;
      format Pattern $12. ;
      format TotalDigits $1. ;
      format FractionDigits $1. ;

	  input @;

	  If Substr(Xpath,1,1) EQ '"' then
	  Do;
			_Infile_ = Tranwrd(_Infile_,',','');
	  End;

   input
               Name :$
               Occurrence :$
               XPath :$
               EnhancedDefinition :$
               Class :$
               Codes :$
               Pattern :$
               TotalDigits :$
               FractionDigits :$
   ;
   if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
   run;
