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
		*--- Closing Time ---;
		If Hierarchy = 'data-Brand-Branch-Availability-NonStandardAvailability-Day-OpeningHours-ClosingTime' Then Data_Element = 'NonStandardClosingTime';
		If Hierarchy = 'data-Brand-Branch-Availability-StandardAvailability-Day-OpeningHours-ClosingTime' Then Data_Element = 'StandardClosingTime';
		*--- Day ---;
		If Hierarchy = 'data-Brand-Branch-Availability-NonStandardAvailability-Day' Then Data_Element = 'NonStandardAvailabilityDay';
		If Hierarchy = 'data-Brand-Branch-Availability-StandardAvailability-Day' Then Data_Element = 'StandardAvailabilityDay';
		*--- Description ---;
		If Hierarchy = 'data-Brand-Branch-ContactInfo-OtherContactType-Description' Then Data_Element = 'OtherContactTypeDesc';
		If Hierarchy = 'data-Brand-Branch-OtherServiceAndFacility-Description' Then Data_Element = 'OtherServiceFacilityDesc';
		*--- Name ---;
		If Hierarchy = 'data-Brand-Branch-Availability-NonStandardAvailability-Day-Name' Then Data_Element = 'NonStandardDayName';
		If Hierarchy = 'data-Brand-Branch-Availability-NonStandardAvailability-Name' Then Data_Element = 'NonStandardName';
		If Hierarchy = 'data-Brand-Branch-Availability-StandardAvailability-Day-Name' Then Data_Element = 'StandardDayName';
		If Hierarchy = 'data-Brand-Branch-ContactInfo-OtherContactType-Name' Then Data_Element = 'OtherContactTypeName';
		If Hierarchy = 'data-Brand-Branch-Name' Then Data_Element = 'BranchName';
		If Hierarchy = 'data-Brand-Branch-OtherServiceAndFacility-Name' Then Data_Element = 'OtherServiceFacilityName';
		*--- Name ---;
		If Hierarchy = 'data-Brand-Branch-Availability-NonStandardAvailability-Notes' Then Data_Element = 'NonStandardNotes';
		If Hierarchy = 'data-Brand-Branch-Availability-StandardAvailability-Day-Notes' Then Data_Element = 'StandardDayNotes';
		*--- Notes ---;
		If Hierarchy = 'data-Brand-Branch-Availability-NonStandardAvailability-Notes' Then Data_Element = 'NonStandardAvailabilityNotes';
		If Hierarchy = 'data-Brand-Branch-Availability-StandardAvailability-Day-Notes' Then Data_Element = 'StandardAvailabilityDayNotes';
		*--- OpeningHours ---;
		If Hierarchy = 'data-Brand-Branch-Availability-NonStandardAvailability-Day-OpeningHours' Then Data_Element = 'NonStandardDayOpeningHours';
		If Hierarchy = 'data-Brand-Branch-Availability-StandardAvailability-Day-OpeningHours' Then Data_Element = 'StandardDayOpeningHours';
		*--- OpeningTime ---;
		If Hierarchy = 'data-Brand-Branch-Availability-NonStandardAvailability-Day-OpeningHours-OpeningTime' Then Data_Element = 'NonStandardDayOpeningTime';
		If Hierarchy = 'data-Brand-Branch-Availability-StandardAvailability-Day-OpeningHours-OpeningTime' Then Data_Element = 'StandardDayOpeningTime';
	Count = 1;
Run;

	Proc Summary Data = Work.X_03_nodup Nway Missing;
		Class Data_Element Hierarchy;
		Var Count;
		Output Out = Work.X_04_nodup(Drop = _TYpe_ _Freq_)Sum=;
	Run;
