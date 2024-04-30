/*****************************************************************************
   Script to calculate (n,n'g) cross sections and associated uncertainties
   for enriched 162Dy measurement using "global variables" to define the
   cross-section standardization methodology.  Count number of gammas.
*****************************************************************************/

PRAGMA temp_store = 2; /* store temporary table in memory, not on disk */

BEGIN TRANSACTION;

/*For Linux use the following library:*/
SELECT load_extension('../UDF/sqlite-amalgamation/libsqlitefunctions.so');

/*For Mac OS X use the following library:*/
/*SELECT load_extension('../UDF/sqlite-amalgamation/libsqlitefunctions.dylib');*/

CREATE TEMP TABLE _Variables(
       Name TEXT PRIMARY KEY,
       FeCS FLOAT,
       FeRatio FLOAT,
       d_FeCS FLOAT,
       d_FeRatio FLOAT,
       RI FLOAT
);

INSERT OR REPLACE INTO _Variables VALUES ('Constant', 143.0, 1.430, 29.0, 0.290, 100.0);

SELECT sample.symbol AS "target", nucleus.sample, nucleus.residual,
       nucleus.energy_gamma AS " E [keV] ", nucleus.d_energy_gamma 
       AS " dE [keV] ", nucleus.intensity_gamma AS " BR ", 
       nucleus.d_intensity_gamma AS " dBR ",
       ((nucleus.intensity_gamma/_Variables.RI) * sample.N 
       * _Variables.FeRatio)
       AS "cross section [mb]",
       ((nucleus.intensity_gamma/_Variables.RI) * sample.N 
       * _Variables.FeRatio)
       * sqrt(square(nucleus.d_intensity_gamma/nucleus.intensity_gamma) 
       	      + square((_Variables.FeCS*sample.dN)/(_Variables.FeCS*sample.N)) 
	      + square(_Variables.d_FeRatio/_Variables.FeRatio))
       AS "error cs [mb]" 
       FROM nucleus, sample, _Variables
       WHERE sample.A = 110 AND sample.Z = 46
       AND nucleus.nuc_Z = sample.Z
       AND nucleus.sample = 'E'
       AND nucleus.nuc_symb = '110Pd'
       AND nucleus.energy_gamma >= 300 AND nucleus.energy_gamma <= 1000;

SELECT COUNT(energy_gamma) AS "No. enriched 110Pd gammas:" 
       FROM nucleus
       WHERE nucleus.sample = 'E' AND nucleus.nuc_symb = '110Pd';

DROP TABLE _Variables;

END TRANSACTION;
