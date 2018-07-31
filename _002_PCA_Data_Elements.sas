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
		*--- Amounts ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-CreditInterest-TierBandSet-CreditInterestEligibility-Amount' Then Data_Element = 'CreditIntEligAmount';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Eligibility-OtherEligibility-Amount' Then Data_Element = 'OtherEligAmount';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-FeatureBenefitEligibility-Amount' Then Data_Element = 'FeatureBenefitEligAmount';

*--- ApplicationFrequency ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-ApplicationFrequency' Then Data_Element = 'FeeChargeAppFreq';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-OverdraftTierBand-OverdraftFeesCharges-OverdraftFeeChargeDetail-ApplicationFrequency' Then Data_Element = 'OverDraftFeeChargeAppFreq';

*--- CalculationFrequency ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-CalculationFrequency' Then Data_Element = 'FeeChargeCalcFreq';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-OverdraftTierBand-OverdraftFeesCharges-OverdraftFeeChargeDetail-CalculationFrequency' Then Data_Element = 'OverDraftFeeChargeCalcFreq';

*--- Description ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-CreditInterest-TierBandSet-CreditInterestEligibility-Description' Then Data_Element = 'CreditIntEligDesc';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Eligibility-OtherEligibility-Description' Then Data_Element = 'OtherEligDesc';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-OtherType-Description' Then Data_Element = 'FeatBenefitGroupOtherDesc';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-FeatureBenefitEligibility-Description' Then Data_Element = 'FeatBenefitItemDesc';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-FeatureBenefitEligibility-OtherType-Description' Then Data_Element = 'FeatBenefitItemOtherDesc';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-MobileWallet-OtherType-Description' Then Data_Element = 'MobileWalletOtherDesc';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-OtherFeeType-Description' Then Data_Element = 'FeeChargeOtherTypeDesc';

*--- FeeAmount ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-FeeAmount' Then Data_Element = 'FeeChargeAmount';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-OverdraftTierBand-OverdraftFeesCharges-OverdraftFeeChargeDetail-FeeAmount' Then Data_Element = 'OverdraftFeeChargeAmount';

*--- FeeCategory ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-FeeCategory' Then Data_Element = 'FeeChargeFeeCategory';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-OtherFeeType-FeeCategory' Then Data_Element = 'FeeChargeOtherFeeCategory';

*--- FeeType ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeCap-FeeType' Then Data_Element = 'FeeChargeCapFeeType';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-FeeType' Then Data_Element = 'FeeChargeDetailFeeType';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-OverdraftTierBand-OverdraftFeesCharges-OverdraftFeeChargeDetail-FeeType' Then Data_Element = 'OverdraftFeeChargeFeeType';

*--- Indetification ---;
	If Hierarchy = 'data-Brand-PCA-Identification' Then Data_Element = 'PCAIdentification';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-CreditInterest-TierBandSet-TierBand-Identification' Then Data_Element = 'TierBandIdentification';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-FeatureBenefitItem-Identification' Then Data_Element = 'FeatureBenGroupIdentification';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-Identification' Then Data_Element = 'FeatureBenItemIdentification';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Identification' Then Data_Element = 'MarkStateIdentification';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-Identification' Then Data_Element = 'OverdraftIdentification';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-OverdraftTierBand-Identification' Then Data_Element = 'OverdraftTierBandIdentification';

*--- Indetification ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Eligibility-OtherEligibility-Indicator' Then Data_Element = 'OtherEligIndicator';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-FeatureBenefitEligibility-Indicator' Then Data_Element = 'FeatureBenefitEligIndicator';

*--- Name ---;
	If Hierarchy = 'data-Brand-PCA-Name' Then Data_Element = 'ProductName';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-CreditInterest-TierBandSet-CreditInterestEligibility-Name' Then Data_Element = 'CreditIntEligName';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Eligibility-OtherEligibility-Name' Then Data_Element = 'OtherEligName';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-FeatureBenefitItem-Name' Then Data_Element = 'FeatureBenefitItemName';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-Name' Then Data_Element = 'FeatureBenefitGrpName';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-OtherType-Name' Then Data_Element = 'FeatureBenefitGrpOtherName';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-FeatureBenefitEligibility-Name' Then Data_Element = 'FeatureBenefitEligName';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-FeatureBenefitEligibility-OtherType-Name' Then Data_Element = 'FeatureBenefitEligOtherName';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-Name' Then Data_Element = 'FeatureBenefitItemName';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-MobileWallet-OtherType-Name' Then Data_Element = 'MobileWalletOtherTypeName';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-OtherFeeType-Name' Then Data_Element = 'FeeChargeOtherFeeTypeName';


