/* Script to calculate (n,n'g) cross sections and associated uncertainties
   for natural Fe measurement */

BEGIN TRANSACTION;

/*For Linux use the following library:*/
SELECT load_extension('../UDF/sqlite-amalgamation/libsqlitefunctions.so');

/*For Mac OS X use the following library:*/
/*SELECT load_extension('../UDF/sqlite-amalgamation/libsqlitefunctions.dylib');*/

SELECT nucleus.nuc_symb AS "target", nucleus.residual, 
       nucleus.energy_gamma AS " E [keV] ", nucleus.d_energy_gamma 
       AS " dE [keV] ", nucleus.intensity_gamma AS " BR ", 
       nucleus.d_intensity_gamma AS " dBR ",
       ((nucleus.intensity_gamma/100.0) * sample.N * (143.0/100.0)) 
       AS "cross section [mb]",
       ((nucleus.intensity_gamma/100.0) * sample.N * (143.0/100.0))
       * sqrt( square(nucleus.d_intensity_gamma/nucleus.intensity_gamma) 
               + square((143.0*sample.dN)/(143.0*sample.N)) 
	       + square(0.290/1.430))
       AS "error cs [mb]"
       FROM nucleus, sample
       WHERE nucleus.nuc_Z = 26
       AND nucleus.nuc_Z = sample.Z;

END TRANSACTION;
