%Global _APINamme;
Options MPrint MLogic Source Source2 Symbolgen;

%Macro Main(API_DSN,File);

Libname OBData "C:\inetpub\wwwroot\sasweb\Data\Temp";

*--- The Main macro will execute the code to extract data from the API end points ---;
%Macro Schema(Url,JSON,API_SCH);
*--- Set a temporary file name to extract the content of the Schema JSON file into ---;
Filename API Temp;
 
*--- Proc HTTP assigns the GET method in the URL to access the data contained within the Schema ---;
Proc HTTP
	Url = "&Url."
 	Method = "GET" Verbose
 	Out = API;
Run;
 
*--- The JSON engine will extract the data from the JSON script ---; 
Libname LibAPIs JSON Fileref=API;

*--- Proc datasets will create the datasets to examine resulting tables and structures ---;
Proc Datasets Lib = LibAPIs; 
Quit;

*--- Capture any error codes at this point, specifically if the Schema file did no load ---;
%If &SYSERR > 0 %Then
%Do;
	%Let SYSTEM_ERROR = &SYSERR;
%End;

*--- Create the Bank Schema dataset ---;
Data Work.&JSON;
	Set LibAPIs.Alldata(Where=(V NE 0));
Run;




*--- Sort the Bank Schema file ---;
Proc Sort Data = Work.&JSON
	Out = Work.H_Num;
	By Descending P;
Run;

Data Work._Null_;
*--- The variable V contains the first level of the Hierarchy which has no Bank information ---;
*--- Keep only the highest value of P which will be used in the macro variable H_Num ---;
	Set Work.H_Num(Obs=1 Keep = P);
*--- Create a macro variable H_Num to store the hiighest number of Hierarchical levels which will be used in code iterations ---;
	Call Symput('H_Num', Compress(Put(P,3.)));
Run;

Data Work.&JSON
	(Rename=(Var3 = Data_Element Var2 = Hierarchy)) Work.X1;

	Length Bank_API $ 8 Var2 $ 1000 Var3 $ 1000 P1 - P&H_Num $ 1000 Value $ 1000;

	RowCnt = _N_;

	Set Work.&JSON;

*--- Create Array concatenate variables P1 to P7 which will create the Hierarchy ---;
	Array Cat{&H_Num} P1 - P&H_Num;

*--- The Do-Loop will create the Hierarchy of Level 1 to 7 (P1 - P7) ---;
	If P = 1 Then
	Do;
		Do i = 1 to P;
	*--- If it is the first data field then do ---;
			Var2 = Trim(Left(Cat{i}));
			Count = i;
		End;
	End;

	If P > 1 then
	Do;
		Do i = 1 to P-1;
			If i = 1 Then 
			Do;
	*--- If it is the first data field then do ---;
				Var2 = Trim(Left(Cat{i}));
				Count = i;
			End;
			Else If i > 1 Then
			Do;
				Var2 = Trim(Left(Var2))||'-'||Trim(Left(Cat{i}));
				Count = i;
			End;
		End;
	End;

	*--- Create variable to list the API value i.e. ATM or Branches ---;
	Bank_API = "Schema";

*--- Extract only the last level of the Hierarchy ---;
	Var3 = Left(Trim(Var2));
Run;


Data Work.&JSON Work.X2;
	Set Work.&JSON;

	Length New_Data_Element1 $ 1000;

	If Reverse(Scan(Reverse(Trim(Left(Data_Element))),1,'-')) = 'required' then Flag = 'Mandatory';
	Else Flag = 'Optional';

	Array Col{&H_Num} P1 - P&H_Num;

	Do i = 1 to P;

		If i = P then
		Do;
			New_Data_Element = Compress(Trim(Left(Data_Element))||'-'||Trim(Left(Col{i})));
*--- Remove properties- from the Data_Element variable ---;
			New_Data_Element1 = Trim(Left(Tranwrd(New_Data_Element,'properties-','')));
/*			New_Data_Element2 = Trim(Left(Tranwrd(New_Data_Element1,'items-','')));*/
*--- Remove items- from the Data_Element variable ---;
/*			New_Data_Element = New_Data_Element2;*/
		End;

	End;

/*	Data_Element = Compress(Tranwrd(Tranwrd(Tranwrd(Tranwrd(Tranwrd(Tranwrd(Hierarchy,'data-',''),'properties-',''),'-enum',''),'-items',''),'-required',''),'items-',''));*/

	Data_Element = Compress(Tranwrd(Tranwrd(Tranwrd(Tranwrd(Tranwrd(Hierarchy,'data-',''),'properties-',''),'-enum',''),'-items',''),'-required',''));

