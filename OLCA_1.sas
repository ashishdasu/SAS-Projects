DATA OL1;
	INPUT NAME $ SECTION $ HW TEST_1 TEST_2 EXAM;
	FINAL_GRADE=(0.1*HW)+(0.25*TEST_1)+(0.25*TEST_2)+(0.4*EXAM);
	DATALINES;
Keri 001 100 35 55 25 
Ying 002 89 75 88 95 
Tianhui 001 91 93 94 90 
David 003 65 88 82 90 
Stephan 002 88 92 92 94
Deepti 001 97 100 94 97 
;

PROC PRINT DATA=OL1;
RUN;

PROC PRINT DATA=OL1;
	VAR FINAL_GRADE;
RUN;