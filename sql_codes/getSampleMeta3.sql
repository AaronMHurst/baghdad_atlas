/*****************************************************************************
   Script to display meta data from 'sample' relational table. 

   Run two queries:

   (i) Constrain query to elements (natural abundance) only with atomic 
   numbers greater than or equal to 40 and less than 76.
   (i) Constrain query to isotopically-enriched samples only with atomic 
   numbers greater than or equal to 40 and less than 76.
*****************************************************************************/

BEGIN TRANSACTION;

SELECT element AS "Element/Isotope", Z, A, enrichment, N, dN, isotope_norm
       AS "Normalization Isotope", e_gamma_norm AS "Normalization Gamma"
       FROM sample
       WHERE sample.Z >= 40 AND sample.Z < 76
       AND sample.A = 0;

SELECT element AS "Element/Isotope", Z, A, enrichment, N, dN, isotope_norm
       AS "Normalization Isotope", e_gamma_norm AS "Normalization Gamma"
       FROM sample
       WHERE sample.Z >= 40 AND sample.Z < 76
       AND sample.A != 0;

END TRANSACTION;