Run;


Data Work.&JSON Work.X3(Drop = Word New_Word1 New_Word2 New_Data_Element3 New_Data_Element4 New_Data_Element6);
	Set Work.&JSON;

	Length New_Data_Element1 New_Data_Element2 New_Data_Element3 New_Data_Element4 New_Data_Element6 $ 1000;

	New_Data_Element2 = Reverse(Reverse(Trim(Left(New_Data_Element1))));
	New_Data_Element3 = Reverse(Scan(Reverse(Trim(Left(New_Data_Element1))),2,'-'));

	If New_Data_Element3 NE 'items' Then
	Do;
		New_Data_Element4 = Compress(Tranwrd(Tranwrd(Tranwrd(Tranwrd(Tranwrd(Tranwrd(Hierarchy,'data-',''),'properties-',''),'-enum',''),'-items',''),'-required',''),'items-',''));
		Hierarchy = New_Data_Element4;
	End;
	Else If New_Data_Element3 EQ 'items' Then
	Do;
/*		New_Data_Element5 = Scan(Trim(Left(Reverse(New_Data_Element2))),1,'-');*/
		NWords = CountW(New_Data_Element2,'-');
		Length New_Word1 New_Word2 $ 1000;
		Do i = 1 to NWords-2;
			If i = 1 Then
			Do;
      			Word = Compress(Trim(Left(Scan(New_Data_Element2,i,'-'))));
				New_Word1 = Compress(Tranwrd(Word,'items-',''));
			End;
			Else Do;
      			Word = Compress(Trim(Left(Scan(New_Data_Element2,i,'-'))));
				New_Word1 = Compress(Tranwrd(Compress(Trim(Left(New_Word1))||'-'||Word),'items-',''));
			End;
		End;


		Do i = NWords-1 to NWords;
      		Word = Compress(Trim(Left(Scan(New_Data_Element2,i,'-'))));
			New_Word2 = Compress(Compress(Trim(Left(New_Word2))||'-'||Word));
		End;

		New_Data_Element6 = Compress(New_Word1||New_Word2);
		Hierarchy = New_Data_Element6;

	End;

Run;

Proc Sort Data = Work.&JSON
	Out = Work.&JSON;
	By Hierarchy;
Run;



Data Work.&JSON/*(Drop=Hierarchy Rename=(Data_Element_1 = Hierarchy))*/ Work.X4;
	Set Work.&JSON;
	By Hierarchy;

	Length Data_Element_1 $ 1000;

	If First.Hierarchy then
	Do;
		Count = 1;
		Attribute = Reverse(Scan(Reverse(Hierarchy),1,'-'));

*--- In some instances the Hierarchy value ends with - then the first word in blank. Look then for the second word to populate the variable Attribute---;
		If Reverse(Scan(Reverse(Hierarchy),1,'-')) = '' Then
		Do;
			Attribute = Reverse(Scan(Reverse(Hierarchy),2,'-'));
		End;
/*
		If Attribute = 'required' then 
		Do;
			Hierarchy_1 = Compress(Tranwrd(Hierarchy,'required',Value));
			Data_Element_1 = Compress(Data_Element||'-'||Value);
		End;
		Else Do;
			Data_Element_1 = Data_Element;
		End;
*/
	End;
	If not First.Hierarchy then
	Do;
		Count + 1;
		Attribute = Reverse(Scan(Reverse(Hierarchy),1,'-'));

*--- In some instances the Hierarchy value ends with - then the first word in blank. Look then for the second word to populate the variable Attribute---;
		If Reverse(Scan(Reverse(Hierarchy),1,'-')) = '' Then
		Do;
			Attribute = Reverse(Scan(Reverse(Hierarchy),2,'-'));
		End;

/*
		If Attribute = 'required' then 
		Do;
			Hierarchy_1 = Compress(Tranwrd(Hierarchy,'required',Value));
			Data_Element_1 = Compress(Data_Element||'-'||Value);
		End;
		Else Do;
			Data_Element_1 = Data_Element;
		End;
*/
	End;

Run;


Proc Sort Data = Work.&JSON
	Out = Work.&JSON;
	By Hierarchy;
Run;


Data Work.&JSON Work.X5;
	Set Work.&JSON;

	By Hierarchy;

	Length Columns Columns1 $ 32 Value $ 1000;