*--- Notes ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-CreditInterest-TierBandSet-Notes' Then Data_Element = 'CreditIntTierBandSetNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Eligibility-AgeEligibility-Notes' Then Data_Element = 'AgeEligibilityNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Eligibility-OtherEligibility-Notes' Then Data_Element = 'OtherEligibilityNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Eligibility-ResidencyEligibility-Notes' Then Data_Element = 'ResidencyEligibilityNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-Card-Notes' Then Data_Element = 'FeatureBenefitsCardNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-FeatureBenefitItem-Notes' Then Data_Element = 'FeatureBenefitGrpItemNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-Notes' Then Data_Element = 'FeatureBenefitGrpNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-Notes' Then Data_Element = 'FeatureBenefitItemNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-MobileWallet-Notes' Then Data_Element = 'MobileWalletNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Notes' Then Data_Element = 'PCAMarketingStateNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeCap-Notes' Then Data_Element = 'FeeChargeCapNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-Notes' Then Data_Element = 'FeeChargeDetailNotes';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-OverdraftTierBand-OverdraftFeesCharges-OverdraftFeeChargeDetail-Notes' Then Data_Element = 'OverdraftFeeChargeNotes';

*--- Notes1 ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-CreditInterest-TierBandSet-Notes-Notes1' Then Data_Element = 'TierBandSetNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Eligibility-AgeEligibility-Notes-Notes1' Then Data_Element = 'AgeEligibilityNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Eligibility-OtherEligibility-Notes-Notes1' Then Data_Element = 'OtherEligibilityNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Eligibility-ResidencyEligibility-Notes-Notes1' Then Data_Element = 'ResidencyEligNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-Card-Notes-Notes1' Then Data_Element = 'FeatureBenefitsCardNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-FeatureBenefitItem-Notes-Notes1' Then Data_Element = 'FeatureBenefitItemNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-Notes-Notes1' Then Data_Element = 'FeatureBenefitGrpNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-Notes-Notes1' Then Data_Element = 'FeatureBenefitItemNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-MobileWallet-Notes-Notes1' Then Data_Element = 'MobileWalletNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Notes-Notes1' Then Data_Element = 'PCAMarketingStateNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeCap-Notes-Notes1' Then Data_Element = 'FeeChargeCapNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-Notes-Notes1' Then Data_Element = 'FeeChargeDetailNotes1';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-OverdraftTierBand-OverdraftFeesCharges-OverdraftFeeChargeDetail-Notes-Notes1' Then Data_Element = 'OverdraftFeeChargeNotes1';

*--- Notes2 ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-FeatureBenefitItem-Notes-Notes2' Then Data_Element = 'FeatureBenefitItemNotes2';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-Notes-Notes2' Then Data_Element = 'FeatureBenefitItemNotes2';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-Notes-Notes2' Then Data_Element = 'FeeChargeDetailNotes2';


*--- Notes2 ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-Notes-Notes3' Then Data_Element = 'FeatureBenefitItemNotes3';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-OtherFeesCharges-FeeChargeDetail-Notes-Notes3' Then Data_Element = 'FeeChargeDetailNotes3';

*--- OtherType ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-OtherType' Then Data_Element = 'FeatureBenefitGrpOtherType';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-FeatureBenefitEligibility-OtherType' Then Data_Element = 'FeatureBenefitEligOtherType';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-MobileWallet-OtherType' Then Data_Element = 'MobileWalletOtherType';

*--- Period ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-CreditInterest-TierBandSet-CreditInterestEligibility-Period' Then Data_Element = 'CreditIntEligPeriod';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-FeatureBenefitEligibility-Period' Then Data_Element = 'FeatureBenefitEligPeriod';

*--- Textual ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-FeatureBenefitItem-Textual' Then Data_Element = 'FeatureBenefitItemTextual';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-FeatureBenefitEligibility-Textual' Then Data_Element = 'FeatureBenefitEligTextual';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-Textual' Then Data_Element = 'FeatureBenefitItemTextual';

*--- Method ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-CreditInterest-TierBandSet-TierBandMethod' Then Data_Element = 'TierBandMethod';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-TierBandMethod' Then Data_Element = 'OverdraftTierBandSetMethod';

*--- Type ---;
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-CreditInterest-TierBandSet-CreditInterestEligibility-Type' Then Data_Element = 'CreditInterestEligType';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-Eligibility-OtherEligibility-Type' Then Data_Element = 'OtherEligType';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-Card-Type' Then Data_Element = 'FeaturesBenefitsCardType';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-FeatureBenefitItem-Type' Then Data_Element = 'FeatureBenefitGrpItemType';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitGroup-Type' Then Data_Element = 'FeatureBenefitGrpType';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-FeatureBenefitEligibility-Type' Then Data_Element = 'FeatureBenefitEligType';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-FeatureBenefitItem-Type' Then Data_Element = 'FeatureBenefitItemType';
	If Hierarchy = 'data-Brand-PCA-PCAMarketingState-FeaturesAndBenefits-MobileWallet-Type' Then Data_Element = 'MobileWalletType';
	Count = 1;
Run;

	Proc Summary Data = Work.X_03_nodup Nway Missing;
		Class Data_Element Hierarchy;
		Var Count;
		Output Out = Work.X_04_nodup(Drop = _TYpe_ _Freq_)Sum=;
	Run;
