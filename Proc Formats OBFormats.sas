Proc Sort Data = OBData.CMA9_PCA(Keep = UniqueID Hierarchy Data_Element)
	Out = Work.FMT  Nodupkey;
	By Hierarchy;
Run;

Data Work.FMT;
	Set Work.FMT;
	Start = UniqueID;
	End = Start;
	Label = Data_Element;
	Type = 'C';
	FMTName = 'PCAFMT';
Run;

proc format library=work cntlin=fmt;
Quit;

Options FMTSearch=(FMT);

Data Work.Test;
	Length UniqueID $ 160.;
	Set Work.Nodup_cma9_pca;
	UniqueFMT = UniqueID;
	UniqueID = Put(UniqueID,$PCAFMT.);
	Format UniqueFMT $PCAFMT.;
run;
