DATA TEST2;
INPUT EXAM1
	  EXAM2;
DATALINES;
80 75
78 57
65 90
77 83
85 79
97 89
;
PROC PRINT DATA = TEST2;
RUN;
PROC MEANS DATA = TEST2;
RUN;
PROC MEANS DATA = TEST2;
 VAR EXAM1;
 RUN;