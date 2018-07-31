Options MPrint MLogic Symbolgen Source Source2;

*--- Assign Permanent library path to save perm datasets ---;
Libname OBData "C:\inetpub\wwwroot\sasweb\data\perm";

*--- Assign Global macro variables to use in the scripts below ---;
%Global Start;
%Global ATM_Data_Element_Total;
%Global BCH_Data_Element_Total;
%Global BCA_Data_Element_Total;
%Global PCA_Data_Element_Total;
%Global CCC_Data_Element_Total;
%Global SME_Data_Element_Total;

%Global ATM_UniqueID_Total;
%Global BCH_UniqueID_Total;
%Global BCA_UniqueID_Total;
%Global PCA_UniqueID_Total;
%Global CCC_UniqueID_Total;
%Global SME_UniqueID_Total;

%Global DataSetName;

*--- Assign Global maro variables to save total number of banks per product type ---;
%Global ATM_Bank_Name_Total;
%Global BCH_Bank_Name_Total;
%Global BCA_Bank_Name_Total;
%Global PCA_Bank_Name_Total;
%Global CCC_Bank_Name_Total;
%Global SME_Bank_Name_Total;

*--- Main Macro that wraps all the code ---;
%Macro Main();

*--- Uncomment this line to run program locally ---;

%Global _APIVisual;
%Let _APIVisual = BCA;
%Put _APIVisual = &_APIVisual;

*--- Assign Global Macro variables for storing data values and process in other data/proc steps ---;
%Macro Global_Banks(API);
*--- Create Global macro variables to save the bank names in each macro variable ---;
*--- If the number of banks increase to more than 20 the Do Loop To value must also be increased ---;
*--- Current bankk name count = 13 ---;
%Do i = 1 %To 20;
	%Global &API._Bank_Name&i;
%End;
*--- Create Global macro variables to save the data_elements values within each banks ---;
*--- If the number of banks increase to more than 20 the Do Loop To value must also be increased ---;
*--- Current max data_element count per bank is = 175 ---;
%Do i = 1 %To 280;
	%Global &API._Data_Element&i;
%End;
*--- Create Global macro variables to save the data_elements values within each banks ---;
*--- If the number of banks increase to more than 20 the Do Loop To value must also be increased ---;
*--- Current max data_element count per bank is = 175 ---;
%Do i = 1 %To 280;
	%Global &API._UniqueID&i;
%End;

%Mend Global_Banks;
%Global_Banks(ATM);
%Global_Banks(BCH);
%Global_Banks(BCA);
%Global_Banks(PCA);
%Global_Banks(CCC);
%Global_Banks(SME);

%Macro APIs(API_Dsn,API);

*--- Get a unique list of data elements per Open Data product type ---;
Proc Summary Data = &API_Dsn Nway Missing;
	Class Data_Element;
	Var Count;
	Output Out = Work.Data_Elements(Drop=_type_ _Freq_) Sum=;
Run;
/*
*--- Get a unique list of UniqueIDs per Open Data product type ---;
Proc Summary Data = &API_Dsn Nway Missing;
	Class UniqueID;
	Var Count;
	Output Out = Work.UniqueIDs(Drop=_type_ _Freq_) Sum=;
Run;
*/
*--- Change the length of some values as they will be transposed into variables ---;
*--- Dataset variables has a max length of 32 characters ---;
Data Work.Data_Elements;
	Set Work.Data_Elements;
	If Length(Data_Element) > 32 Then
	Do;
		Data_Element = Compress(Substr(Data_Element,1,29)||Put(_N_,3.));
	End;

*--- Test if the Data_Element only contains numeric values ---;
*--- If it does then (i.e. = 0) then concatenate an underscore to the values ---;
*--- Because the program below will create a dataset for each value ---;
*--- If the value is only numbers the program will create an Error and stop executing ---;
	If Verify(Trim(Left(Data_Element)),"1234567890") = 0 Then
	Do;
		Data_Element = '_'||Data_Element;
	End;
Run;

*--- Create a dataset with only the Bank names in the tables ---;
Proc Contents Data = &API_Dsn
	(Drop = Hierarchy Bank_API Data_Element /*UniqueID*/ Rowcnt P Count) Noprint
     out = Work.Names(keep = Name Rename=(Name=Bank_Name));
Run;
Quit;

*--- Only keep the Bank names in the dataset ---;
Data Work.Names;
	Set Work.Names;
	If Length(Bank_Name) < 3 or Substr(Bank_Name,1,1) = '_' or 
	Bank_Name EQ 'Bank_Name' then delete;
Run;


*--- The LiastAll macro will list all the Bank_Names and Data_Element names and save into the Global 
	Macro variables created in rows 7-22 ---;
%Macro ListAll(_Start);
*--- List the actual Bank value and save in Macrio variabe ---;
	&_Var = "&_Start";
*--- Save the API product name in the API_Count variable ---;
	API = "&API";
*--- Save the current i = (1,2,3,etc) value ---;
	&API._Count = &i;
	&API._Total = &Count;
	_Record_ID = &_Record_ID;
	_MarkStateID = &_MarkStateID;
	_SegmentID = &_SegmentID;
	*--- Save all the Bank_Names and Data_Elements names in the macro variables created in rows 32 to 40 ---;
	Call Symput(Compress("&API"||'_'||"&_Var"||Put(&i,3.)),"&_Start");
*--- Save the total counts of Bank_Names and Data_Element names in Macro variabe ---;
	Call Symput(Compress("&API"||'_'||"&_Var"||'_'||"Total"),Put(&API._Total,3.));
%Mend;

*--- The Banks macro list all the unique values for Bank, Data_Element, 
	_Record_ID, &_MarkStateID ---;
%Macro Banks(_Dsn,_Var);
/*
%If "&_Var" EQ "Data_Element" %Then
%Do;
	*--- The UniqueValues macro Proc Sort creates the unique values datasets for each variable ---;
	%Macro UniqueValues(_DsnVal,_VarVal);
	Proc Sort Data = &_DsnVal 
		Out = &API._&_VarVal NoDupKey;
		By &_VarVal;
	Run;
	%Mend UniqueValues;
	*--- This macro calls the Data_Elements variable ---;
	%UniqueValues(&_Dsn,Data_Element);
	*--- This macro calls the _Record_ID variable ---;
	%UniqueValues(&_Dsn,_Record_ID);
	*--- This macro calls the _MarkStateID variable ---;
	%UniqueValues(&_Dsn,_MarkStateID);
%End;
*/

