Data Work.X;
	Set LibAPIs.Alldata(Where=(V NE 0));
Run;

proc sort data = lloyds_bank_pca;
by rowcnt;
run;
proc sort data = lloyds_bank_pca;
by hierarchy;
run;

proc sort data = hsbc_pca;
by rowcnt;
run;

proc sort data = x2;
by var2;
run;
proc sort data = x2;
by rowcnt;
run;


Data Work.lloyds_X2;
	Set Work.lloyds_bank_pca;
	By RowCnt;

	If Var2 EQ 'data-Brand-PCA-Name' Then
	Do;
		_Record_ID + 1;
		_Hier_ID = 0;
		_Element_ID = 0;
	End;
	If V = 0 Then 
	Do;
		_Hier_ID + 1;
		_Element_ID = 0;
	End;
	Else If _Hier_ID = 0 and V = 1 Then
	Do;
		_Element_ID = 0;
	End;
	Else If _Hier_ID > 0 and V = 1 Then
	Do;
		_Element_ID + 1;
	End;
	Retain _Record_ID _Hier_ID _Element_ID;
Run;
