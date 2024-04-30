/*****************************************************************************
   Script to generate various counting statistics from the database.
*****************************************************************************/

BEGIN TRANSACTION;

/* Count number of natural and isotopically-enriched samples */
SELECT COUNT(element) AS "No. natural (elemental) samples:" 
       FROM sample
       WHERE A = 0;
SELECT COUNT(element) AS "No. isotopically-enriched samples:" 
       FROM sample
       WHERE A != 0;

/* Do some simple algebra: Add to find total number of samples */
SELECT	
	(SELECT COUNT(element) FROM sample WHERE A = 0) 
	+
	(SELECT COUNT(element) FROM sample WHERE A !=0 )
	AS "Total no. samples:";

/* Find total number of gamma lines in database */
SELECT COUNT(energy_gamma) AS "Total no. gamma lines:"
       FROM nucleus;

/* Find total number of (n,g) lines in database */
SELECT COUNT(energy_gamma) AS "No. (n,g) lines:"
       FROM nucleus
       WHERE residual = 'NG';

/* Find number of doublets */
SELECT COUNT(energy_gamma) AS "No. doublet gammas:"
       FROM nucleus
       WHERE transition_type LIKE '%d%';

/* Find number of calibration gammas */
SELECT COUNT(energy_gamma) AS "No. calibration gammas:"
       FROM nucleus
       WHERE transition_type = 'c';

/* Find number of unassigned gammas WRT excitation energy */
SELECT COUNT(energy_gamma) AS "No. gammas unassigned WRT excitation energy:"
       FROM nucleus
       WHERE ex_type = 'u';

/* Find number of tentatively assigned gammas WRT excitation energy */
SELECT COUNT(energy_gamma) AS "No. gammas tentatively assigned WRT excitation energy:"
       FROM nucleus
       WHERE ex_type = 't';

/* Find number of tentative residual assignments */
SELECT COUNT(energy_gamma) AS "No. tentative residual assignments:"
       FROM nucleus
       WHERE residual_type = 't';

/* Find number of firm residual assignments */
SELECT COUNT(energy_gamma) AS "No. firm residual assignments:"
       FROM nucleus
       WHERE residual_type = 'f';

END TRANSACTION;