Data Work.&API._&_Var;
*--- Set variable lengths to 32 characters, API value to length 3 and Total to numeric 3 ---; 
	Length Hierarchy $ 160 &_VAR $ 32 API $ 3 _Record_ID 6 _MarkStateID _SegmentID 6 
	&API._Count &API._Total 3;

				*--- Read Dataset UniqueNames ---;
				 	%Let Dsn = %Sysfunc(Open(&_Dsn));
					%Put Dsn = &Dsn;
				*--- Count Observations ---;
				    %Let Count = %Sysfunc(Attrn(&Dsn,Nobs));
					%Put Count = &Count;

				*--- Count number of products (_Records_ID) ---;
				    %Let _Record_ID = %Sysfunc(Attrn(&Dsn,_Record_ID));
					%Put _Record_ID = &_Record_ID;
				*--- Count number of MarketingsStates per product (_MarkStateID) ---;
				    %Let _MarkStateID = %Sysfunc(Attrn(&Dsn,_MarkStateID));
					%Put _MarkStateID = &_MarkStateID;
				*--- Count number of MarketingsStates per product (_MarkStateID) ---;
				    %Let _SegmentID = %Sysfunc(Attrn(&Dsn,_SegmentID));
					%Put _SegmentID = &_SegmentID;

				*--- Loop through the steps from 1 to Count value ---;
				    %Do i = 1 %To &Count;
					%Put i = &i;
					
				        %Let Rc = %Sysfunc(fetch(&Dsn,&i));
				        %Let Start=%Sysfunc(GETVARC(&Dsn,%Sysfunc(VARNUM(&Dsn,&_Var))));
				*--- Call macro ListAll to save Bank_Names and Data_Element values and output to tables ---;
						%ListAll(&Start);
						Output;
				    %End;

				    %Let Rc = %Sysfunc(Close(&Dsn));
Run;
*--- This Code resolves the Macro Variables for testing purposes ---;
/*
%Put _All_;
%Macro Test;
%Do i = 1 %To &&&API._&_Var._Total;
	Data Work.&API._&_Var.&i;
		&API._Total = &&&API._&_Var._Total;
		&API._&_Var. = "&&&API._&_Var.&i";
		Output;
	Run;
%End;

%Mend;
%Test;
*/


%Macro Split_Banks(Dsn);
*--- Sort Dataset by RowCnt variable and output to each Data_Element dataset ---;
Proc Sort Data=&API_Dsn
	Out = &Dsn(Keep = Data_Element Hierarchy RowCnt /*UniqueID*/ _Record_ID 
	_MarkStateID _SegmentID Count Bank_Name &Dsn);
	By RowCnt;
Run;
%Mend Split_Banks;
*--- &_Var resolves to either Bank_Name or Data_Element ---;
*--- If _Var = Bank_Name then execute the %Split_Banks macro ---;
%If "&_Var" = "Bank_Name" %Then
%Do;
	%Do i = 1 %To &&&API._Bank_Name_Total;
		%Split_Banks(&&&API._Bank_Name&i);
	%End;
%End;

%Macro Split_Values(_Value);
*--- List all Data_Element values in the log to verify the values are accurately 
	populated in the macro variables ---;
	%Put Value = &_Value;
%Mend Split_Values;
*--- &_Var resolves to either Bank_Name or Data_Element ---;
*--- If _Var = Data_Element then execute the %Split_Values macro ---;
%If "&_Var" = "Data_Element" %Then
%Do;
	%Do j = 1 %To &&&API._Data_Element_Total;
		%Split_Values(&&&API._Data_Element&j);
	%End;
%End;
/*
%Macro Split_UniqueID(_Value);
*--- List all Data_Element values in the log to verify the values are accurately 
	populated in the macro variables ---;
	%Put Value = &_Value;
%Mend Split_UniqueID;
*--- &_Var resolves to either Bank_Name or Data_Element ---;
*--- If _Var = Data_Element then execute the %Split_Values macro ---;
%If "&_Var" = "UniqueID" %Then
%Do;
	%Do j = 1 %To &&&API._UniqueID_Total;
		%Split_UniqueID(&&&API._UniqueID&j);
	%End;
%End;
*/

%Put _ALL_;

%Mend Banks;
*--- Execute the macro to run the data on the Bank_Names values ---;
%Banks(Work.Names,Bank_Name);
*--- Execute the macro to run the data on the Data_Element values ---;
%Banks(Work.Data_Elements,Data_Element);
*--- Execute the macro to run the data on the _UniqueID values ---;
/*%Banks(Work.UniqueIDs,UniqueID);*/


*--- Split API Banks data into Data_Element tables ---;
%Do k = 1 %To &&&API._Bank_Name_Total;
		%Do l = 1 %To &&&API._Data_Element_Total;
			Data Work.&&&API._Data_Element&l(Keep = Bank Data_Element Hierarchy RowCnt 
			_Record_ID Count _MarkStateID _SegmentID Count &&&API._Data_Element&l);
				Set &&&API._Bank_Name&k(Where=(Data_Element = "&&&API._Data_Element&l"
					and Bank_Name = %sysfunc(Tranwrd("&&&API._Bank_Name&k",'_',''))));
			*--- Create a API_Count variable per product type ---;
					&API._Count = Count;
			*--- Create the Record ID field to use in the merge of all data_element datasets ---;
					_Record_ID = _Record_ID;
			*--- Create the _MarkSTATEID field to use in the merge of all data_element datasets ---;
					_MarkStateID = _MarkStateID;
			*--- Create the _SEGMENTID field to use in the merge of all data_element datasets ---;
					_SegmentID = _SegmentID;
			*--- Save the Bank_Name in the Data_Element variable name to list the Bank_Name as a row ---;
					&&&API._Data_Element&l = &&&API._Bank_Name&k;
			*--- Save the Bank_Name value in the column Bank ---;
					Bank = Tranwrd("&&&API._Bank_Name&k",'_','');
			*--- Create a dataset for each Data_Element value i.e. transposing the data ---;
					Output Work.&&&API._Data_Element&l;
			Run;
