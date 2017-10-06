

%Macro Dsn(Dsn);
Data Work.&Dsn;
	A = 1;
	&Dsn = _N_;
Run;
%Mend Dsn;
%Dsn(A);
%Dsn(B);
%Dsn(C);
%Dsn(D);
%Dsn(E);
%Dsn(F);

/*Data Work.Combine;*/
/*Run;*/


Data Work.Combine1;
	Set A B C D E F;
Run;
Options MPrint MLogic Source Source2 Symbolgen;
%Global Datasets;
	%Let Datasets =;
	%Macro TestDsn(DsName);
		%If %Sysfunc(exist(&DsName)) %Then
		%Do;
			%Let DSNX = &DsName;
			%Put DSNX = &DSNX;

			%Let Datasets = &Datasets &DSNX;
			%Put Datasets = &Datasets;
		%End;
	%Mend TestDsn;
	%TestDsn(A);
	%TestDsn(B);
	%TestDsn(C);
	%TestDsn(D);
	%TestDsn(E);
	%TestDsn(F);
	%TestDsn(G);


%Macro Main();
Data Work.Combine;
		Set &Datasets;
Run;
%Mend Main;
%Main();
