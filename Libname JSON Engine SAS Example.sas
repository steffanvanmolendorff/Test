/****************************************/
/* Example of using JSON libname engine */
/* for discovery, then with a JSON map  */
/* Copyright 2016 SAS Institute         */
/* written by Chris Hemedinger          */
/* http://blogs.sas.com/sasdummy        */
/****************************************/

/* split URL for readability */
/*
%let url1=http://communities.sas.com/kntur85557/restapi/vc/categories/id/bi/topics/recent;
%let url2=?restapi.response_format=json%str(&)restapi.response_style=-types,-null,view;
%let url3=%str(&)page_size=100;
%let fullurl=&url1.&url2.&url3;
*/
%let fullurl=http://localhost/sasweb/data/temp/json/atm.json;

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

/* Now create an automatic map to examine */
filename topics temp;
filename jmap "%sysfunc(GETOPTION(WORK))/top.map";

proc http
 url= "&fullurl."
 method="GET"
 out=topics;
run;

libname posts JSON fileref=topics map=jmap automap=create;
title "Using automatic JSON map";
proc datasets lib=posts; quit;

/* Finally, substitute in a custom map  */
filename topics temp;
filename minmap "%sysfunc(GETOPTION(WORK))/minmap.map";

data _null_ Work.X;
infile datalines;
file minmap;
input;
put _infile_;
datalines;
{
  "DATASETS": [
    {
      "DSNAME": "messages",
      "TABLEPATH": "/root/response/messages/message",
      "VARIABLES": [
        {
          "NAME": "view_href",
          "TYPE": "CHARACTER",
          "PATH": "/root/response/messages/message/view_href",
          "CURRENT_LENGTH": 136
        },
        {
          "NAME": "id",
          "TYPE": "NUMERIC",
          "PATH": "/root/response/messages/message/id"
        },
        {
          "NAME": "subject",
          "TYPE": "CHARACTER",
          "PATH": "/root/response/messages/message/subject",
          "CURRENT_LENGTH": 84
        },
        {
          "NAME": "view_friendly_date",
          "TYPE": "CHARACTER",
          "PATH": "/root/response/messages/message/post_time/view_friendly_date",
          "CURRENT_LENGTH": 12
        },
        {
          "NAME": "datetime",
           "TYPE": "NUMERIC",
		  "INFORMAT": [ "IS8601DT", 19, 0 ],
		  "FORMAT": ["DATETIME", 20],
          "PATH": "/root/response/messages/message/post_time/_",
          "CURRENT_LENGTH": 8
        },
        {
          "NAME": "views",
          "TYPE": "NUMERIC",
          "PATH": "/root/response/messages/message/views/count"
        },
         {
          "NAME": "login",
          "TYPE": "CHARACTER",
          "PATH": "/root/response/messages/message/last_edit_author/login",
          "CURRENT_LENGTH": 15
        },
        {
          "NAME": "likes",
          "TYPE": "NUMERIC",
          "PATH": "/root/response/messages/message/kudos/count"
        }
      ]
    }
  ]
}
;
run;

proc http
 url= "&fullurl."
 method="GET"
 out=topics;
run;

title "Using custom JSON map";
libname posts json fileref=topics map=minmap;
proc datasets lib=posts; quit;

data messages;
 set posts.messages;
run;

proc print data=messages; run;
