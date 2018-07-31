Libname OBData "C:\inetpub\wwwroot\sasweb\data\perm";

3     /**********************************************************************
4     *   PRODUCT:   SAS
5     *   VERSION:   9.4
6     *   CREATOR:   External File Interface
7     *   DATE:      29DEC17
8     *   DESC:      Generated SAS Datastep Code
9     *   TEMPLATE SOURCE:  (None Specified.)
10    ***********************************************************************/
11       data _null_;
12       %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
13       %let _EFIREC_ = 0;     /* clear export record count macro variable */
14       file 'C:\inetpub\wwwroot\sasweb\Data\Temp\BCA_Geoographic.csv' delimiter=',' DSD
14 ! DROPOVER lrecl=32767;
15       if _n_ = 1 then        /* write column names or labels */
16        do;
17          put
18             "Data_Element"
19          ','
20             "RowCnt"
21          ','
22             "Count"
23          ','
24             "BCA_Count"
25          ','
26             "APRAERRate"
27          ','
28             "Bank"
29          ','
30             "AccessChannels1"
31          ','
32             "AccessChannels10"
33          ','
34             "AccessChannels11"
35          ','
36             "AccessChannels12"
37          ','
38             "AccessChannels2"
39          ','
40             "AccessChannels3"
41          ','
42             "AccessChannels4"
43          ','
44             "AccessChannels5"
45          ','
46             "AccessChannels6"
47          ','
48             "AccessChannels7"
49          ','
50             "AccessChannels8"
51          ','
52             "AccessChannels9"
53          ','
54             "AgeRestricted"
55          ','
56             "Agreement"
57          ','
58             "AnnualBusinessTurnoverCurrency"
59          ','
60             "AnnualRenewalFee"
61          ','
62             "AnnualRenewalRate"
63          ','
64             "ArrangedOverdraftInterestTier"
65          ','
66             "ArrangementType"
67          ','
68             "BIC"
69          ','
70             "Benefit"
71          ','
72             "BenefitDescription"
73          ','
74             "BenefitID"
75          ','
76             "BenefitName"
77          ','
78             "BenefitSubType"
79          ','
80             "BenefitType"
81          ','
82             "BenefitValue"
83          ','
84             "BufferAmount"
85          ','
86             "CMADefinedIndicator"
87          ','
88             "CalculationFrequency"
89          ','
90             "CalculationMethod"
91          ','
92             "CardNotes"
93          ','
94             "CardType1"
95          ','
96             "CardType2"
97          ','
98             "CardType3"
99          ','
100            "CardWithdrawalLimit"
101         ','
102            "ChequeBookAvailable"
103         ','
104            "Contactless"
105         ','
106            "Counter"
107         ','
108            "CreditCharged"
109         ','
110            "CreditScoringPartOfAccountOpe42"
111         ','
112            "CreditScoringPartOfAccountOpe43"
113         ','
114            "CreditScoringPartOfAccountOpe44"
115         ','
116            "CreditScoringPartOfAccountOpe45"
117         ','
118            "CreditScoringPartOfAccountOpe46"
119         ','
120            "CreditScoringPartOfAccountOpe47"
121         ','
122            "CreditScoringPartOfAccountOpe48"
123         ','
124            "CriteriaType1"
125         ','
126            "Currency1"
127         ','
128            "DefaultToAccounts"
129         ','
130            "Description"
131         ','
132            "EAR"
133         ','
134            "EligibilityName"
135         ','
136            "EligibilityNotes"
137         ','
138            "EligibilityType"
139         ','
140            "ExchangeRateAdjustment"
141         ','
142            "ExistingFeature"
143         ','
144            "FeatureDescription"
145         ','
146            "FeatureName"
147         ','
148            "FeatureSubType"
149         ','
150            "FeatureType"
151         ','
152            "FeatureValue"
153         ','
154            "FeeAmount"
155         ','
156            "FeeChargeAmount"
157         ','
158            "FeeChargeApplicationFrequency"
159         ','
160            "FeeChargeCalculationFrequency"
161         ','
162            "FeeChargeNegotiableIndicator"
163         ','
164            "FeeChargeRate"
165         ','
166            "FeeChargeRateType"
167         ','
168            "FeeChargeType"
169         ','
170            "FeeFrequency"
171         ','
172            "FeeMax"
173         ','
174            "FeeMin"
175         ','
176            "FeeRate"
177         ','
178            "FeeSubType"
179         ','
180            "FeeType"
181         ','
182            "FeesAndChargesNotes"
183         ','
184            "IncomeCondition"
185         ','
186            "IncomeTurnoverRelated"
187         ','
188            "IndicativeRate"
189         ','
190            "InterestApplicationFrequency"
191         ','
192            "InterestNotes"
193         ','
194            "InterestProductSubType"
195         ','
196            "InterestRate"
197         ','
198            "InterestRateCalculationFrequency"
199         ','
200            "InterestRateEARpa"
201         ','
202            "InterestRateType"
203         ','
204            "InterestTier"
205         ','
206            "InterestTierPersonal"
207         ','
208            "InterestTierSME"
209         ','
210            "InterestTierSubType"
211         ','
212            "InternationalPaymentsSupported"
213         ','
214            "ItemCharge"
215         ','
216            "LEI"
217         ','
218            "LastUpdated"
219         ','
220            "LegalName"
221         ','
222            "LengthPromotionalInDays"
223         ','
224            "License"
225         ','
226            "MarketingEligibility1"
227         ','
228            "MaxNumberOfAccounts"
229         ','
230            "MaximumAge"
231         ','
232            "MaximumAgeToOpen"
233         ','
234            "MaximumCriteria"
235         ','
236            "MaximumMonthlyCharge"
237         ','
238            "MaximumMonthlyOverdraftCharge"
239         ','
240            "MaximumOpeningAmount"
241         ','
242            "MinIncomeTurnoverPaidIntoAccount"
243         ','
244            "MinUnarrangedOverdraftAmount"
245         ','
246            "MinimumAge"
247         ','
248            "MinimumCriteria"
249         ','
250            "MinimumDeposit"
251         ','
252            "MinimumFee"
253         ','
254            "MinimumIncomeFrequency"
255         ','
256            "MinimumIncomeTurnoverAmount"
257         ','
258            "MinimumIncomeTurnoverCurrency"
259         ','
260            "MinimumOperatingBalance"
261         ','
262            "MinimumOperatingBalanceCurrency"
263         ','
264            "MinimumOperatingBalanceExists"
265         ','
266            "MinimumRenewalFee"
267         ','
268            "MinimumSetupFee"
269         ','
270            "MobileWallet1"
271         ','
272            "MobileWallet2"
273         ','
274            "MobileWallet3"
275         ','
276            "MobileWallet4"
277         ','
278            "MobileWallet5"
279         ','
280            "MonthlyCharge"
281         ','
282            "Negotiable"
283         ','
284            "Notes"
285         ','
286            "OpeningDepositMaximumCurrency"
287         ','
288            "OpeningDepositMinimum"
289         ','
290            "OpeningDepositMinimumCurrency"
291         ','
292            "Other"
293         ','
294            "OtherCharge"
295         ','
296            "OtherFinancialHoldingRequired"
297         ','
298            "OverdraftNotes"
299         ','
300            "OverdraftOffered"
301         ','
302            "OverdraftProductState"
303         ','
304            "OverdraftType"
305         ','
306            "PaymentMethod"
307         ','
308            "PreviousBankruptcy"
309         ','
310            "ProductDescription"
311         ','
312            "ProductIdentifier"
313         ','
314            "ProductName"
315         ','
316            "ProductSegment1"
317         ','
318            "ProductState"
319         ','
320            "ProductSubType"
321         ','
322            "ProductType"
323         ','
324            "ProductURL1"
325         ','
326            "ProductURL2"
327         ','
328            "ProductURL3"
329         ','
330            "PromotionEndDate"
331         ','
332            "PromotionStartDate"
333         ','
334            "Rate"
335         ','
336            "RateComparisonType"
337         ','
338            "RatesAreNegotiable"
339         ','
340            "RepresentativeRate"
341         ','
342            "ResidencyRestricted"
343         ','
344            "ResidencyRestrictedRegion"
345         ','
346            "ReviewFee"
347         ','
348            "SetUpFeesAmount"
349         ','
350            "SetUpFeesRate"
351         ','
352            "SingleJointIncome"
353         ','
354            "Term"
355         ','
356            "TermsOfUse"
357         ','
358            "ThirdSectorOrganisations"
359         ','
360            "TierBandIdentification"
361         ','
362            "TierBandSetIdentification"
363         ','
364            "TierValueMaximum"
365         ','
366            "TierValueMinimum"
367         ','
368            "TotalOverdraftChargeAmount"
369         ','
370            "TotalResults"
371         ','
372            "TrademarkID"
373         ','
374            "TrademarkIPOCode"
375         ','
376            "TsandCs1"
377         ','
378            "UnarrangedOverdraftInterestTier"
379         ','
380            "Record_Count"
381         ;
382       end;
383     set  OBDATA.Bca_geographic   end=EFIEOD;
384         format Data_Element $100. ;
385         format RowCnt best12. ;
386         format Count best12. ;
387         format BCA_Count best12. ;
388         format APRAERRate $300. ;
389         format Bank $200. ;
390         format AccessChannels1 $300. ;
391         format AccessChannels10 $300. ;
392         format AccessChannels11 $300. ;
393         format AccessChannels12 $300. ;
394         format AccessChannels2 $300. ;
395         format AccessChannels3 $300. ;
396         format AccessChannels4 $300. ;
397         format AccessChannels5 $300. ;
398         format AccessChannels6 $300. ;
399         format AccessChannels7 $300. ;
400         format AccessChannels8 $300. ;
401         format AccessChannels9 $300. ;
402         format AgeRestricted $300. ;
403         format Agreement $300. ;
404         format AnnualBusinessTurnoverCurrency $300. ;
405         format AnnualRenewalFee $300. ;
406         format AnnualRenewalRate $300. ;
407         format ArrangedOverdraftInterestTier $300. ;
408         format ArrangementType $300. ;
409         format BIC $300. ;
410         format Benefit $300. ;
411         format BenefitDescription $300. ;
412         format BenefitID $300. ;
413         format BenefitName $300. ;
414         format BenefitSubType $300. ;
415         format BenefitType $300. ;
416         format BenefitValue $300. ;
417         format BufferAmount $300. ;
418         format CMADefinedIndicator $300. ;
419         format CalculationFrequency $300. ;
420         format CalculationMethod $300. ;
421         format CardNotes $300. ;
422         format CardType1 $300. ;
423         format CardType2 $300. ;
424         format CardType3 $300. ;
425         format CardWithdrawalLimit $300. ;
426         format ChequeBookAvailable $300. ;
427         format Contactless $300. ;
428         format Counter $300. ;
429         format CreditCharged $300. ;
430         format CreditScoringPartOfAccountOpe42 $300. ;
431         format CreditScoringPartOfAccountOpe43 $300. ;
432         format CreditScoringPartOfAccountOpe44 $300. ;
433         format CreditScoringPartOfAccountOpe45 $300. ;
434         format CreditScoringPartOfAccountOpe46 $300. ;
435         format CreditScoringPartOfAccountOpe47 $300. ;
436         format CreditScoringPartOfAccountOpe48 $300. ;
437         format CriteriaType1 $300. ;
438         format Currency1 $300. ;
439         format DefaultToAccounts $300. ;
440         format Description $300. ;
441         format EAR $300. ;
442         format EligibilityName $300. ;
443         format EligibilityNotes $300. ;
444         format EligibilityType $300. ;
445         format ExchangeRateAdjustment $300. ;
446         format ExistingFeature $300. ;
447         format FeatureDescription $300. ;
448         format FeatureName $300. ;
449         format FeatureSubType $300. ;
450         format FeatureType $300. ;
451         format FeatureValue $300. ;
452         format FeeAmount $300. ;
453         format FeeChargeAmount $300. ;
454         format FeeChargeApplicationFrequency $300. ;
455         format FeeChargeCalculationFrequency $300. ;
456         format FeeChargeNegotiableIndicator $300. ;
457         format FeeChargeRate $300. ;
458         format FeeChargeRateType $300. ;
459         format FeeChargeType $300. ;
460         format FeeFrequency $300. ;
461         format FeeMax $300. ;
462         format FeeMin $300. ;
463         format FeeRate $300. ;
464         format FeeSubType $300. ;
465         format FeeType $300. ;
466         format FeesAndChargesNotes $300. ;
467         format IncomeCondition $300. ;
468         format IncomeTurnoverRelated $300. ;
469         format IndicativeRate $300. ;
470         format InterestApplicationFrequency $300. ;
471         format InterestNotes $300. ;
472         format InterestProductSubType $300. ;
473         format InterestRate $300. ;
474         format InterestRateCalculationFrequency $300. ;
475         format InterestRateEARpa $300. ;
476         format InterestRateType $300. ;
477         format InterestTier $300. ;
478         format InterestTierPersonal $300. ;
479         format InterestTierSME $300. ;
480         format InterestTierSubType $300. ;
481         format InternationalPaymentsSupported $300. ;
482         format ItemCharge $300. ;
483         format LEI $300. ;
484         format LastUpdated $300. ;
485         format LegalName $300. ;
486         format LengthPromotionalInDays $300. ;
487         format License $300. ;
488         format MarketingEligibility1 $300. ;
489         format MaxNumberOfAccounts $300. ;
490         format MaximumAge $300. ;
491         format MaximumAgeToOpen $300. ;
492         format MaximumCriteria $300. ;
493         format MaximumMonthlyCharge $300. ;
494         format MaximumMonthlyOverdraftCharge $300. ;
495         format MaximumOpeningAmount $300. ;
496         format MinIncomeTurnoverPaidIntoAccount $300. ;
497         format MinUnarrangedOverdraftAmount $300. ;
498         format MinimumAge $300. ;
499         format MinimumCriteria $300. ;
500         format MinimumDeposit $300. ;
501         format MinimumFee $300. ;
502         format MinimumIncomeFrequency $300. ;
503         format MinimumIncomeTurnoverAmount $300. ;
504         format MinimumIncomeTurnoverCurrency $300. ;
505         format MinimumOperatingBalance $300. ;
506         format MinimumOperatingBalanceCurrency $300. ;
507         format MinimumOperatingBalanceExists $300. ;
508         format MinimumRenewalFee $300. ;
509         format MinimumSetupFee $300. ;
510         format MobileWallet1 $300. ;
511         format MobileWallet2 $300. ;
512         format MobileWallet3 $300. ;
513         format MobileWallet4 $300. ;
514         format MobileWallet5 $300. ;
515         format MonthlyCharge $300. ;
516         format Negotiable $300. ;
517         format Notes $300. ;
518         format OpeningDepositMaximumCurrency $300. ;
519         format OpeningDepositMinimum $300. ;
520         format OpeningDepositMinimumCurrency $300. ;
521         format Other $300. ;
522         format OtherCharge $300. ;
523         format OtherFinancialHoldingRequired $300. ;
524         format OverdraftNotes $300. ;
525         format OverdraftOffered $300. ;
526         format OverdraftProductState $300. ;
527         format OverdraftType $300. ;
528         format PaymentMethod $300. ;
529         format PreviousBankruptcy $300. ;
530         format ProductDescription $300. ;
531         format ProductIdentifier $300. ;
532         format ProductName $300. ;
533         format ProductSegment1 $300. ;
534         format ProductState $300. ;
535         format ProductSubType $300. ;
536         format ProductType $300. ;
537         format ProductURL1 $300. ;
538         format ProductURL2 $300. ;
539         format ProductURL3 $300. ;
540         format PromotionEndDate $300. ;
541         format PromotionStartDate $300. ;
542         format Rate $300. ;
543         format RateComparisonType $300. ;
544         format RatesAreNegotiable $300. ;
545         format RepresentativeRate $300. ;
546         format ResidencyRestricted $300. ;
547         format ResidencyRestrictedRegion $300. ;
548         format ReviewFee $300. ;
549         format SetUpFeesAmount $300. ;
550         format SetUpFeesRate $300. ;
551         format SingleJointIncome $300. ;
552         format Term $300. ;
553         format TermsOfUse $300. ;
554         format ThirdSectorOrganisations $300. ;
555         format TierBandIdentification $300. ;
556         format TierBandSetIdentification $300. ;
557         format TierValueMaximum $300. ;
558         format TierValueMinimum $300. ;
559         format TotalOverdraftChargeAmount $300. ;
560         format TotalResults $300. ;
561         format TrademarkID $300. ;
562         format TrademarkIPOCode $300. ;
563         format TsandCs1 $300. ;
564         format UnarrangedOverdraftInterestTier $300. ;
565         format Record_Count best12. ;
566       do;
567         EFIOUT + 1;
568         put Data_Element $ @;
569         put RowCnt @;
570         put Count @;
571         put BCA_Count @;
572         put APRAERRate $ @;
573         put Bank $ @;
574         put AccessChannels1 $ @;
575         put AccessChannels10 $ @;
576         put AccessChannels11 $ @;
577         put AccessChannels12 $ @;
578         put AccessChannels2 $ @;
579         put AccessChannels3 $ @;
580         put AccessChannels4 $ @;
581         put AccessChannels5 $ @;
582         put AccessChannels6 $ @;
583         put AccessChannels7 $ @;
584         put AccessChannels8 $ @;
585         put AccessChannels9 $ @;
586         put AgeRestricted $ @;
587         put Agreement $ @;
588         put AnnualBusinessTurnoverCurrency $ @;
589         put AnnualRenewalFee $ @;
590         put AnnualRenewalRate $ @;
591         put ArrangedOverdraftInterestTier $ @;
592         put ArrangementType $ @;
593         put BIC $ @;
594         put Benefit $ @;
595         put BenefitDescription $ @;
596         put BenefitID $ @;
597         put BenefitName $ @;
598         put BenefitSubType $ @;
599         put BenefitType $ @;
600         put BenefitValue $ @;
601         put BufferAmount $ @;
602         put CMADefinedIndicator $ @;
603         put CalculationFrequency $ @;
604         put CalculationMethod $ @;
605         put CardNotes $ @;
606         put CardType1 $ @;
607         put CardType2 $ @;
608         put CardType3 $ @;
609         put CardWithdrawalLimit $ @;
610         put ChequeBookAvailable $ @;
611         put Contactless $ @;
612         put Counter $ @;
613         put CreditCharged $ @;
614         put CreditScoringPartOfAccountOpe42 $ @;
615         put CreditScoringPartOfAccountOpe43 $ @;
616         put CreditScoringPartOfAccountOpe44 $ @;
617         put CreditScoringPartOfAccountOpe45 $ @;
618         put CreditScoringPartOfAccountOpe46 $ @;
619         put CreditScoringPartOfAccountOpe47 $ @;
620         put CreditScoringPartOfAccountOpe48 $ @;
621         put CriteriaType1 $ @;
622         put Currency1 $ @;
623         put DefaultToAccounts $ @;
624         put Description $ @;
625         put EAR $ @;
626         put EligibilityName $ @;
627         put EligibilityNotes $ @;
628         put EligibilityType $ @;
629         put ExchangeRateAdjustment $ @;
630         put ExistingFeature $ @;
631         put FeatureDescription $ @;
632         put FeatureName $ @;
633         put FeatureSubType $ @;
634         put FeatureType $ @;
635         put FeatureValue $ @;
636         put FeeAmount $ @;
637         put FeeChargeAmount $ @;
638         put FeeChargeApplicationFrequency $ @;
639         put FeeChargeCalculationFrequency $ @;
640         put FeeChargeNegotiableIndicator $ @;
641         put FeeChargeRate $ @;
642         put FeeChargeRateType $ @;
643         put FeeChargeType $ @;
644         put FeeFrequency $ @;
645         put FeeMax $ @;
646         put FeeMin $ @;
647         put FeeRate $ @;
648         put FeeSubType $ @;
649         put FeeType $ @;
650         put FeesAndChargesNotes $ @;
651         put IncomeCondition $ @;
652         put IncomeTurnoverRelated $ @;
653         put IndicativeRate $ @;
654         put InterestApplicationFrequency $ @;
655         put InterestNotes $ @;
656         put InterestProductSubType $ @;
657         put InterestRate $ @;
658         put InterestRateCalculationFrequency $ @;
659         put InterestRateEARpa $ @;
660         put InterestRateType $ @;
661         put InterestTier $ @;
662         put InterestTierPersonal $ @;
663         put InterestTierSME $ @;
664         put InterestTierSubType $ @;
665         put InternationalPaymentsSupported $ @;
666         put ItemCharge $ @;
667         put LEI $ @;
668         put LastUpdated $ @;
669         put LegalName $ @;
670         put LengthPromotionalInDays $ @;
671         put License $ @;
672         put MarketingEligibility1 $ @;
673         put MaxNumberOfAccounts $ @;
674         put MaximumAge $ @;
675         put MaximumAgeToOpen $ @;
676         put MaximumCriteria $ @;
677         put MaximumMonthlyCharge $ @;
678         put MaximumMonthlyOverdraftCharge $ @;
679         put MaximumOpeningAmount $ @;
680         put MinIncomeTurnoverPaidIntoAccount $ @;
681         put MinUnarrangedOverdraftAmount $ @;
682         put MinimumAge $ @;
683         put MinimumCriteria $ @;
684         put MinimumDeposit $ @;
685         put MinimumFee $ @;
686         put MinimumIncomeFrequency $ @;
687         put MinimumIncomeTurnoverAmount $ @;
688         put MinimumIncomeTurnoverCurrency $ @;
689         put MinimumOperatingBalance $ @;
690         put MinimumOperatingBalanceCurrency $ @;
691         put MinimumOperatingBalanceExists $ @;
692         put MinimumRenewalFee $ @;
693         put MinimumSetupFee $ @;
694         put MobileWallet1 $ @;
695         put MobileWallet2 $ @;
696         put MobileWallet3 $ @;
697         put MobileWallet4 $ @;
698         put MobileWallet5 $ @;
699         put MonthlyCharge $ @;
700         put Negotiable $ @;
701         put Notes $ @;
702         put OpeningDepositMaximumCurrency $ @;
703         put OpeningDepositMinimum $ @;
704         put OpeningDepositMinimumCurrency $ @;
705         put Other $ @;
706         put OtherCharge $ @;
707         put OtherFinancialHoldingRequired $ @;
708         put OverdraftNotes $ @;
709         put OverdraftOffered $ @;
710         put OverdraftProductState $ @;
711         put OverdraftType $ @;
712         put PaymentMethod $ @;
713         put PreviousBankruptcy $ @;
714         put ProductDescription $ @;
715         put ProductIdentifier $ @;
716         put ProductName $ @;
717         put ProductSegment1 $ @;
718         put ProductState $ @;
719         put ProductSubType $ @;
720         put ProductType $ @;
721         put ProductURL1 $ @;
722         put ProductURL2 $ @;
723         put ProductURL3 $ @;
724         put PromotionEndDate $ @;
725         put PromotionStartDate $ @;
726         put Rate $ @;
727         put RateComparisonType $ @;
728         put RatesAreNegotiable $ @;
729         put RepresentativeRate $ @;
730         put ResidencyRestricted $ @;
731         put ResidencyRestrictedRegion $ @;
732         put ReviewFee $ @;
733         put SetUpFeesAmount $ @;
734         put SetUpFeesRate $ @;
735         put SingleJointIncome $ @;
736         put Term $ @;
737         put TermsOfUse $ @;
738         put ThirdSectorOrganisations $ @;
739         put TierBandIdentification $ @;
740         put TierBandSetIdentification $ @;
741         put TierValueMaximum $ @;
742         put TierValueMinimum $ @;
743         put TotalOverdraftChargeAmount $ @;
744         put TotalResults $ @;
745         put TrademarkID $ @;
746         put TrademarkIPOCode $ @;
747         put TsandCs1 $ @;
748         put UnarrangedOverdraftInterestTier $ @;
749         put Record_Count ;
750         ;
751       end;
752      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
753      if EFIEOD then call symputx('_EFIREC_',EFIOUT);
754      run;
