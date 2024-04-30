/*****************************************************************************
   Script to display meta data from 'sample' relational table. 
*****************************************************************************/

BEGIN TRANSACTION;

SELECT element AS "Element/Isotope", symbol AS "Chemical Symbol", 
       mass AS "Mass [g]", exposure_time AS "Irradiation Period [h]",
       sample_composition AS "Sample Composition"
       FROM sample;

END TRANSACTION;
