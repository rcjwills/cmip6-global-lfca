# cmip6-global-lfca
Code and processed CMIP6 data associated with Wills et al. (2021, J. Climate, https://atmos.uw.edu/~rcwills/papers/2021_Wills_etal_global_variability.pdf), as well as an example of how to apply low-frequency component analysis (LFCA) to an ensemble of climate model simulations. 

This repository contains the Matlab script cmip6_global_lfca_figures.m to create most figures in Wills et al. (2021, J. Climate). This requires the contents of the tools folder. The multi-taper spectra and coherence analysis scripts from Peter Huybers are also required for some figures and should be downloaded separately: https://www.people.fas.harvard.edu/~phuybers/Mfiles/. 

Pre-processed data from the final 400-years of 35 different CMIP6 models' pre-industrial control runs is included in two .mat files, including the six LFCs/LFPs used in Wills et al. (2021, J. Climate), global-mean surface temperature (GMST), global-mean TOA radiative imbalance (GMTOA), Nino3.4, and the traditional PDO and AMO indices. 

Update on May 18, 2022: The included LFCs have been updated, because the LFCs in the original publication were not detrended as intended. See updated figures in the Corrigendum to Wills et al. 2021: https://atmos.uw.edu/~rcwills/papers/2021_Wills_etal_global_variability_Corrigendum.pdf. 

The 'Ensemble_LFCA_example' folder provides a cleaned up example of how to run LFCA on an ensemble of CMIP6 piControl simulations (in Matlab). This example requires that you download the CMIP6 piControl SST anomalies from https://atmos.uw.edu/~rcwills/data/cmip6_picontrol_3monthly_sst_all.mat. The results of this example are slightly different from the results in Wills et al. (2021) due to the use of lower spatial and temporal resolution.

A simpler example of how to apply LFCA to a single dataset (in Matlab or Python) can be found at https://github.com/rcjwills/lfca.

Please contact Robert Jnglin Wills (rcwills@uw.edu) with any inquiries. 
