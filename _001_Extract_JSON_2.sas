filename resp temp;
 
/* Neat service from Open Notify project */
proc http 
 url="http://api.open-notify.org/astros.json"
 method= "GET"
 out=resp;
run;
 
/* Assign a JSON library to the HTTP response */
libname space JSON fileref=resp;
 
/* Print result, dropping automatic ordinal metadata */
title "Who is in space right now? (as of &sysdate)";
proc print data=space.people (drop=ordinal:);
run;



/* split URL for readability */
%let url1=http://communities.sas.com/kntur85557/restapi/vc/categories/id/bi/topics/recent;
%let url2=?restapi.response_format=json%str(&)restapi.response_style=-types,-null,view;
%let url3=%str(&)page_size=100;
%let fullurl=&url1.&url2.&url3;
 
filename topics temp;
 
proc http
 url= "&fullurl."
 method="GET"
 out=topics;
run;
 
/* Let the JSON engine do its thing */
libname posts JSON fileref=topics;
title "Automap of JSON data";
 
/* examine resulting tables/structure */
proc datasets lib=posts; quit;
proc print data=posts.alldata(obs=20); run;







filename jmap "c:\temp\pca.map";
 
proc http
 url= "https://api.lloydsbank.com/open-banking/v2.1/personal-current-accounts"
 method="GET"
 out=topics;
run;
 
libname posts JSON fileref=topics map=jmap automap=create;



filename minmap 'c:\temp\pca.map';
 
proc http
 url= "&fullurl."
 method="GET"
 out=topics;
run;
 
libname posts json fileref=minmap map=pca;
proc datasets lib=posts; quit;
 
data messages;
 set posts.messages_message;
run;