*--- Sort output datasets before it is merged in the next steps below ---;
			Proc Sort Data = Work.&&&API._Data_Element&l;
				By _Record_ID _MarkStateID _SegmentID;
			Run;

		%End;


			*--- Merge all datasets to create one dataset with all the values ---;
		Data Work.&&&API._Bank_Name&k;
			Merge 
			%Do l = 1 %To &&&API._Data_Element_Total;
				Work.&&&API._Data_Element&l
			%End;
			;
			By _Record_ID _MarkStateID _SegmentID;
		Run;
%End;

/*
*--- Split API Banks data into Data_Element tables ---;
%Do k = 1 %To &&&API._Bank_Name_Total;
		%Do l = 1 %To &&&API._UniqueID_Total;
			Data Work.&&&API._UniqueID&l(Keep = Bank UniqueID Hierarchy RowCnt _Record_ID _MarkStateID 
					Count &&&API._UniqueID&l);
				Set &&&API._Bank_Name&k(Where=(UniqueID = "&&&API._UniqueID&l"));
			*--- Create a API_Count variable per product type ---;
					&API._Count = Count;
			*--- Create the Record ID field to use in the merge of all data_element datasets ---;
					_Record_ID = _Record_ID;
			*--- Create the _MarkSTATEID field to use in the merge of all data_element datasets ---;
					_MarkStateID = _MarkStateID;
			*--- Save the Bank_Name in the Data_Element variable name to list the Bank_Name as a row ---;
					&&&API._UniqueID&l = &&&API._Bank_Name&k;
			*--- Save the Bank_Name value in the column Bank ---;
					Bank = Tranwrd("&&&API._Bank_Name&k",'_','');
			*--- Create a dataset for each Data_Element value i.e. transposing the data ---;
					Output Work.&&&API._UniqueID&l;
			Run;
		%End;

			*--- Merge all UniqieID datasets to create one dataset with all the values ---;
		Data Work.&&&API._Bank_Name&k;
			Merge 
			%Do l = 1 %To &&&API._UniqueID_Total;
				Work.&&&API._UniqueID&l
			%End;
			;
			By _Record_ID _MarkStateID;
		Run;
%End;
*/
*--- Concatenate datasets to output to perm library OBData.API_Geographic ---;
%Let Datasets =;
%Macro API_Concat(DsName);
%If %Sysfunc(exist(&DsName)) %Then
%Do;
	%Let DSNX = &DsName;
	%Put DSNX = &DSNX;

	%Let Datasets = &Datasets &DSNX;
	%Put Datasets = &Datasets;
%End;
%Mend API_Concat;
%Do k = 1 %To &&&API._Bank_Name_Total;
	%API_Concat(&&&API._Bank_Name&k)
%End;

*--- Create the OBData.&API_Geographic datasets ---;
Data OBData.&API._Geographic1;
	Set &Datasets;
	Record_Count = 1;
Run;
*--- Execute the macro for all API product types ---;
%Mend APIs;
%If "&_APIVisual" = "ATM" %Then
%Do;
	%APIs(OBData.CMA9_ATM,ATM);
%End;

%If "&_APIVisual" = "BCH" %Then
%Do;
	%APIs(OBData.CMA9_BCH,BCH);
%End;

%If "&_APIVisual" = "BCA" %Then
%Do;
	%APIs(OBData.CMA9_BCA,BCA);
%End;

%If "&_APIVisual" = "PCA" %Then
%Do;
	%APIs(OBData.CMA9_PCA,PCA);
%End;

%If "&_APIVisual" = "CCC" %Then
%Do;
	%APIs(OBData.CMA9_CCC,CCC);
%End;

%If "&_APIVisual" = "SME" %Then
%Do;
	%APIs(OBData.CMA9_SME,SME);
%End;

%Mend Main;
%Main();


******************************************************************************************
*	OPEN DATA: BCA
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      29DEC17
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
******************************************************************************************;
*--- Assign Dataset Library ---; 
Libname OBData "C:\inetpub\wwwroot\sasweb\Data\Perm";

