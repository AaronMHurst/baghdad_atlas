/*****************************************************************************
  Retrieve all 56Fe levels coupled to the 0+ ground state
*****************************************************************************/

BEGIN TRANSACTION;

SELECT nuc_symb AS "nucleus", energy_gamma AS "E_gamma", 
       intensity_gamma AS "BR", d_intensity_gamma AS "dBR", energy_ex, residual AS "product", 
       (energy_ex-energy_gamma) AS "delta" FROM nucleus
       WHERE nuc_Z=26 AND (residual='56Fe' OR residual='56Fe,54Fe')
       AND (delta > -2.0 AND delta < 2.0) 
       ORDER BY energy_ex ASC;

END TRANSACTION;
