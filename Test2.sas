data names;
 length firstname lastname $ 50;
run;
proc sql undo_policy=none;
 insert into work.names
 set
 lastname="&lastname",
 firstname="&firstname";
quit;
proc json out=_webout;
 export names / nokeys nosastags;
run;



proc json out="C:\inetpub\wwwroot\sasweb\data\Results\SAS_JSON.json";
   export OBData.BCA / nokeys nosastags;
run;
