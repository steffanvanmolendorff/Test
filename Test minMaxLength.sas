Data Work.X3;
	Set Work.X1(Where=(P13 EQ 'TierBandSet' and P16 EQ 'CreditInterestEligibility' and P19 EQ 'Notes' and P21 in ('minLength','maxLength')));
	
Run;

Data Work.X4;
	Set Work.X2(Where=(P13 EQ 'TierBandSet' and P16 EQ 'CreditInterestEligibility' and P19 EQ 'Notes' and P21 in ('minLength','maxLength')));
	
Run;


Data Work.X5;
	Set Work.X(Where=(P13 EQ 'TierBandSet' and P16 EQ 'CreditInterestEligibility' and P19 EQ 'Notes' and P21 in ('minLength','maxLength')));
	
Run;

Data Work.X6;
	Set Work.X(Where=(P13 EQ 'TierBandSet' and P16 EQ 'CreditInterestEligibility' and P19 EQ 'Notes' and P21 in ('minLength','maxLength')));
	
Run;

Data Work.X7;
	Set Work.X(Where=(P13 EQ 'TierBandSet' and P16 EQ 'CreditInterestEligibility' and P19 EQ 'Notes' and P21 in ('minLength','maxLength')));
	
Run;


