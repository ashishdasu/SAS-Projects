/* Visualizing distributions and calculating key statistics of sample datasets */

/* 1a */
DATA SPEED_READING;
TITLE "SPEED READING COURSE DATA";
INPUT SUBJ $ 1-3 AGE 4-5 WORDS_INIT 6-8 WORDS_FINAL 10-12;
DIFFERENCE = WORDS_FINAL - WORDS_INIT;
DATALINES;
02121110 150
00119090 140
00920100 115
05021160 200
;

/* 1b */
PROC PRINT DATA = SPEED_READING;
RUN;

/* 1c */
PROC MEANS DATA = SPEED_READING;
VAR DIFFERENCE;
RUN;

/* 2a */
DATA BLOOD;
Infile '/home/u63443858/my_shared_file_links/schimiak/Blood_Type.csv' DELIMITER=',' DSD;
INPUT
BLOODTYPE $;
RUN;

/* Frequency Table */
PROC GCHART DATA = BLOOD;
	TITLE "DISTRIBUTION OF BLOOD TYPE FOR 50 PATIENTS";
	VBAR BLOODTYPE;
RUN;
QUIT;

/* Relative Frequency Table */
PROC GCHART DATA = BLOOD;
	TITLE "DISTRIBUTION OF BLOOD TYPE FOR 50 PATIENTS";
	VBAR BLOODTYPE / TYPE = PERCENT;
RUN;
QUIT;

/* 2b */
PROC GCHART DATA = BLOOD;
	TITLE "DISTRIBUTION OF BLOOD TYPE FOR 50 PATIENTS";
	PIE3D BLOODTYPE / TYPE = PERCENT EXPLODE='B';
RUN;
QUIT;



/* 3a */
DATA GRADES;
INFILE '/home/u63443858/my_shared_file_links/schimiak/ForSASBlackboard003.csv' DELIMITER = ',' DSD;
INPUT role $ MINITAB1 MINITAB2 MINITAB3 MINITAB4 MINITAB5 MINITAB6 MIDTERM FINAL_EXAM;
AVE_MINITAB_GRADE = (MINITAB1 + MINITAB2 + MINITAB3 + MINITAB4 + MINITAB5 + MINITAB6) / 6;
FINAL_GRADE = .2 * AVE_MINITAB_GRADE + .3 * MIDTERM + .5 * FINAL_EXAM;
/* PROC PRINT DATA = GRADES; */
RUN;

/* 3b */
PROC MEANS DATA = GRADES MAXDEC = 1;
TITLE "MEANS PROCEDURE FOR SELECTED ASSIGNMENTS";
VAR MINITAB6 AVE_MINITAB_GRADE MIDTERM FINAL_EXAM;
RUN;


/* 3c */
PROC UNIVARIATE DATA = GRADES;
TITLE "DISTRIBUTION OF FINAL GRADES";
HISTOGRAM FINAL_GRADE / VSCALE = COUNT ENDPOINTS = 0 to 110 by 10;
ODS SELECT HISTOGRAM;
RUN;
