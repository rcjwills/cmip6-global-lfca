load('cmip6_picontrol_3monthly_sst_all.mat') % dowload from https://atmos.uw.edu/~rcwills/data/cmip6_picontrol_3monthly_sst_all.mat
nlon = size(cmip6_picontrol_3monthly_sst,1);
nlat = size(cmip6_picontrol_3monthly_sst,2);
n = size(cmip6_picontrol_3monthly_sst,3); 
ne = size(cmip6_picontrol_3monthly_sst,4);

% Description of preprocessing: SST data from all models has been been linearly
% interpolated to the current ~4° resolution and the climatological
% seasonal cycle has been removed from each simulation, such that these 
% data are 3-month average anomalies from the JFM, AMJ, JAS, and OND means. 
% The data have also been linearly detrended over the 400 years of each
% simulation to remove drift in the piControl runs. 

%% Parameters

truncation = 40; % number of EOFs 
% Note: less EOFs are used for the 4° resolution SST data to capture approx. the same amount of variance as 65 EOFs do for the 2° resolution SST data in Wills et al. 2021

cutoff = 120; % 120 months = 10-year lowpass filter

%% Preprocessing

% reshape data
cmip6_picontrol_3monthly_sst = reshape(cmip6_picontrol_3monthly_sst,[nlon nlat n*ne]); % concatenate ensemble members in time
r = size(cmip6_picontrol_3monthly_sst);

[Y,~] = meshgrid(lat,lon);
area = cos(Y*pi/180);
area(isnan(mean(cmip6_picontrol_3monthly_sst,3))) = 0; % this line will ignore grid points that have NaNs

domain = ones(size(area));

% Can specify sub-domains to analyze using the following form:

% % Pacific domain
% domain(X<100) = 0;
% domain(X<103 & Y<5) = 0;
% domain(X<105 & Y<2) = 0;
% domain(X<111 & Y<-6) = 0;
% domain(X<114 & Y<-7) = 0;
% domain(X<127 & Y<-8) = 0;
% domain(X<147 & Y<-18) = 0;
% domain(Y>70) = 0;
% domain(Y>65 & (X<175 | X>200)) = 0;
% domain(Y<-45) = 0;
% domain(X>260 & Y>17) = 0;
% domain(X>270 & Y<=17 & Y>14) = 0;
% domain(X>276 & Y<=14 & Y>9) = 0;
% domain(X>290 & Y<=9) = 0;

X = reshape(cmip6_picontrol_3monthly_sst,r(1)*r(2),r(3))';
AREA_WEIGHTS = reshape(area,r(1)*r(2),1)';
domain = reshape(domain,r(1)*r(2),1)';

% icol_ret and icol_disc help reconstruct the data onto the original grid
icol_ret = find(AREA_WEIGHTS~=0 & domain);
icol_disc = find(AREA_WEIGHTS==0 | ~domain);
X = X(:,icol_ret);
AREA_WEIGHTS = AREA_WEIGHTS(icol_ret);

% scale by square root of grid cell area such that covariance is area
% weighted
normvec          = AREA_WEIGHTS' ./ sum(AREA_WEIGHTS);
scale    = sqrt(normvec);

%% Calculate forced patterns / Signal-to-noise maximizing EOF analysis
[LFCs, LFPs, fingerprints, r, pvar, pcs, EOFs, N, pvar_LFPs] = ensemble_lfca(X, ne, cutoff, truncation, scale);
LFPs       = insert_cols(LFPs, icol_ret, icol_disc);
EOFs       = insert_cols(EOFs, icol_ret, icol_disc);
fingerprintsf        = insert_rows(fingerprints, icol_ret, icol_disc);

%% Regional pattern rotation

% Used in main paper with 2° resolution data
% LFPsr(1:3,:) = LFPs(1:3,:); LFCsr(:,1:3) = LFCs(:,1:3);
% [LFPsr(4:6,:),LFCsr(:,4:6)] = regional_pattern_decorrelation_rotation(LFPs(4:6,:),LFCs(:,4:6),{'Atlantic_exp','Pacific_20-70N','Southern_Ocean'},LON_AXIS,LAT_AXIS,icol_ret,icol_disc);

% Modification for 4° resolution data to get similar answers
LFPsr(1:2,:) = LFPs(1:2,:); LFCsr(:,1:2) = LFCs(:,1:2);
[LFPsr(3:6,:),LFCsr(:,3:6)] = regional_pattern_decorrelation_rotation(LFPs(3:6,:),LFCs(:,3:6),{'Atlantic_exp','Pacific_20-70N','Southern_Ocean'},lon,lat,icol_ret,icol_disc);

tmp1 = LFPsr(4,:); tmp2 = LFCsr(:,4); LFPsr(4,:) = LFPsr(6,:); LFCsr(:,4) = LFCsr(:,6); LFPsr(6,:) = tmp1; LFCsr(:,6) = tmp2; % switch LFP-4 and LFP-6

%% plot Low-Frequency Patterns 

ndisc = 1; plot_ensemble_patterns(LFCsr,LFPsr,ndisc,1600,0,lon,lat,linspace(-0.8,0.8,25));
ndisc = 2; plot_ensemble_patterns(LFCsr,LFPsr,ndisc,1600,0,lon,lat,linspace(-0.8,0.8,25));
ndisc = 3; plot_ensemble_patterns(LFCsr,LFPsr,ndisc,1600,0,lon,lat,linspace(-0.8,0.8,25));
ndisc = 4; plot_ensemble_patterns(LFCsr,LFPsr,ndisc,1600,0,lon,lat,linspace(-0.8,0.8,25));
ndisc = 5; plot_ensemble_patterns(LFCsr,LFPsr,ndisc,1600,0,lon,lat,linspace(-0.8,0.8,25));
ndisc = 6; plot_ensemble_patterns(LFCsr,LFPsr,ndisc,1600,0,lon,lat,linspace(-0.8,0.8,25));

