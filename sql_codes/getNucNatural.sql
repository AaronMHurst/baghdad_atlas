/*****************************************************************************
   List of energies and corresponding residual nucleus in defined natural
   sample.  Counts number of lines in specific residual queried in transaction.
*****************************************************************************/

PRAGMA temp_store = 2; /* store temporary table in memory, not on disk */

BEGIN TRANSACTION;

/*For Linux use the following library:*/
SELECT load_extension('../UDF/sqlite-amalgamation/libsqlitefunctions.so');

/*For Mac OS X use the following library:*/
/*SELECT load_extension('../UDF/sqlite-amalgamation/libsqlitefunctions.dylib');*/

SELECT nucleus.residual AS "Residual",
       nucleus.energy_gamma AS " E_gamma [keV] "
       FROM nucleus
       WHERE nucleus.nuc_symb = 'Ti' AND nucleus.nuc_Z = 22;

SELECT COUNT(nucleus.energy_gamma) AS "No. gammas:" 
       FROM nucleus
       WHERE nucleus.nuc_symb = 'Ti' AND nucleus.nuc_Z = 22
       AND nucleus.residual = '49Ti';

SELECT nucleus.residual AS "Residual",
       nucleus.energy_gamma AS " E_gamma [keV] "
       FROM nucleus
       WHERE nucleus.nuc_symb = 'Ti' AND nucleus.nuc_Z = 22
       AND nucleus.residual = '49Ti';

END TRANSACTION;
