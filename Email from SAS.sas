FILENAME Mailbox EMAIL "steffan@vanmolendorff.com"
Subject='Test Mail message' ATTACH="C:\inetpub\wwwroot\sasweb\Data\Results\Lloyds_BCH_Fail.csv";
DATA _NULL_;
FILE Mailbox;
PUT "Hello";
PUT "Please find Report as an attachment";
PUT "Thank you";
RUN;