*--- Create Blank dataset and set variable lenghts ---;
Data WORK.BCA_TEST1;
	Input Hierarchy $300. 
		Data_Element $100. 
		RowCnt best12. 
		Count best12. 
		_Record_ID best12. 
		_MarkStateID best12. 
		_SegmentID best12. 
		AER $10. 
		Bank $25. 
		AgeEligibilityNotes1 $300. 
		Agreement $300. 
		AgreementLengthMax $10. 
		AgreementLengthMin $10. 
		AgreementPeriod $10. 
		AuthorisedIndicator $5. 
		BCAIdentification $20. 
		BCAMarketingStateIdentification $15. 
		BCAMarketingStateNotes1 $30. 
		BCAMarketingStateNotes2 $30. 
		BCAMarketingStateNotes3 $300. 
		BankGuaranteedIndicator $10. 
		BankInterestRate $10. 
		BankInterestRateType $10. 
		BenefitGroupNominalValue $10. 
		BrandBCAName $50. 
		BrandName $50. 
		BufferAmount $10. 
		CalculationMethod $20. 
		CardOtherTypeDesc $15. 
		ContactlessIndicator $5. 
		CoreProductNotes1 $300. 
		CoreProductTcsAndCsURL $300. 
		CreditCheckEligNotes1 $300. 
		CreditIntEligDesc $50. 
		CreditIntEligIndicator $5. 
		CreditIntEligName $100. 
		CreditIntEligOtherTypeDesc $50. 
		CreditIntEligOtherTypeName $30. 
		CreditIntEligPeriod $10. 
		CreditIntEligType $300. 
		CreditIntIndentification $50. 
		CreditIntTierbandSetMethod $15. 
		CreditInterestAmount $10. 
		DepositInterestAppliedCoverage $10. 
		Destination $15. 
		EAR $10. 
		EligOtherOfficerTypeCode $10. 
		EligibilityAmount $15. 
		FeatureBenEligIndicator $5. 
		FeatureBenEligNotes1 $500. 
		FeatureBenEligPeriod $10. 
		FeatureBenEligType $20. 
		FeatureBenGrpEligIndicator $50. 
		FeatureBenGrpEligName $30. 
		FeatureBenGrpEligPeriod $10. 
		FeatureBenGrpEligType $20. 
		FeatureBenGrpItemEligName $30. 
		FeatureBenGrpItemEligType $30. 
		FeatureBenGrpItemIndentification $5. 
		FeatureBenGrpItemIndicator $5. 
		FeatureBenGrpItemName $100. 
		FeatureBenGrpItemOtherTypeName $20. 
		FeatureBenGrpItemType $15. 
		FeatureBenGrpNotes1 $300. 
		FeatureBenGrpOtherTypeDesc $100. 
		FeatureBenGrpOtherTypeName $30. 
		FeatureBenGrpType $30. 
		FeatureBenItemEligDesc $100. 
		FeatureBenItemEligIndicator $50. 
		FeatureBenItemEligName $30. 
		FeatureBenItemEligNotes1 $10. 
		FeatureBenItemGrpOtherTypeDesc $100. 
		FeatureBenItemIndentification $30. 
		FeatureBenItemIndicator $300. 
		FeatureBenItemName $150. 
		FeatureBenItemNotes1 $500. 
		FeatureBenItemOtherTypeDesc $300. 
		FeatureBenItemTextual $300. 
		FeatureBenItemType $30. 
		FeatureBenOtherTypeName $50. 
		FeatureBenefitEligAmount $10. 
		FeatureBenefitGrpAppFreq $30. 
		FeatureBenefitGrpCalcFreq $10. 
		FeatureBenefitGrpEligDesc $150. 
		FeatureBenefitGrpItemAmount $10. 
		FeatureBenefitGrpItemEligAmount $10. 
		FeatureBenefitGrpName $30. 
		FeatureBenefitItemAmount $10. 
		FeatureBenefitItemEligAmount $10. 
		FeatureBenefitItemEligPeriod $10. 
		FeatureBenefitItemOtherTypeCode $10. 
		FeatureBenefitItemTextual $300. 
		FeaturesBenCardNotes1 $300. 
		FeaturesBenCardOtherTypeName $30. 
		FeaturesBenCardType $15. 
		Fee $10. 
		FeeCapOccurrence $10. 
		FeeChargeCapFeeType1 $50. 
		FeeChargeCapFeeType2 $50. 
		FeeChargeCapFeeType3 $50. 
		FeeChargeCapMinMaxType $10. 
		FeeChargeCapNotes $500. 
		FeeChargeCapOtherFeeTypeDesc $30. 
		FeeChargeCapOtherFeeTypeName $30. 
		FeeChargeCapPeriod $10. 
		FeeChargeDetailAppFreq $50. 
		FeeChargeDetailCalcFreq $50. 
		FeeChargeDetailFeeCategory $30. 
		FeeChargeDetailFeeRate $10. 
		FeeChargeDetailFeeRateType $30. 
		FeeChargeDetailFeeType $50. 
		FeeChargeDetailNotes1 $300. 
		FeeChargeDetailNotes2 $300. 
		FeeChargeDetailOtherFeeTypeDesc $300. 
		FeeChargeDetailOtherFeeTypeName $300. 
		FeeChargeNegotiableIndicator $5. 
		FeeType10 $30. 
		FeeType11 $30. 
		FeeType12 $30. 
		FeeType13 $30. 
		FeeType14 $30. 
		FeeType15 $30. 
		FeeType16 $30. 
		FeeType17 $30. 
		FeeType18 $30. 
		FeeType19 $30. 
		FeeType20 $30. 
		FeeType21 $30. 
		FeeType22 $30. 
		FeeType23 $30. 
		FeeType24 $30. 
		FeeType25 $30. 
		FeeType26 $30. 
		FeeType27 $30. 
		FeeType4 $30. 
		FeeType5 $30. 
		FeeType6 $30. 
		FeeType7 $30. 
		FeeType8 $30. 
		FeeType9 $30. 
		FirstMarketedDate $15. 
		FixedVariableInterestRateType $10. 
		IDEligNotes1 $300. 
		IncludedInMonthlyChargeIndicator $5. 
		LastMarketedDate $15. 
		LastUpdated $50. 
		LegalStructure $20. 
		LegalStructureEligNotes1 $100. 
		License $100. 
		MarketingState $10. 
		MaxAmount $10. 
		MaxDailyCardWithdrawalLimit $10. 
		MaximumAge $10. 
		MaximumAmount $10. 
		MinAmount $10. 
		MinimumAge $10. 
		MinimumAmount $10. 
		MinimumRate $10. 
		MobileWalletNotes1 $300. 
		MobileWalletType $15. 
		MonthlyCharge $10. 
		OfficerEligNotes1 $300. 
		OfficerEligOtherOfficerTypeName $20. 
		OfficerType $10. 
		OtherAppFreqDesc $30. 
		OtherCalcFreqDesc $30. 
		OtherEligIndicator $5. 
		OtherEligName $300. 
		OtherEligNotes1 $300. 
		OtherEligOtherTypeDesc $50. 
		OtherEligOtherTypeName $50. 
		OtherEligTextual $50. 
		OtherEligibilityDesc $300. 
		OtherEligibilityType $20. 
		OtherFeeTypeFeeCategory $20. 
		OtherFeesChargesAmount $10. 
		OtherFeesChargesDetailNotes3 $300. 
		OtherFeesChargesFeeCapAmount $10. 
		OtherLegalStructureDesc $30. 
		OtherLegalStructureName $30. 
		OtherOfficerTypeDesc $30. 
		OtherSICCodeDesc $10. 
		OtherSICCodeName $10. 
		OverdraftFeeCapAmount $10. 
		OverdraftFeeCapOccurrence $10. 
		OverdraftFeeChargeAppFreqDesc $20. 
		OverdraftFeeChargeCalcFreqDesc $30. 
		OverdraftFeeChargeCapFeeType2 $20. 
		OverdraftFeeChargeCapFeeType3 $20. 
		OverdraftFeeChargeCapMinMaxType $10. 
		OverdraftFeeChargeCapPeriod $10. 
		OverdraftFeeChargeDetailAppFreq $20. 
		OverdraftFeeChargeDetailCalcFreq $20. 
		OverdraftFeeChargeDetailFeeType $30. 
		OverdraftFeeChargeDetailNotes2 $20. 
		OverdraftFeeChargeNegIndicator $5. 
		OverdraftFeeChargeNotes1 $500. 
		OverdraftFeeOtherAppFreqName $30. 
		OverdraftFeeOtherCalcFreqName $30. 
		OverdraftFeesChargesAmount $10. 
		OverdraftFeesChargesFeeRate $10. 
		OverdraftFeesChargesFeeRateType $10. 
		OverdraftFeesChargesFeeType1 $30. 
		OverdraftFeesChargesIndicator $5. 
		OverdraftIdentification $20. 
		OverdraftInterestChargingCove198 $10. 
		OverdraftNotes $500. 
		OverdraftTcsAndCsURL $300. 
		OverdraftTierBandAmount $10. 
		OverdraftTierBandFeeRate $10. 
		OverdraftTierBandFeeRateType $10. 
		OverdraftTierBandFeeType1 $30. 
		OverdraftTierBandIdentification $20. 
		OverdraftTierbandNotes1 $300. 
		OverdraftTierBandSetFeeCapAmount $10. 
		OverdraftTierBandSetMethod $30. 
		OverdraftTierBandSetNotes1 $300. 
		OverdraftTierBandSetNotes2 $500. 
		OverdraftTierbandAppFreq $30. 
		OverdraftTierbandAppFreqName $20. 
		OverdraftTierbandCalcFreq $20. 
		OverdraftTierbandCalcFreqName $30. 
		OverdraftTierbandCapMinMaxType $20. 
		OverdraftTierbandCapPeriod $10. 
		OverdraftTierbandFeeType $30. 
		OverdraftTierbandIndicator $5. 
		OverdraftTierbandNegleIndicator $5. 
		OverdraftTierbandNotes2 $50. 
		OverdraftType $20. 
		PredecessorID $15. 
		ProductDescription $300. 
		ProductURL $300. 
		ResidencyEligNotes1 $50. 
		ResidencyIncluded1 $10. 
		ResidencyType $20. 
		SICCode1 $10. 
		SalesAccessChannels1 $30. 
		SalesAccessChannels2 $30. 
		SalesAccessChannels3 $30. 
		SalesAccessChannels4 $30. 
		SalesAccessChannels5 $30. 
		Scheme1 $20. 
		ScoringType $10. 
		Segment1 $20. 
		Segment2 $20. 
		Segment3 $20. 
		ServicingAccessChannels1 $20. 
		ServicingAccessChannels2 $20. 
		ServicingAccessChannels3 $20. 
		ServicingAccessChannels4 $20. 
		ServicingAccessChannels5 $20. 
		ServicingAccessChannels6 $20. 
		ServicingAccessChannels7 $20. 
		ServicingAccessChannels8 $20. 
		ServicingAccessChannels9 $20. 
		StateTenureLength $10. 
		StateTenurePeriod $10. 
		TariffName $20. 
		TariffType $20. 
		TermsOfUse $100. 
		TierBandAppFreq $10. 
		TierBandCalcFreq $10. 
		TierBandNotes1 $100. 
		TierBandSetNotes1 $20. 
		TierValueMax $30. 
		TierValueMaximum $30. 
		TierValueMin $30. 
		TierValueMinimum $30. 
		TotalResults $10. 
		TradingHistEligNotes1 $500. 
		TradingHistEligTextual $500. 
		TradingHistEligibIndicator $5. 
		TradingHistEligibMinMaxType $10. 
		TradingHistEligtPeriod $10. 
		TradingType $300. 
		URL $300. 
		Record_Count best12.;
	Datalines;
	;
