OPTIONS (skip=1)
LOAD DATA
INFILE 'placeholder.dat'
BADFILE 'placeholder.bad'
TRUNCATE
INTO TABLE {0}
FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
{1}
)









































































































































































































































