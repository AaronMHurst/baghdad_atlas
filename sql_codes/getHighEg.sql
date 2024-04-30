/*****************************************************************************
   Only retrieve high-energy gamma lines where Eg >= 3000 keV; order by 
   descending gamma-ray energy.  Count the gammas.
*****************************************************************************/

BEGIN TRANSACTION;

SELECT nuc_symb AS "target sample", residual, energy_gamma AS "E [keV]",
       d_energy_gamma AS "dE [keV]", intensity_gamma AS "BR",
       d_intensity_gamma AS "dBR"
       FROM nucleus 
       WHERE energy_gamma >= 3000.0
       ORDER BY energy_gamma DESC;

SELECT COUNT(energy_gamma) AS "No. high-energy gammas:"
       FROM nucleus 
       WHERE energy_gamma >= 3000.0;

END TRANSACTION;
