Data OBData.Test_swag;
Set OBData.Swagger_pca;
Where hierarchy = 'Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-OverdraftFeesCharges-OverdraftFeeChargeDetail-OverdraftFeeApplicableRange';
Run;

Data OBData.Test_pca;
Set OBData.api_pca;
Where hierarchy = 'Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-OverdraftFeesCharges-OverdraftFeeChargeDetail-OverdraftFeeApplicableRange';
Run;


Data OBData.Test_com;
Set OBData.compare_pca;
Where hierarchy = 'Brand-PCA-PCAMarketingState-Overdraft-OverdraftTierBandSet-OverdraftFeesCharges-OverdraftFeeChargeDetail-OverdraftFeeApplicableRange';
Run;


%Let Val = Range or amounts or rates for which the fee/charge applies;
%Let Val = Maximum Amount on which fee is applicable (where it is expressed as an amount);
%Let Val = Maximum rate on which fee/charge is applicable(where it is expressed as an rate);
%Let Val = Minimum rate on which fee/charge is applicable(where it is expressed as an rate);
%Let Val = Description to describe the purpose of the code;


Data OBData.Test_swag;
Set OBData.Swagger_pca;
Where description = "&Val";
Run;

Data OBData.Test_pca;
Set OBData.api_pca;
Where enhancedDefinition = "&Val";
Run;


Data OBData.Test_com;
Set OBData.compare_pca;
Where pca_desc = "&Val";
Run;


*--- Test 350 ---;
%Let Val = 350;

Data OBData.Test_swag;
Set OBData.Swagger_pca;
Where description = "&Val";
Run;

Data OBData.Test_pca;
Set OBData.api_pca;
Where enhancedDefinition = "&Val";
Run;


Data OBData.Test_com;
Set OBData.compare_pca;
Where swagger_desc = "&Val";
Run;



*--- Test MaxLength 2000 + 200 ---;
%Let Val = Associated Notes about the overdraft rates
%Let Val = 2000;

Data OBData.Test_swag;
Set OBData.Swagger_pca;
Where MaxLength = "&Val";
Run;

Data OBData.Test_pca;
Set OBData.api_pca;
Where MaxLength = "&Val";
Run;


Data OBData.Test_com;
Set OBData.compare_pca;
Where MaxLength = "&Val";
Run;


