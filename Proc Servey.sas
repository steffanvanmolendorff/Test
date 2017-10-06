  %Let Path = C:\inetpub\wwwroot\sasweb\Data\Perm;

*--- Set X path variable to the default directory ---;
X "cd &Path";

*--- Set the Library path where the permanent datasets will be saved ---;
Libname OBData "&Path";

PROC SURVEYSELECT DATA=OBData.atm_geographic OUT=OBData.atm_geographic_Sampleset METHOD=SRS
  SAMPSIZE=100 SEED=1234567;
  RUN;
