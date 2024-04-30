/*****************************************************************************
  Retrieve all 56Fe levels coupled to the first 2+ excited state around
  847 keV; define excitation-energy window 840<delta<850
*****************************************************************************/

BEGIN TRANSACTION;

SELECT nuc_symb AS "nucleus", energy_gamma AS "E_gamma", 
       intensity_gamma AS "BR", energy_ex, residual AS "product", 
       (energy_ex-energy_gamma) AS "delta" FROM nucleus
       WHERE nuc_Z=26 AND (residual='56Fe' OR residual='58Fe')
       AND (delta > 840.0 AND delta < 850.0) 
       OR (energy_gamma > 846 AND energy_gamma < 847
       AND (residual='56Fe' OR residual='58Fe') )
       ORDER BY energy_ex ASC;

END TRANSACTION;
