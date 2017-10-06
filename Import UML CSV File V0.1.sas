PROC IMPORT OUT= WORK.PCA 
            DATAFILE= "C:\inetpub\wwwroot\sasweb\Data\Temp\UML\pcal_001_
001_01DD.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
