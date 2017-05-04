Libname CSVFile "H:\StV\Open Banking\JSON Test";


PROC IMPORT OUT= WORK.JSON 
            DATAFILE= "H:\StV\Open Banking\JSON\API-USER-Transpose.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

