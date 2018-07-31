Proc Template;

 	Define style Style.Sasweb;
	End;

Run; 

ods html file='ProcTemplate.html' style=styles.Sasweb; 
proc print data = sashelp.shoes;
run;
ods html close;


/*

ods markup file="sample2.html" tagset=tagsets.style_popup;
	title 'Class List';
	footnote 'See www.laurenhaworth.com for more ODS papers and examples';
proc print data = sashelp.shoes;
run;
ods markup close;  
