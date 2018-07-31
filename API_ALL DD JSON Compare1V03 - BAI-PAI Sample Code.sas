*--- Update the Data structure to match the Swagger file ---;
	Data OBData.API_PCA1(Drop = Hierarchy Rename=(Datastructure1 = Hierarchy));
		Length DataStructure DataStructure1 $ 1028;
		Set OBData.API_PCA;
		If Substr(Hierarchy,1,3) = 'PCA' Then
		Do;
			DataStructure = Substr(Hierarchy,28);
			DataStructure1 = Compress('Brand-PCA-PCAMarketingState'||'-'||DataStructure);
		End;
		Else Do;
			DataStructure1 = Hierarchy;
		End;
	Run;

