/*****************************************************************************
   Script to display meta data from 'sample' relational table. 
*****************************************************************************/

BEGIN TRANSACTION;

SELECT element AS "Element/Isotope", Z, A, enrichment, N, dN, isotope_norm
       AS "Normalization Isotope", e_gamma_norm AS "Normalization Gamma"
       FROM sample;

END TRANSACTION;
