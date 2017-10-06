Libname OBData "C:\inetpub\wwwroot\sasweb\data\temp";

ods tagsets.tableeditor file="C:\inetpub\wwwroot\sasweb\data\temp\temp.html"
    options(autofilter="yes"
            autofilter_width="7em"
            autofilter_table="1"

            ) style=styles.mystyle ;

proc print data=sashelp.orsales(obs=100);
run;


%LET LIB= work ;

%MACRO BUILD_TAGSET(TAGSET=,COLS=) ;
  ods path &LIB..TEMPLAT(UPDATE) SASSTORE.TEMPLAT(READ) SASUSER.TEMPLAT(READ) SASHELP.TMPLMST(READ) ;

proc template ;
    define tagset &TAGSET ;
      parent=tagsets.htmlcss ;

define event initialize ;
   do / if $options["EVENT_ROW"] ;
     set $event_row $options["EVENT_ROW"] ;
   else ;
     set $event_row '1' ;
   done ;

   do / if $options["TABLEID"] ;
     set $tableid $options["TABLEID"] ;
   else ;
     set $tableid 'default_table' ;
   done ;
 end ;

 define event doc_head ;
    start:
      put "<head>" NL ;
      put "<script language='javascript' type='text/javascript' src='/media/js/jquery.js'></script>" NL
          "<script type='text/javascript' language='javascript' src='/media/js/jquery.dataTables.js'></script>" NL
          "<script type='text/javascript' charset='utf-8'>" NL
          "  $(document).ready(function() {" NL
          "    oTable = $('#" $tableid "').dataTable({" NL
          "                             'bJQueryUI': false," NL
          "                             'iDisplayLength': 50," NL
          "                             'sPaginationType': 'two_button'," NL
%IF &COLS ne %THEN %DO ;
          "                             'aoColumns': [" NL
	%DO _I = 1 %TO &N ;
          "                              {'bSortable':true} " %IF &_I < &N %THEN %DO ; "," %END ; NL
 	%END ;
          "                             ]," NL
%END ;
          "                             'bStateSave': false," NL
          "                             'iCookieDuration': 21600" NL /* SaveState cookie duration = 12 hours */
          "    });" NL
          "  } );" NL
          "</script>" NL
          "<link rel='stylesheet' type='text/css' href='/css/demo_table_jui.css'>" NL /* Change path to stylesheet here */
          "<style type='text/css'>" NL
          "  #" $tableid " { margin-top: 12px }" NL
          "</style>" NL
          ;
      put VALUE NL ;

   finish:
      put "</head>" NL ;
 end ;

 define event header ;
    start:
       do /if cmp( htmlclass, "DataEmphasis") and cmp ( colstart, "1");
          set $filter_row data_row;
          put "</tbody>" NL;
          put "<tfoot>" NL;
          put "<tr class=""noFilter"">" NL;
       done;

       do /if cmp( row, $event_row) ;
          put "<th" ; /* TH for last row in header      */
       else ;
          put "<td" ; /* TD for non-last rows in header */
       done ;

       putq " id=" HTMLID ;
       putq " headers=" headers /if $header_data_associations ;
       putq " title=" flyover ;

       trigger classalign ;
       trigger style_inline ;
       trigger rowcol ;
       put ">" ;

       trigger cell_value ;

    finish:
       trigger cell_value ;

       do /if cmp( row, $event_row) ;
          put "</th>" NL ;
       else ;
          put "</td>" NL ;
       done ;
  end ;

define event table_body;
  put "<tbody";
  put ">" NL;

  finish:
    do /if ^exist( $filter_row);
      put "</tbody>" NL;
    else;
      put "</tfoot>" NL;
    done;
end;

define event row;
  do /if cmp(section, 'head') ;
    put "<tr>" NL ;
  done ;

  finish:
    put "</tr>" NL;
end;

