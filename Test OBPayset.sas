Libname OBData "C:\inetpub\wwwroot\sasweb\data\perm";

Data Work.Test;
	Merge OBData.OBPayset(In=a)
	OBData.OBPaysetResponse(In=b);
	By Hierarchy;
	If a and not b then Infile = 'P';
	If b and not a then Infile = 'R';
	If a and b then Infile = 'A';
Run;

Data Work.Test2;
	Merge OBData.OBPaysub(In=a)
	OBData.OBPaysubResponse(In=b);
	By Hierarchy;
	If a and not b then Infile = 'S';
	If b and not a then Infile = 'R';
	If a and b then Infile = 'A';
Run;

Data Work.Test3;
	Merge Work.Test(In=a)
	Work.Test2(In=b);
	By Hierarchy;
	If a and not b then InfileTest = 'Set';
	If b and not a then Infile = 'Sub';
	If a and b then Infile = 'All';
Run;


Data Work.Test4;
	Set OBData.Swagger_sch;

	x = Find(Hierarchy,'-Risk');

	If Find(Hierarchy,'-Risk') > 0 Then
	Do;

		If Substr(Hierarchy,1,Find(Hierarchy,'-Risk')) = 'paths-/payments-post-parameters-schema-' Then
		Do;
			Hierarchy = Compress('OBPaymentSetup1'||Substr(Hierarchy,Find(Hierarchy,'-Risk')));
		End;

		If Substr(Hierarchy,1,Find(Hierarchy,'-Risk')) = 'paths-/payments-post-responses-201-schema-' Then
		Do;
			Hierarchy = Compress('OBPaymentSetupResponse1'||Substr(Hierarchy,Find(Hierarchy,'-Risk')));
		End;

		If Substr(Hierarchy,1,Find(Hierarchy,'-Risk')) = 'paths-/payment-submissions-post-parameters-schema-' Then
		Do;
			Hierarchy = Compress('OBPaymentSubmission1-'||Substr(Hierarchy,Find(Hierarchy,'-Risk')));
		End;

		If Substr(Hierarchy,1,Find(Hierarchy,'-Risk')) = 'paths-/payments/{PaymentId}-get-responses-200-schema-' Then
		Do;
			Hierarchy = Compress('OBPaymentSubmissionResponse1'||Substr(Hierarchy,Find(Hierarchy,'-Risk')));
		End;

	End;

Run;
