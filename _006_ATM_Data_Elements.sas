	Proc Sort Data = Work.X_01(Keep=Hierarchy Data_Element) 
		Out = Work.X_01_Nodup NoDupKey;
		By Hierarchy Data_Element;
	Run;

	Proc Sort Data = Work.X_01_nodup(Keep=Hierarchy Data_Element) 
		Out = Work.X_02_nodup;
		By Data_Element;
	Run;

Data Work.X_03_nodup;
	Set Work.X_02_nodup;
		*--- Code ---;
		If Hierarchy = 'data-Brand-ATM-Location-OtherLocationCategory-Code' Then Data_Element = 'OtherLocationCategoryCode';
		If Hierarchy = 'data-Brand-ATM-OtherAccessibility-Code' Then Data_Element = 'OtherAccessibilityCode';
		*--- Description ---;
		If Hierarchy = 'data-Brand-ATM-Location-OtherLocationCategory-Description' Then Data_Element = 'OtherLocationCategoryDesc';
		If Hierarchy = 'data-Brand-ATM-OtherATMServices-Description' Then Data_Element = 'OtherATMServicesDesc';
		If Hierarchy = 'data-Brand-ATM-OtherAccessibility-Description' Then Data_Element = 'OtherAccessibilityDesc';
		*--- Identification ---;
		If Hierarchy = 'data-Brand-ATM-Branch-Identification' Then Data_Element = 'BranchIdentification';
		If Hierarchy = 'data-Brand-ATM-Identification' Then Data_Element = 'ATMIdentification';
		If Hierarchy = 'data-Brand-ATM-Location-Site-Identification' Then Data_Element = 'LocationSiteIdentification';
		*--- Name ---;
		If Hierarchy = 'data-Brand-ATM-Location-OtherLocationCategory-Name' Then Data_Element = 'OtherLocationCategoryName';
		If Hierarchy = 'data-Brand-ATM-Location-Site-Name' Then Data_Element = 'LocationSiteName';
		If Hierarchy = 'data-Brand-ATM-OtherATMServices-Name' Then Data_Element = 'OtherATMServicesName';
		If Hierarchy = 'data-Brand-ATM-OtherAccessibility-Name' Then Data_Element = 'OtherAccessibilityName';
	Count = 1;
Run;

	Proc Summary Data = Work.X_03_nodup Nway Missing;
		Class Data_Element Hierarchy;
		Var Count;
		Output Out = Work.X_04_nodup(Drop = _TYpe_ _Freq_)Sum=;
	Run;