Run;
*--- Write permanent dataset variable values to blank dataset with preset variable lengths ---;
Data OBData.BCA_Geographic1;
	Set Work.BCA_Test1
	OBData.BCA_Geographic1;
Run;


******************************************************************************************
*	OPEN DATA: PCA
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      29DEC17
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
******************************************************************************************;
*--- Create Blank dataset and set variable lenghts ---;
Data WORK.PCA_TEST1; 
	Input  Hierarchy $300. 
		 Data_Element $100. 
		 RowCnt best12. 
		 Count best12. 
		 _Record_ID best12. 
		 _MarkStateID best12. 
		 _SegmentID best12. 
		 AER $10. 
		 Bank $25. 
		 AgeEligibilityNotes1 $300. 
		 Agreement $300. 
		 Amount $10. 
		 ApplicationFrequency $15. 
		 AuthorisedIndicator $5. 
		 BankGuaranteedIndicator $5. 
		 BankInterestRateType $10. 
		 BenefitGroupNominalValue $10. 
		 BrandName $30. 
		 BufferAmount $10. 
		 CalculationFrequency $15. 
		 CalculationMethod $10. 
		 CappingPeriod $10. 
		 Code $5. 
		 ContactlessIndicator $5. 
		 CreditIntEligAmount $10. 
		 CreditIntEligDesc $100. 
		 CreditIntEligName $50. 
		 CreditIntEligPeriod $10. 
		 CreditInterestEligType $20. 
		 DepositInterestAppliedCoverage $10. 
		 Description $300. 
		 Destination $15. 
		 EAR $10. 
		 FeatBenefitGroupOtherDesc $20. 
		 FeatBenefitItemDesc $100. 
		 FeatBenefitItemOtherDesc $10. 
		 FeatureBenGroupIdentification $15. 
		 FeatureBenItemIdentification $15. 
		 FeatureBenefitEligAmount $10. 
		 FeatureBenefitEligIndicator $5. 
		 FeatureBenefitEligName $30. 
		 FeatureBenefitEligOtherName $30. 
		 FeatureBenefitEligPeriod $10. 
		 FeatureBenefitEligTextual $300. 
		 FeatureBenefitEligType $30. 
		 FeatureBenefitGrpItemType $30. 
		 FeatureBenefitGrpName $50. 
		 FeatureBenefitGrpNotes1 $50. 
		 FeatureBenefitGrpOtherName $50. 
		 FeatureBenefitGrpType $30. 
		 FeatureBenefitItemName $300. 
		 FeatureBenefitItemNotes1 $300. 
		 FeatureBenefitItemNotes2 $300. 
		 FeatureBenefitItemNotes3 $300. 
		 FeatureBenefitItemTextual $300. 
		 FeatureBenefitItemType $50. 
		 FeatureBenefitsCardNotes1 $300. 
		 FeaturesBenefitsCardType $15. 
		 FeeAmount $10. 
		 FeeCapAmount $10. 
		 FeeCapOccurrence $10. 
		 FeeChargeAmount $10. 
		 FeeChargeAppFreq $30. 
		 FeeChargeCalcFreq $30. 
		 FeeChargeCapNotes1 $300. 
		 FeeChargeDetailFeeType $50. 
		 FeeChargeDetailNotes1 $300. 
		 FeeChargeDetailNotes2 $300. 
		 FeeChargeDetailNotes3 $300. 
		 FeeChargeFeeCategory $15. 
		 FeeChargeOtherFeeCategory $15. 
		 FeeChargeOtherFeeTypeName $50. 
		 FeeChargeOtherTypeDesc $100. 
		 FeeMinMaxType $10. 
		 FeeRate $10. 
		 FeeRateType $20. 
		 FeeType $300. 
		 FeeType1 $30. 
		 FeeType2 $30. 
		 FeeType3 $30. 
		 FeeType4 $30. 
		 FeeType5 $30. 
		 FirstMarketedDate $10. 
		 FixedVariableInterestRateType $10. 
		 IncrementalBorrowingAmount $10. 
		 Indicator $5. 
		 LastMarketedDate $10. 
		 LastUpdated $30. 
		 License $300. 
		 MarkStateIdentification $15. 
		 MarketingState $15. 
		 MaximumAge $10. 
		 MaximumAmount $10. 
		 MinimumAge $10. 
		 MinimumAmount $10. 
		 MinimumRate $10. 
		 MobileWalletNotes1 $500. 
		 MobileWalletOtherDesc $100. 
		 MobileWalletOtherTypeName $50. 
		 MobileWalletType $20. 
		 MonthlyMaximumCharge $10. 
		 Name $30. 
		 Notes $500. 
		 Notes1 $300. 
		 Notes2 $100. 
		 Notes4 $100. 
		 OtherEligAmount $10. 
		 OtherEligDesc $300. 
		 OtherEligIndicator $5. 
		 OtherEligName $50. 
		 OtherEligType $30. 
		 OtherEligibilityNotes1 $300. 
		 OverDraftFeeChargeAppFreq $20. 
		 OverDraftFeeChargeCalcFreq $15. 
		 OverdraftControlIndicator $5. 
		 OverdraftFeeChargeAmount $10. 
		 OverdraftFeeChargeFeeType $30. 
		 OverdraftFeeChargeNotes1 $300. 
		 OverdraftIdentification $30. 
		 OverdraftInterestChargingCove112 $30. 
		 OverdraftTierBandIdentification $30. 
		 OverdraftTierBandSetMethod $10. 
		 OverdraftType $10. 
		 PCAIdentification $20. 
		 PCAMarketingStateNotes1 $500. 
		 Period $10. 
		 PredecessorID $10. 
		 ProductDescription $300. 
		 ProductName $60. 
		 ProductURL $300. 
		 ResidencyEligNotes1 $300. 
		 ResidencyIncluded1 $10. 
		 ResidencyIncluded2 $10. 
		 ResidencyIncluded3 $10. 
		 ResidencyIncluded4 $10. 
		 ResidencyIncluded5 $10. 
		 ResidencyIncluded6 $10. 
		 ResidencyIncluded7 $10. 
		 ResidencyIncluded8 $10. 
		 ResidencyType $15. 
		 SalesAccessChannels1 $15. 
		 SalesAccessChannels2 $15. 
		 SalesAccessChannels3 $15. 
		 SalesAccessChannels4 $30. 
		 Scheme $10. 
		 ScoringType $10. 
		 Segment1 $15. 
		 Segment2 $15. 
		 Segment3 $15. 
		 ServicingAccessChannels1 $20. 
		 ServicingAccessChannels2 $20. 
		 ServicingAccessChannels3 $20. 
		 ServicingAccessChannels4 $20. 
		 ServicingAccessChannels5 $20. 
		 ServicingAccessChannels6 $20. 
		 ServicingAccessChannels7 $20. 
		 ServicingAccessChannels8 $20. 
		 ServicingAccessChannels9 $20. 
		 StateTenureLength $10. 
		 StateTenurePeriod $10. 
		 TcsAndCsURL $300. 
		 TermsOfUse $300. 
		 Textual $300. 
		 TierBandIdentification $15. 
		 TierBandMethod $10. 
		 TierBandSetNotes1 $300. 
		 TierValueMax $15. 
		 TierValueMaximum $10. 
		 TierValueMin $15. 
		 TierValueMinimum $10. 
		 TotalResults $10. 
		 Type $15. 
		 URL $300. 
		 Record_Count best12.;
		Datalines;
		;
