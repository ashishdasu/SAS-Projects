/* ANOVA and regression analysis of random simulated data sets */

/* #1 */
/* Creating table */
DATA FERTILIZERS;
INPUT GROUP $ HEIGHT;
DATALINES;
A 38
A 47
A 39
A 35
A 42
B 22
B 19
B 18
B 23
B 21
C 14
C 16
C 11
C 18
C 15
;
RUN;

PROC PRINT DATA = FERTILIZERS;
	TITLE "PLANT HEIGHT BY FERTILIZER TYPE";
RUN;

/* Checking Assumptions */
ODS GRAPHICS ON;
PROC UNIVARIATE DATA=FERTILIZERS PLOT;
BY GROUP;
TITLE "KEY DISTRIBUTION PARAMETERS";
ODS SELECT PLOTS BASICMEASURES;
RUN;

/* ONE-WAY ANOVA W/ TUKEY ANALYSIS */
PROC ANOVA DATA = FERTILIZERS;
TITLE "ONE-WAY ANOVA";
CLASS GROUP;
MODEL HEIGHT = GROUP;
/* Tukey */
MEANS GROUP / TUKEY CLDIFF ;
RUN;




/* 2 */
DATA SCRUBS;
INPUT HEIGHT;
DATALINES;
38
47
39
35
42
;
RUN;

PROC PRINT DATA=SCRUBS;
TITLE "SCRUB HEIGHT";
RUN;


/* TTEST: h0: mu = 36.9, ha: mu > 36.9 */
PROC TTEST DATA = SCRUBS SIDES=U ALPHA=.05 H0=36.9;
	TITLE "ONE SIDED T-TEST: SCRUB HEIGHT";
	VAR HEIGHT;
RUN;




/* #3 */
/* DASU <- RANNOR(411921) */

DATA FINAL;
   DO STRAIN = 'A','B','C';
      DO I = 1 to 7 ;
      	SPEED = RANNOR(411921)*5 + 20 + 4*(Strain EQ 'B')+ 5*(Strain EQ 'C') - 2*(STRAIN EQ 'A');
		React = (INT(RANNOR(411921)*5 + 10 + 2*(Strain EQ 'B')+ 3*(Strain EQ 'C') - (STRAIN EQ 'A')));
		Sleep = 12 - ((STRAIN EQ 'A')+ 3.5*(Strain EQ 'C')+ 2*(Strain EQ 'B'))*rannor(411921);
            OUTPUT;
         END;
      END;
   DROP I;
RUN;

PROC PRINT DATA=FINAL;
TITLE "FINAL";
RUN;

/* Regression Analysis: Speed(minutes) vs Sleep(hours) */
PROC REG DATA = FINAL PLOTS = DIAGNOSTICS(STATS=NONE);
TITLE "Regression Analysis: Speed(minutes) vs Sleep(hours)";
MODEL SPEED = SLEEP;
RUN;
QUIT;





