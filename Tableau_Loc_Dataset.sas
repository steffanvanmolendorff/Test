Libname Data "c:\inetpub\wwwroot\sasweb\data\perm";

Data Work.Latitude 
	Work.longitude
	Work.ATMID
	Work.PostCode;
	Set Data.CMA9_atm;
	If Data_Element = 'Latitude' Then 
	Do;
		Output Work.Latitude;
	End;

	If Data_Element = 'Longitude' Then 
	Do;
		Output Work.Longitude;
	End;

	If Data_Element = 'ATMID' Then 
	Do;
		Output Work.ATMID;
	End;

	If Data_Element = 'PostCode' Then 
	Do;
		Output Work.PostCode;
	End;

Run;

%Macro Location(Dsn);
Data Work.Lat_&Dsn(Keep = New_&Dsn 
	Counter
	Rename = (New_&Dsn = Lat_&Dsn));
	Set Work.Latitude;
	Counter + 1;
	New_&Dsn = Put(Trim(Left(&Dsn)),14.);
	Drop &Dsn;
Run;

Data Work.Lon_&Dsn(Keep = New_&Dsn 
	Counter
	Rename = (New_&Dsn = Lon_&Dsn));
	Set Work.Longitude;
	Counter + 1;
	New_&Dsn = Put(Trim(Left(&Dsn)),14.);
	Drop &Dsn;
Run;

Data Work.ID_&Dsn(Keep = Counter &Dsn
	Rename = (&Dsn = ID_&Dsn));
	Set Work.ATMID;
	Counter + 1;
Run;

Data Work.PC_&Dsn(Keep = Counter &Dsn
	Rename = (&Dsn = PC_&Dsn));
	Set Work.PostCode;
	Counter + 1;
Run;


Data Data.Loc_&Dsn;
	Merge Work.Lat_&Dsn
	Work.Lon_&Dsn
	Work.PC_&Dsn
	Work.ID_&Dsn;
	Bank = "&Dsn";
	By Counter;
Run;
%Mend Location;
%Location(Bank_of_Ireland);
%Location(HSBC);

Data Data.AAA_Location;
	Set Data.Loc_Bank_of_Ireland
	Data.Loc_HSBC;
Run;
