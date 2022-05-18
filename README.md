# cmip6-global-lfca
Code and processed CMIP6 data associated with Wills et al. (2021, J. Climate)

For a cleaned up example of how to run LFCA (in Matlab or Python), please see https://github.com/rcjwills/lfca.

This repository contains the Matlab script cmip6_global_lfca_figures.m to create most figures in Wills et al. (2021, J. Climate). This requires the contents of the tools folder. The multi-taper spectra and coherence analysis scripts from Peter Huybers are also required for some figures and should be downloaded separately: https://www.people.fas.harvard.edu/~phuybers/Mfiles/. 

Pre-processed data from the final 400-years of 35 different CMIP6 models' pre-industrial control runs is included in two .mat files, including the six LFCs/LFPs used in Wills et al. (2021, J. Climate), global-mean surface temperature (GMST), global-mean TOA radiative imbalance (GMTOA), Nino3.4, and the traditional PDO and AMO indices. 

Update on May 18, 2022: The included LFCs have been updated, because the LFCs in the original publication were not detrended as intended. See updated figures in the Corrigendum to Wills et al. 2021: https://atmos.uw.edu/~rcwills/papers/2021_Wills_etal_global_variability_Corrigendum.pdf. 

Cleaned-up scripts demonstrating how to apply LFCA on an ensemble of CMIP data will be updated by the end of May 2022.

Please contact Robert Jnglin Wills (rcwills@uw.edu) with any inquiries. 
