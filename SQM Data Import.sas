    /**********************************************************************
    *   PRODUCT:   SAS
    *   VERSION:   9.4
    *   CREATOR:   External File Interface
    *   DATE:      04JUN18
    *   DESC:      Generated SAS Datastep Code
    *   TEMPLATE SOURCE:  (None Specified.)
    ***********************************************************************/
       data WORK.SQM    ;
       %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
       infile 'C:\inetpub\wwwroot\sasweb\Data\Temp\OB\SQM\v1.0\sqml_001_001_01DD.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
          informat XPath $300. ;
          informat FieldName $25. ;
          informat ConstraintID $1. ;
          informat MinOccurs best32. ;
          informat MaxOccurs $15. ;
          informat DataType $20. ;
          informat Length $20. ;
          informat MinLength $1. ;
          informat MaxLength $1. ;
          informat Pattern $20. ;
          informat CodeName $30. ;
          informat CodeDescription $100. ;
          informat EnhancedDefinition $100. ;
          informat XMLTag $1. ;
          format XPath $300. ;
          format FieldName $25. ;
          format ConstraintID $1. ;
          format MinOccurs best12. ;
          format MaxOccurs $15. ;
          format DataType $20. ;
          format Length $20. ;
          format MinLength $1. ;
          format MaxLength $1. ;
          format Pattern $20. ;
          format CodeName $30. ;
          format CodeDescription $100. ;
          format EnhancedDefinition $100. ;
          format XMLTag $1. ;
       input
                   XPath  $
                   FieldName  $
                   ConstraintID  $
                   MinOccurs
                   MaxOccurs  $
                   DataType  $
                   Length  $
                   MinLength  $
                   MaxLength  $
                   Pattern  $
                   CodeName  $
                   CodeDescription  $
                   EnhancedDefinition  $
                   XMLTag  $
       ;
       if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
       run;
