proc sort data = sashelp.cars
	out = sortedcars;
	by make;
run;

data _null_;
	set sortedcars nobs=nobs;
	by make;
		if first.make then do;
			rc = dosubl(cat('SYSECHO "Processing Cars: [',
				repeat("*",floor(_N_/NOBS*10)),
				repeat("_",10-floor(_N_/NOBS*10)),"]",
				put(_N_/NOBS, percent.),' / Total: ',
				put(NOBS,comma4.),' obs.";'));
			x=sleep(250,.001);

		end;
run;
