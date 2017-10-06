Data Work.X1;
	Set Work.X(Where=(P13 EQ 'TierBandSet' and P16 EQ 'CreditInterestEligibility' and P19 EQ 'Notes'));

	New_Data_Element2 = Reverse(Reverse(Trim(Left(New_Data_Element1))));
	New_Data_Element3 = Reverse(Scan(Reverse(Trim(Left(New_Data_Element1))),2,'-'));

	If New_Data_Element3 NE 'items' Then
	Do;
		New_Data_Element4 = Compress(Tranwrd(Tranwrd(Tranwrd(Tranwrd(Tranwrd(Tranwrd(Hierarchy,'data-',''),'properties-',''),'-enum',''),'-items',''),'-required',''),'items-',''));
		Hierarchy = New_Data_Element4;
	End;
	Else If New_Data_Element3 EQ 'items' Then
	Do;
		New_Data_Element5 = Scan(Trim(Left(Reverse(New_Data_Element2))),1,'-');
		NWords = CountW(New_Data_Element2,'-');
		Length New_Word1 New_Word2 $ 250;
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