define event data;
  start:
     do /if ^cmp( htmlclass, "DataEmphasis") and cmp ( colstart, "1");
        put "<tr>" NL;
     done;

     do /if cmp( htmlclass, "DataEmphasis") and cmp ( colstart, "1");
        set $filter_row data_row;
        put "</tbody>" NL;
        put "<tfoot>" NL;
        put "<tr class=""noFilter"">" NL;
     done;

     trigger header /breakif cmp( htmlclass, "RowHeader");

     trigger header /breakif cmp( htmlclass, "Header");

     put "<td";
     putq " id=" HTMLID;
     putq " headers=" headers /if $header_data_associations;
     putq " title=" flyover;

     trigger classalign;

     trigger style_inline;

     trigger rowcol;
     put " nowrap" /if no_wrap;
     put ">";

     trigger cell_value;

  finish:
     trigger header /breakif cmp( htmlclass, "RowHeader");

     trigger header /breakif cmp( htmlclass, "Header");

     trigger cell_value;

     put "</td>" NL;
  end;

end ;


run ;
  ods path &LIB..TEMPLAT(READ) SASSTORE.TEMPLAT(READ) SASUSER.TEMPLAT(READ) SASHELP.TMPLMST(READ) ;
%MEND BUILD_TAGSET ;
%BUILD_TAGSET(TAGSET=&LIB..datatables) ;

ods path &LIB..TEMPLAT(READ) SASSTORE.TEMPLAT(READ) SASUSER.TEMPLAT(READ) SASHELP.TMPLMST(READ) ;


ods &LIB..datatables body="C:\inetpub\wwwroot\sasweb\Data\Results\Datatable.htm" style=styles.sasweb 
  options (event_row='1' tableid='table1')  ;

proc report data=sashelp.class 
  style(REPORT)={htmlid='table1'} ;
run ;
title;
ods &LIB..datatables close ;





*--- Filetrs in Excel ---;
  ods listing close;
  ods tagsets.excelxp file='filters.xls' style=statistical
      options(autofilter='all');
  proc print data=sashelp.class; run;
  ods tagsets.excelxp close;
  ods listing;



*--- THIS WORKS FOR COLUMN FILTERS ---;

%include "C:\inetpub\wwwroot\sasweb\TableEdit\tableeditor.tpl";
title "Listing of Product Sales"; 
ods listing close; 
ods tagsets.tableeditor file="C:\inetpub\wwwroot\sasweb\Data\Results\Sales_Report_1.html" 
    style=styles.meadow 
    options(autofilter="YES" 
 	    autofilter_table="1" 
            autofilter_width="6em" 
 	    autofilter_endcol= "15" 
            frozen_headers="YES" 
            frozen_rowheaders="YES" 
            ) ; 
 	proc print data=sashelp.prdsale noobs; 
   		var year quarter month country region prodtype 
 		    product actual predict; 
   		format actual predict nlmnlgbp12.2; 
 	run; 
ods tagsets.tableeditor close; 
ods listing; 


ods listing close; 
ods noproctitle; 
ods tagsets.tableeditor file="Sales_Report_2.html" 
    style=styles.meadow 
    options(web_tabs="First Report,Second Report"); 
    title "Summary of product sales"; 
    proc means data=sashelp.prdsale mean min max maxdec=2; 
   	class prodtype product; 
   	var actual predict; 
    run; 
    title "Mean product sales by country"; 
    proc tabulate data=sashelp.prdsale format=nlmnlgbp12.2; 
    	class prodtype product country; 
   	var actual predict; 
   	table prodtype*product,country*(actual*mean='' 
                                        predict*mean=''); 
    run; 
ods tagsets.tableeditor close; 
ods listing; 


%include "C:\inetpub\wwwroot\sasweb\TableEdit\tableeditor.tpl";

ods tagsets.Tableeditor file="C:\inetpub\wwwroot\sasweb\TableEdit\sample.xls"
options(button_text="create pivottable"
        auto_excel="yes"
           pivotrow="product_line"
           pivotcol="quarter"
         pivotdata="profit"
                   
           quit="no"
       );
proc print data=sashelp.orsales;
run;
ods tagsets.tableeditor close;
