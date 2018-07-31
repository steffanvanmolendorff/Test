 %let CONSUMER_KEY=@steffanvm
 %let CONSUME_SECRET=<your_consumer_secret>
 %let JSON_TWEET_FILE=C:\Twitter\ResponseContent.txt;
 %let CSV_TWEET_FILE=C:\Twitter\ResponseContent.csv;
 %let TWEET_QUERY=%23SASGF13+OR+%23SASUSERS+OR+%23SASGF14;
 
 /* Create a temporary file name used for the XMLMap */
 %macro tempFile( fname );
  %if %superq(SYSSCPL) eq %str(z/OS) or %superq(SYSSCPL) eq %str(OS/390) %then 
    %let recfm=recfm=vb;
  %else
    %let recfm=;
  filename &fname TEMP lrecl=2048 &recfm;
 %mend;
 
 /* create temp files for the content and header input streams */
 %tempFile(in);
 %tempFile(hdrin);
 
 /* keep the response permanently */
 filename out "&JSON_TWEET_FILE.";
 
 /* post request content is the grant_type */
 data _null_;
   file in;
   put "grant_type=client_credentials&";
 run;
 
 /* request the bearer token by providing consumer key and secret */
 data _null_;
   file hdrin;
   consumerKey = urlencode("&CONSUMER_KEY.");
   consumerSecret = urlencode("&CONSUME_SECRET.");
   encodedAccessToken  = put( compress(consumerKey || ":" || consumerSecret),$base64x32767.);
   put "Authorization: Basic " encodedAccessToken;
 run;
 
 proc http method="post"
    in=in out=out
    headerin=hdrin
    url="https://api.twitter.com/oauth2/token"
    ct="application/x-www-form-urlencoded;charset=UTF-8";
 run;
 
 /* Store bearer token in macro variable 'BEARER_TOKEN' */
 proc groovy classpath="groovy-all-2.2.1.jar";
    submit "&JSON_TWEET_FILE.";
      import groovy.json.JsonSlurper
      def input = new File(args[0]).text
      def result = new JsonSlurper().parseText(input)
      println "Recieved bearer token: ${result.access_token}"
      exports.putAt('BEARER_TOKEN',result.access_token)
    endsubmit;
 quit;
