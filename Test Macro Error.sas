%Macro catch();
data _null_;
*set OBData.X;
	Set xxx;
run;
%If &SysErr Ne 0 %Then
%Do;
	%Put %Quote(<<< ERROR **** &SysErr *** >>>);
%End;
%Else %If &SysErr EQ 0 %Then
%Do;
	%Put %Quote(<<< NO ERROR *** >>>);
%End;
%Mend Catch;
%Catch;
