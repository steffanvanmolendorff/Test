Data Work.Combine;
	Set OBData.OBPaySet
	OBData.OBPaysetResponse
	OBData.OBPaySub
	OBData.OBPaySubResponse;
Run;
Proc Sort Data = Work.Combine;
	By Hierarchy;
Run;

Data Test;

A='Unique reference, as assigned by the creditor, to unambiguously refer to the payment transaction. Usage: If available, the initiating party should provide this reference in the structured remittance information, to enable reconciliation by the creditor upon receipt of the amount of money. If the business context requires the use of a creditor reference or a payment remit identification, and only one identifier can be passed through the end-to-end chain, the creditor-s reference or payment remittance identification should be quoted in the end-to-end transaction identification.';
B=Length(A);
C='Unique reference, as assigned by the creditor, to unambiguously refer to the payment transaction. Usage: If available, the initiating party should provide this reference in the structured remittance information, to enable reconciliation by the creditor upon receipt of the amount of money. If the business context requires the use of a creditor reference or a payment remit identification, and only one identifier can be passed through the end-to-end chain, the creditor-s reference or payment remitt';
D=Length(C);
run;
