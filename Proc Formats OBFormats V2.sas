	Proc Sort Data = Work.X4_NoDUP 
		Out = Work.X4_NoDUP1;
		By Data_Element;
		
	Run;

	Data work.X4_NoDUP1;
		set Work.X4_NoDUP1;
		Count=1;
	Run;

	Proc Summary Data = Work.X4_NoDUP1 Nway Missing;
		Class Data_Element Hierarchy;
		Var Count;
		OutPut Out = SumX4(Drop=_Type_ _Freq_)Sum=;
	Run;