run;
*--- Write permanent dataset variable values to blank dataset with preset variable lengths ---;
Data OBData.PCA_Geographic1;
	Set Work.PCA_Test1
	OBData.PCA_Geographic1;
Run;

/*
******************************************************************************************
*	OPEN DATA: ATM
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      29DEC17
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
******************************************************************************************;
*--- Create Blank dataset and set variable lenghts ---;
 Data WORK.ATM_TEST1;
 	Input Data_Element $100. 
		RowCnt best12. 
		Count best12. 
		_Record_ID best12. 
		ATMServices1 $25. 
		Bank $25. 
		ATMServices10 $25. 
		ATMServices11 $25. 
		ATMServices2 $25. 
		ATMServices3 $25. 
		ATMServices4 $25. 
		ATMServices5 $25. 
		ATMServices6 $25. 
		ATMServices7 $25. 
		ATMServices8 $25. 
		ATMServices9 $25. 
		Access24HoursIndicator $10. 
		Accessibility1 $25. 
		Accessibility2 $25. 
		Accessibility3 $25. 
		Accessibility4 $25. 
		Accessibility5 $25. 
		Accessibility6 $25. 
		Accessibility7 $25. 
		AddressLine1 $50. 
		AddressLine2 $50. 
		AddressLine3 $50. 
		AddressLine4 $10. 
		Agreement $300. 
		BrandName $30. 
		BuildingNumber $30. 
		Code $10. 
		Country $3. 
		CountrySubDivision1 $50. 
		Description $100. 
		Identification $30. 
		LastUpdated $30. 
		Latitude $15. 
		License $100. 
		LocationCategory $25. 
		LocationCategory1 $25. 
		Longitude $15. 
		MinimumPossibleAmount $10. 
		Name $30. 
		Note $30. 
		PostCode $10. 
		StreetName $50. 
		SupportedCurrencies1 $3. 
		SupportedCurrencies2 $3. 
		SupportedLanguages1 $3. 
		SupportedLanguages2 $3. 
		SupportedLanguages3 $3. 
		SupportedLanguages4 $3. 
		SupportedLanguages5 $3. 
		TermsOfUse $100. 
		TotalResults $10. 
		TownName $50. 
		Record_Count best12. ;
		Datalines;
;
Run;
*--- Write permanent dataset variable values to blank dataset with preset variable lengths ---;
Data OBData.ATM_Geographic;
	Set Work.ATM_Test1
	OBData.ATM_Geographic;
Run;


******************************************************************************************
*	OPEN DATA: BCH
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      29DEC17
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
******************************************************************************************;
*--- Create Blank dataset and set variable lenghts ---;
Data WORK.BCH_TEST1;
	Input Data_Element $31. 
		RowCnt best12. 
		Count best12. 
		_Record_ID best12. 
		Accessibility1 $30. 
		Bank $25. 
		Accessibility2 $30. 
		Accessibility3 $30. 
		Accessibility4 $30. 
		Accessibility5 $30. 
		Accessibility6 $30. 
		Accessibility7 $30. 
		AddressLine1 $50. 
		AddressLine2 $50. 
		AddressLine3 $50. 
		AddressLine4 $50. 
		Agreement $300. 
		BrandName $30. 
		BuildingNumber $30. 
		ClosingTime $30. 
		Code $300. 
		ContactContent $300. 
		ContactDescription $100. 
		ContactType $15. 
		Country $3. 
		CountrySubDivision1 $50. 
		CustomerSegment1 $30. 
		CustomerSegment2 $30. 
		CustomerSegment3 $30. 
		CustomerSegment4 $30. 
		CustomerSegment5 $30. 
		CustomerSegment6 $30. 
		CustomerSegment7 $30. 
		CustomerSegment8 $30. 
		CustomerSegment9 $30. 
		Description $100. 
		Identification $30. 
		LastUpdated $30. 
		Latitude $15. 
		License $100. 
		Longitude $15. 
		Name $50. 
		Notes $100. 
		OpeningTime $30. 
		Photo $100. 
		PostCode $10. 
		SequenceNumber $10. 
		ServiceAndFacility1 $30. 
		ServiceAndFacility10 $30. 
		ServiceAndFacility11 $30. 
		ServiceAndFacility12 $30. 
		ServiceAndFacility2 $30. 
		ServiceAndFacility3 $30. 
		ServiceAndFacility4 $30. 
		ServiceAndFacility5 $30. 
		ServiceAndFacility6 $30. 
		ServiceAndFacility7 $30. 
		ServiceAndFacility8 $30. 
		ServiceAndFacility9 $30. 
		StartDate $30. 
		StreetName $30. 
		TermsOfUse $100. 
		TotalResults $10. 
		TownName $50. 
		Type $10. 
		Record_Count best12.; 
		Datalines;
		;
     run;
*--- Write permanent dataset variable values to blank dataset with preset variable lengths ---;
Data OBData.BCH_Geographic;
	Set Work.BCH_Test1
	OBData.BCH_Geographic;
Run;

******************************************************************************************
*	OPEN DATA: SME
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      29DEC17
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
******************************************************************************************;
*--- Create Blank dataset and set variable lenghts ---;
Data WORK.SME_TEST1; 
	Input Data_Element $31. 
		RowCnt best12. 
		Count best12. 
		SME_Count best12. 
		AgeRestricted $10. 
		Bank $25. 
		Agreement $300. 
		AnnualBusinessTurnover $15. 
		AnnualBusinessTurnoverCurrency $3. 
		ArrearsTreatment $100. 
		BIC $25. 
		Benefit $5. 
		BenefitDescription $300. 
		BenefitName $25. 
		BenefitSubType $25. 
		BenefitType $10. 
		CCARegulatedEntity $10. 
		Currency1 $10. 
		CustomerAccessChannels1 $25. 
		CustomerAccessChannels2 $25. 
		CustomerAccessChannels3 $25. 
		CustomerAccessChannels4 $25. 
		CustomerAccessChannels5 $25. 
		CustomerAccessChannels6 $25. 
		DefaultToAccounts $10. 
		Description $25. 
		EligibilityName $25. 
		EligibilityNotes $150. 
		EligibilityType $25. 
		FeeAmount $10. 
		FeeFrequency $25. 
		FeeMax $10. 
		FeeMin $10. 
		FeeRate $10. 
		FeeSubType $25. 
		FeeType $25. 
		FeesAndChargesNotes $300. 
		IncomeCondition $10. 
		IncomeTurnoverRelated $25. 
		IndicativeRate $150. 
		IsALowInterestRepaymentStartP36 $10. 
		IsThisAnInterestOnlyLoan $10. 
		LEI $25. 
		LastUpdated $10. 
		LegalName $50. 
		License $50. 
		LoanLengthIncrement $10. 
		LoanLengthIncrementLower $10. 
		LoanLengthIncrementUpper $10. 
		LoanSizeBandLower $10. 
		LoanSizeBandUpper $10. 
		MarketingEligibility1 $10. 
		MaxNumberOfAccounts $10. 
		MaximumAge $10. 
		MaximumAgeToOpen $10. 
		MaximumLoanAmount $10. 
		MaximumLoanTerm $10. 
		MaximumOpeningAmount $10. 
		MinimumAge $10. 
		MinimumDeposit $10. 
		MinimumIncomeTurnoverAmount $10. 
		MinimumIncomeTurnoverCurrency $10. 
		MinimumLoanAmount $10. 
		MinimumLoanTerm $10. 
		MinimumOperatingBalanceExists $10. 
		Negotiable $10. 
		OpeningDepositMaximumAmount $10. 
		OpeningDepositMaximumCurrency $10. 
		OpeningDepositMinimum $10. 
		OpeningDepositMinimumCurrency $10. 
		Other $10. 
		OtherFinancialHoldingRequired $10. 
		PaymentHoliday $10. 
		PreviousBankruptcy $10. 
		ProductDescription $150. 
		ProductIdentifier $10. 
		ProductName $50. 
		ProductSegment1 $10. 
		ProductSegment2 $10. 
		ProductSegment3 $10. 
		ProductSegment4 $10. 
		ProductSegment5 $10. 
		ProductSegment6 $10. 
		ProductSegment7 $10. 
		ProductState $10. 
		ProductSubType $25. 
		ProductTypeName $25. 
		ProductURL1 $300. 
		RateComaprisonType $25. 
		RateComparisonType $25. 
		RepaymentFrequency1 $10. 
		RepaymentFrequency2 $10. 
		RepaymentFrequency3 $10. 
		RepaymentFrequency4 $10. 
		RepaymentFrequency5 $10. 
		ResidencyRestricted $10. 
		ResidencyRestrictedRegion $10. 
		SizeIncrement $10. 
		TermsOfUse $50. 
		ThirdSectorOrganisations $10. 
		TotalResults $10. 
		TrademarkID $10. 
		TrademarkIPOCode $25. 
		TsandCs1 $150. 
		WillTheLoanBePaidInTrancheDra100 $10. 
		Record_Count best12.;
		Datalines;
		;
 Run;
*--- Write permanent dataset variable values to blank dataset with preset variable lengths ---;
Data OBData.SME_Geographic;
	Set Work.SME_Test1
	OBData.SME_Geographic;
Run;

******************************************************************************************
*	OPEN DATA: CCC
*   PRODUCT:   SAS
*   VERSION:   9.4
*   CREATOR:   External File Interface
*   DATE:      29DEC17
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
******************************************************************************************;
*--- Create Blank dataset and set variable lenghts ---;
Data WORK.CCC_TEST1;  
	Input Data_Element $31. 
        RowCnt best32. 
        Count best32. 
        _Record_ID best32. 
        APRRate $10. 
        Bank $50. 
        AbilityToSetIndividualLimits $10. 
        AccessToOnlineDataReportingTool $10. 
        AgeRestricted $10. 
        Agreement $150. 
        AllocationofRepayment $10. 
        AnnualAccountFeeType $100. 
        AnnualBusinessTurnover $10. 
        AnnualBusinessTurnoverCurrency $10.
        AnnualFeeAmount $10.
        BIC $50. 
        BalanceTransferInterestRatePe12 $10. 
        BalanceTransferRate $10. 
        Benefit $10. 
        BenefitDescription $50. 
        BenefitID $10. 
        BenefitName $25. 
        BenefitSubType $25. 
        BenefitType $10. 
        BenefitValue $10. 
        CCSubType $25. 
        CardScheme $25. 
        CashAdvanceRate $10. 
        CashWithdrawalsAllowed $10. 
        CashbackPercent $10. 
        ChequeFeePercent $25. 
        ConvenienceCheque $25. 
        DaysInterestFreeCreditIfPayme28 $10. 
        DefaultToAccounts $25. 
        Description $100. 
        EligibilityName $25. 
        EligibilityNotes $150. 
        EligibilityType $10. 
        ExchangeRateAdjustment $10. 
        FeesOnCheque $10. 
        ForeignCashFeeRate $10. 
        ForeignPurchaseFeeRate $10. 
        IncomeCondition $10. 
        IncomeTurnoverRelated $10. 
        IssuingEmergencyCardsFees $10.  
        KeyFeatures $300. 
        LEI $25. 
        LastUpdated $10. 
        LegalName $50. 
        License $50. 
        MarketingEligibility1 $25. 
        MarketingEligibility2 $25. 
        MarketingEligibility3 $25. 
        MaxNumberOfAccounts $10. 
        MaximumAgeToOpen $10. 
        MaximumCriteria $10. 
        MaximumNumberOfCardsPermitted $10. 
        MinimumAge $10. 
        MinimumCreditLimit $10. 
        MinimumCriteria $10. 
        MinimumDeposit $10. 
        MinimumLendingAmount $10. 
        MinimumRepaymentAmount $10. 
        MinimumRepaymentPercentage $10. 
        NonSterlingCashFee $10. 
        NonSterlingCashFeeRate $10. 
        NonSterlingPurchaseFeeRate $10. 
        NonSterlingTransactionFeeRate $10. 
        OtherFinancialHoldingRequired $10. 
        OtherKeyFeatures $10. 
        OverLimitFee $10. 
        PaymentDaysAfterStatement $10. 
        PaymentHoliday $10. 
        PaymentHolidayDescription $10. 
        PreviousBankruptcy $10. 
        ProductIdentifier $10. 
        ProductName $10. 
        ProductSegment1 $10. 
        ProductType $10. 
        ProductURL1 $150. 
        PurchaseRate $10. 
        RepaymentFrequency $10. 
        RepaymentNotes $10. 
        ResidencyRestricted $10. 
        ResidencyRestrictedRegion $10. 
        StatementAtAccountLevel $10. 
        StatementAtPersonalLevel $10. 
        TermsOfUse $50. 
        ThirdSectorOrganisations $10. 
        TotalResults $10. 
        TrademarkID $10. 
        TrademarkIPOCode $10. 
        TsandCs1 $150. 
        TsandCs2 $150. 
        Record_Count best32.;
		Datalines;
		;
Run;
*--- Write permanent dataset variable values to blank dataset with preset variable lengths ---;
Data OBData.CCC_Geographic;
	Set Work.CCC_Test1
	OBData.CCC_Geographic;
Run;

*/



*****************************************************************************************************
		CREATE THE CMA9_LAST UPDATED DATASET
*****************************************************************************************************;
/*
*--- Extract Last Updated Date from each API and create Perm Datasets ---;
%Macro LastUpDate(Dsn);
Data Work.&Dsn._LastUpdated;
	Set OBData.&Dsn._Geographic(Keep = Bank LastUpdated Where=(LastUpdated NE ''));
	Bank = Upcase(Bank);
	&Dsn._Date = Scan(LastUpdated,1,'T');
Run;
Proc Sort Data = Work.&Dsn._LastUpdated;
	By Bank; 
Run;
%Mend LastUpDate;
%LastUpDate(ATM);
%LastUpDate(BCH);
%LastUpDate(PCA);
%LastUpDate(BCA);
%LastUpDate(SME);
%LastUpDate(CCC);

Data OBData.CMA9_LastUpdated;
	Merge ATM_LastUpdated
	BCH_LastUpdated
	PCA_LastUpdated
	BCA_LastUpdated
	SME_LastUpdated
	CCC_LastUpdated;
	By Bank;

Run;

