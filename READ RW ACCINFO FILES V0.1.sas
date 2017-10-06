PROC IMPORT OUT= WORK.OBACCOUNT 
            DATAFILE= "C:\inetpub\wwwroot\sasweb\Data\Temp\V1_1_1\A.1.1.
1\OBACCOUNT.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
