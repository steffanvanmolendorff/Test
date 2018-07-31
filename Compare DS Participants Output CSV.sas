PROC EXPORT DATA= WORK.DS_ONLY 
            OUTFILE= "C:\inetpub\wwwroot\sasweb\Data\Temp\DS\DS_Only.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;