*--- Create Mandatory flag ---;
/*If Attribute = 'required' then */
/*	Do;*/
/*		Columns = 'mandatory';*/
/*		New_Data_Element = Compress(Hierarchy||'-'||Columns); */
/*	End;*/

/*	If Attribute = 'enum' then */
/*	Do;*/
/*		Columns = Attribute;*/
/*	End;*/


	If Reverse(Scan(Reverse(Trim(Left(New_Data_Element))),1,'-')) in 
		('type','description','minLength','maxLength','notes','format','additionalProperties','title','uniqueItems','pattern','minItems','mandatory',
		'enum1','enum2','enum3','enum4','enum5','enum6','enum7','enum8','enum9','enum10',
		'enum11','enum12','enum13','enum14','enum15','enum16','enum17','enum18','enum19','enum20',
		'enum21','enum22','enum23','enum24','enum25','enum26','enum27','enum28','enum29','enum30',
		'enum31','enum32','enum33','enum34','enum35','enum36','enum37','enum38','enum39','enum40',
		'enum41','enum42','enum43','enum44','enum45','enum46','enum47','enum48','enum49','enum50',
		'enum51','enum52','enum53','enum54','enum55','enum56','enum57','enum58','enum59','enum60',
		'enum61','enum62','enum63','enum64','enum65','enum66','enum67','enum68','enum69','enum70',
		'enum71','enum72','enum73','enum74','enum75','enum76','enum77','enum78','enum79','enum80',
		'enum81','enum82','enum83','enum84','enum85','enum86','enum87','enum88','enum89','enum90',
		'enum91','enum92','enum93','enum94','enum95','enum96','enum97','enum98','enum99','enum100',
		'enum101','enum102','enum103','enum104','enum105','enum106','enum107','enum108','enum109','enum110','-enum-') then
	Do;
		Columns = Reverse(Scan(Reverse(New_Data_Element),1,'-'));
	End;

		If Reverse(Scan(Reverse(Trim(Left(Hierarchy))),1,'-')) in 
		('type','description','minLength','maxLength','notes','format','additionalProperties','title','uniqueItems','pattern','minItems','mandatory',
		'enum1','enum2','enum3','enum4','enum5','enum6','enum7','enum8','enum9','enum10',
		'enum11','enum12','enum13','enum14','enum15','enum16','enum17','enum18','enum19','enum20',
		'enum21','enum22','enum23','enum24','enum25','enum26','enum27','enum28','enum29','enum30',
		'enum31','enum32','enum33','enum34','enum35','enum36','enum37','enum38','enum39','enum40',
		'enum41','enum42','enum43','enum44','enum45','enum46','enum47','enum48','enum49','enum50',
		'enum51','enum52','enum53','enum54','enum55','enum56','enum57','enum58','enum59','enum60',
		'enum61','enum62','enum63','enum64','enum65','enum66','enum67','enum68','enum69','enum70',
		'enum71','enum72','enum73','enum74','enum75','enum76','enum77','enum78','enum79','enum80',
		'enum81','enum82','enum83','enum84','enum85','enum86','enum87','enum88','enum89','enum90',
		'enum91','enum92','enum93','enum94','enum95','enum96','enum97','enum98','enum99','enum100',
		'enum101','enum102','enum103','enum104','enum105','enum106','enum107','enum108','enum109','enum110','-enum-') then
	Do;
		Columns1 = Reverse(Scan(Reverse(Hierarchy),1,'-'));
		Columns = 'Items_'||Trim(Left(Columns1));
	End;


*--- Ensure that the Column variable has no blank spaces to avoide errors to avoide macro Variable_Name failure ---; 
	If Columns = '' then 
	Do;
		Columns = Attribute;
	End;
Run;


*--- Create Enum Counter (EnumCnt)to append to Columns variable values where Columns contain enum ---; 
Proc Sort Data = Work.&JSON
	Out = Work.&JSON;
	By Hierarchy Attribute;
Run;

Data Work.&JSON Work.X6;
	Set Work.&JSON;
	By Hierarchy Attribute;

	If Attribute = 'enum' then
	Do;
		EnumCnt + 1;
		Columns = Compress(Attribute||Put(EnumCnt,3.));
	End;
	Else Do;
		EnumCnt = 0;
	End;
Run;

*--- TBC ---;
Proc Sort Data = Work.&JSON
	Out = Work.&JSON;
	By Data_Element;
Run;

