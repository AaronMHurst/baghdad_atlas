/*****************************************************************************
   Script to display meta data from 'sample' relational table. 
   Constrain query to all elements and enriched isotopes with atomic numbers
   greater than or equal to 40 and less than 76.
*****************************************************************************/

BEGIN TRANSACTION;

SELECT element AS "Element/Isotope", Z, A, enrichment, N, dN, isotope_norm
       AS "Normalization Isotope", e_gamma_norm AS "Normalization Gamma"
       FROM sample
       WHERE sample.Z >= 40 AND sample.Z < 76;

END TRANSACTION;
