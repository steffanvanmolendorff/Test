PROC IMPORT OUT= WORK.ATM 
            DATAFILE= "C:\inetpub\wwwroot\sasweb\Data\Temp\UML\atml_001_
001_01DD.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
