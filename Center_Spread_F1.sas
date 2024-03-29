/* Ashish Dasu
 * Analyzing center and spread of qualifying and race time delta between top two drivers over the past 30 races
 */


DATA QUALI;
	INPUT DELTA @@;
	DATALINES;
		0.123 0.025 0.286 0.779 0.19 0.323 0.225 0.282 0.645 0.072 0.029 0.304 0.044 
		0.632 0.021 0.145 0.022 0.01 0.065 0.304 0.203 0.228 0.138 0.155 0.236 0.188 
		0.361 0.084 0.462 1.244
		;
RUN;

DATA RACE;
	INPUT DELTA @@;
	DATALINES;
		5.598
		0.549
		20.524
		16.527
		3.786
		13.072
		1.154
		20.823
		0.993
		3.779
		1.532
		10.587
		7.834
		17.841
		4.071
		2.446
		2.595
		27.066
		5.023
		15.186
		1.529
		8.771
		11.987
		5.355
		0.179
		2.137
		5.384
		27.921
		24.09
		9.57
		;
RUN;

DATA RACE_QUALI;
	MERGE QUALI(RENAME=(DELTA=QUALI_DELTA)) RACE(RENAME=(DELTA=RACE_DELTA));
PROC PRINT DATA = RACE_QUALI;
	TITLE "Difference in Qualifying and Race Time Between Top Two Drivers (s)";
RUN;



DATA DRIVERSQ;
	INPUT QUALI_FIRST $ QUALI_SECOND $;
	DATALINES;
		LEC VER
		PER LEC
		LEC VER
		VER LEC
		LEC SAI
		LEC VER
		LEC SAI
		LEC PER
		VER ALO
		SAI VER
		VER LEC
		LEC VER
		RUS SAI
		VER SAI
		VER LEC
		LEC VER
		LEC PER
		VER LEC
		SAI LEC
		VER RUS
		MAG VER
		VER PER
		VER PER
		PER LEC
		VER RUS
		LEC VER
		PER ALO
		VER ALO
		VER SAI
		VER HUL
		;
RUN;

DATA DRIVERSR;
	INPUT RACE_FIRST $ RACE_SECOND $;
	DATALINES;
		LEC SAI
		VER LEC
		LEC PER
		VER PER
		VER LEC
		VER PER
		PER SAI
		VER PER
		VER SAI
		SAI PER
		LEC VER
		VER HAM
		VER HAM
		VER PER
		VER RUS
		VER LEC
		PER LEC
		VER PER
		VER HAM
		VER HAM
		RUS HAM
		VER LEC
		VER PER
		PER VER
		VER HAM
		PER VER
		VER PER
		VER ALO
		VER HAM
		VER ALO
		;
RUN;

DATA DRIVERS_BOTH;
	MERGE DRIVERSQ DRIVERSR;
PROC PRINT DATA = DRIVERS_BOTH;
	TITLE "Top Two Drivers: Quali and Race";
RUN;

/* PROC COMPARE OUTSTATS=PERCENT */
/* 	BASE=QUALI COMPARE=RACE; */
/* 	VAR DELTA; */
/* 	PROC PRINT DATA = PERCENT; */
/* 	TITLE 'PERCENT DIFFERENCE IN QUALI AND RACE DELTAS'; */
/* RUN; */

/* Quali Plots */
/* PROC MEANS DATA=QUALI MAXDEC=3 MEAN STD; */
/* 	TITLE "Quali PROC MEANS"; */
/* 	VAR DELTA; */
/* RUN; */

/* ODS GRAPHICS ON; */
/*  */
/* PROC UNIVARIATE DATA=QUALI; */
/* 	VAR DELTA; */
/* 	TITLE "Quali PROC UNIVARIATE"; */
/* 	HISTOGRAM DELTA /NORMAL; */
/* 	ODS SELECT HISTOGRAM; */
/* RUN; */

PROC UNIVARIATE DATA=QUALI PLOT NORMAL;
	TITLE "Quali Times Probability Distributions";
	VAR DELTA;
RUN;

/* Race Plots */
/* PROC MEANS DATA=RACE MAXDEC=3 MEAN STD; */
/* 	TITLE "Race PROC MEANS"; */
/* 	VAR DELTA; */
/* RUN; */


/* PROC UNIVARIATE DATA=RACE; */
/* 	VAR DELTA; */
/* 	TITLE "Race PROC UNIVARIATE"; */
/* 	HISTOGRAM DELTA /NORMAL; */
/* 	ODS SELECT HISTOGRAM; */
/* RUN; */

PROC UNIVARIATE DATA=RACE PLOTS NORMAL;
	VAR DELTA;
	TITLE "Race Times Probability Distributions";
RUN;


/* Frequency Plots For Drivers */
PROC GCHART DATA = DRIVERSQ;
TITLE "Frequency Plot Of Drivers 1st Place in Qualfying";
VBAR QUALI_FIRST;
RUN;
QUIT;

PROC GCHART DATA = DRIVERSR;
TITLE "Frequency Plot of Driver Race Wins";
VBAR RACE_FIRST;
RUN;
QUIT;

PROC GCHART DATA = DRIVERSQ;
TITLE "Frequency Plot Of Drivers 2nd Place in Qualfying";
VBAR QUALI_SECOND;
RUN;
QUIT;

PROC GCHART DATA = DRIVERSR;
TITLE "Frequency Plot of Driver 2nd Place in Race";
VBAR RACE_SECOND;
RUN;
QUIT;

/* Extra */

/* PROC SGPLOT DATA=GRAPH; */
/* 	histogram RACE_DELTA; */
/* 	histogram QUALI_DELTA; */
/* RUN; */