Data Work.&JSON._1 Work.X7;
	Set Work.&JSON;
	By Data_Element;

	If First.Data_Element then 
	Do;
		HierCnt + 1;
		Counter = 1;
	End;
	If not First.Data_Element then 
	Do;
		Counter + 1;
	End;
	Retain HierCnt;
Run;
/*
Data Work.&JSON._1 Work.X7;
	Set Work.&JSON;
	By Hierarchy;

	If First.Hierarchy then 
	Do;
		HierCnt + 1;
		Counter = 1;
	End;
	If not First.Hierarchy then 
	Do;
		Counter + 1;
	End;
	Retain HierCnt;
Run;
*/
Proc Sort Data = Work.&JSON._1
	Out = Work.&JSON._1;
	By HierCnt Counter;
Run;


%Macro VarVal();

*--- TBC ---;
Data Work.&JSON._2 Work.X8;
	Set Work.&JSON._1(Where=(Columns NE ''));
	By HierCnt Counter;

		Call Symput(Compress('Variable_Name'||'_'||Put(HierCnt,8.)||'_'||Put(Counter,8.)),Trim(Left(Columns)));
		Call Symput(Compress('Variable_Value'||'_'||Put(HierCnt,8.)||'_'||Put(Counter,8.)),Tranwrd(Trim(Left(Value)),'"',''));

/*		Call Symput(Compress('Variable_Value'||'_'||Put(HierCnt,8.)||'_'||Put(Counter,8.)),Trim(Left(Value)));*/

	If Last.HierCnt and Last.Counter then
	Do;

		Call Symput('HierCnt',Trim(Left(Put(HierCnt,6.))));
		Call Symput(Compress('Test'||'_'||Put(HierCnt,8.)),Trim(Left(Put(Counter,8.))));

	End;
Run;

%Put HierCnt = &HierCnt;
%Put ***;
%Put Test_HierCnt = &&Test_&HierCnt;
%Put ***;

%Put _ALL_;

	Data Work.Schema_Columns;
		Length Hierarchy $ 1000;
	Run;

%Do i = 1 %To %Eval(&HierCnt);

	%Put i = &i;

	Data Work.Unique_Columns&i;
		Length Hierarchy $ 1000  Description $ 1000;
		Set Work.&JSON._2(Where=(HierCnt = &i));
		By HierCnt Counter;

		If Last.HierCnt and Last.Counter;

		%Let Cnt = %Eval(&&Test_&i);
		%Put Cnt = &Cnt;

			%Do j = 1 %To &Cnt;
				%Put j = &j;

/**--- Set the length of the description variable to $1000, all other $250 else a runtime error is emcounterred ---;*/
/*				%If &&Variable_Name_&i._&j NE 'description' %Then*/
/*				%Do;*/
					Length &&Variable_Name_&i._&j  $ 250;
/*				%End;*/
/*				%Else %Do;*/
/*					Length &&Variable_Name_&i._&j  $ 1000;*/
/*				%End;*/
/*				%Let Varname = %Sysfunc(Translate(&&Variable_Name_&i._&j.,' ','_'));*/
				%Let Varname = &&Variable_Name_&i._&j.;

				&Varname = "&&Variable_Value_&i._&j.";
			%End;
	Run;


	Data Work.Schema_Columns
		/*(Keep = Hierarchy 
		Type
		Items
		Description
		minLength
		maxLength
		format
		additionalProperties
		title
		uniqueItems
		pattern
		minItems
		Flag
		enum1 - enum33
		Hierarchy1
		Table)*/ Work.X9;
		Length Table $ 16 Swagger_&API_DSN._Lev1 $ 1000;
		Set Work.Schema_Columns
			Work.Unique_Columns&i;

/*			Hierarchy = (Tranwrd(Trim(Left(Hierarchy)),'items-',''));*/

		If Hierarchy EQ '' then Delete;

/*		Hierarchy1 = Trim(Left(Substr(Hierarchy, index(Hierarchy, '-D') + 1)));*/
		Table  = 'Swagger_Sch';

		Swagger_&API_DSN._Lev1 = Hierarchy;
	Run;
%End;


	Proc Sort Data = Work.Schema_Columns
		Out = OBData.&API_SCH(Rename=(Hierarchy = Hierarchy_Full Data_Element = Hierarchy));
		By Hierarchy;
	Run;


%Mend VarVal;
%VarVal();


%Put _All_;





%Mend Schema;
%Schema(http://localhost/sasweb/data/temp/json/&File..json,&API_DSN,Swagger_BCA);



%Mend Main;
%Main(BCA,business_current_account);
