data x(Keep = Org_Name Elect_Ordinary_Admis);
	set NHSData.NHS;
run;


data y;

	%Macro TestVar(VarName);
Data y;
	set x(Keep=&Varname);
		dsid = open('x');
		Test = varnum(dsid,"&Varname");
		If Test > 0 Then
		do;
			if varnum(dsid,"&Varname") then 
			do;
				_20_&Varname = &Varname * (20/100);
			end;
		end;
		rc = close(dsid);
run;
	%Mend TestVar;

	%TestVar(Elect_Ordinary_Admis);
	%TestVar(Elect_Daycase_Admis);

run;

