FILENAME REFFILE '/home/u63443858/my_shared_file_links/schimiak/DATA_For_Analysis.csv';
PROC IMPORT DATAFILE=REFFILE
DBMS=CSV
OUT=WORK.PROBLEM1;
GETNAMES=YES;
RUN;
Proc Print Data = PROBLEM1;
RUN;