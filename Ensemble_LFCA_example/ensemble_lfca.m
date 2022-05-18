function [LFCs, LFPs, fingerprints, r, pvar, pcs, EOF, N, pvar_LFPs] = ensemble_lfca(X, ne, cutoff, truncation, scale, Covtot)

%% Truncated Forced Analysis Analysis
%     [TK,FPS,FINGERPRINTS,S,PVAR,PCS,EOF,N,PVAR_FPS,S_EOFS] = ensemble_lfca(X,cutoff,TRUNCATION,SCALE,COVTOT)
%     performs low-frequency component analysis (see Wills et al. 2018, 2019) 
%     on the data in matrix X based on a the ratio of low-frequency variance
%     to total variance, where low-frequency variance is defined as
%     variance on periods longer than that specified by cutoff (in number
%     of months when X is monthly data).

%% INPUT
%     X is a 2D data matrix with time variantions along the first dimension
%     and spatial variations along the second dimension. Ensemble members
%     are concatenated in time.
%
%     NE is the number of ensemble members, which is used to lowpass filter
%     each ensemble member separately
%
%     CUTOFF is the number of timesteps that define the cutoff for the
%     lowpass filter
%
%     TRUNCATION is the number of principal components / EOFs to include in
%     the analysis, or (if less than 1) the fraction of variance to retain
%
%     SCALE (optional) a scale vector, which for geospatial data should be 
%     equal to the square root of grid cell area. The default value is one  
%     for all grid points.
%
%     COVTOT (optional) the covariance matrix associated with the data in
%     X. If not specified, COVTOT will be computed from X.

%% OUTPUT

%     FINGERPRINTS is a matrix containing the canonical weight vectors as
%     columns. LFPs is a matrix containing the dual vectors of the
%     canonical weight vectors as rows. These are the so-called low-frequency 
%     patterns (LFPs). LFCs is a matrix containing the time series of these
%     patterns (as columns). S is a vector measuring the ratio of ensemble-mean
%     signal to total variance for each forced pattern
%
%     PVAR is the percentage of total sample variation accounted for
%     by each of the EOFs. PCS is a matrix containing the principal
%     component time series as columns. EOF is a matrix containing the
%     EOFs, the principal component patterns, as rows. The scalar N
%     is the rank at which the PCA was truncated.
%
%     R is a vector containing the ratio of low-frequency signal to total
%     variance for each low-frequency pattern
%
%     PVAR_LFPS is a vector of the variance associated with 
%     each low-frequency pattern as a fraction of the total variance. Note that
%     the LFPs are not orthogonal, so these values need not add to the
%     total variance in the first N principal components.
%
%     S_EOFS and PVAR are equivalent to S and PVAR_FPS respectively, but 
%     for the original EOFs.

  narginchk(4,6)          % check number of input arguments 
  if ndims(X) ~= 2,  error('Data matrix must be 2-D.'); end

  disp(sprintf('\nEnsemble Low-Frequency Component Analysis:'))

  [n,p]         = size(X);
  nt = n./ne;
  
  % center data 
  if any(any(isnan(X)))               % there are missing values in x
    Xm  = nanmean(X);
  else                                % no missing values
    Xm  = mean(X);
  end
  X    = X - repmat(Xm, n, 1);  
      
  %% compute covariance matrix
  if nargin < 6
    % compute sample covariance if covariance is not specified
    Covtot               = cov(X);
  end
  if any(size(Covtot) ~= [p, p])
    error('Covariance matrix must have same dimension as data.')
  end
  
  %% scale vector (e.g. square root of normalized grid-cell area)
  if nargin > 4
    scale       = scale(:)';
    if length(scale) ~= p
      error('Scale vector must have same dimension as data.')
    end
    Xs           = X .* repmat(scale,n,1);
  else
    scale       = ones(1,p);
    Xs          = X;
  end
  clear X
  
  %% eigendecomposition of covariance matrix
  Covtot      = repmat(scale',1,p) .* Covtot .* repmat(scale,p,1);
  [pcvec,evl,rest] = peigs(Covtot, min(n-1, p));
  trCovtot    = trace(Covtot);
  
  % percent of total sample variation accounted for by each EOF
  pvar          = evl./trCovtot .* 100;
  % principal component time series
  pcs           = Xs*pcvec;
  % return EOFs in original scaling as patterns (row vectors)
  EOF           = pcvec' ./ repmat(scale,rest,1);
  
  %% truncation of EOFs
  if truncation < 1 
      % using basic % variance criterion, where truncation gives the
      % fraction of variance to be included in the EOF truncation
      truncation = truncation*100;
      cum_pvar = cumsum(pvar);
      N = find(abs(cum_pvar-truncation) == min(abs(cum_pvar-truncation)),1,'first');
      disp(sprintf('\tChosen truncation level: %3i', N))
  else
      if (truncation-round(truncation))~=0
          error('Truncation must be fraction of total variance included in EOF truncation or integer number of EOFs.')
      end
      % using specified truncation level
      N = truncation;
      disp(sprintf('\tUsing specified truncation level: %3i', N))
  end
  
  % this section can be modified to use a specific EOF truncation
  % criterion, right now the truncation number is specified as input
  % TRUNCATION
  
  %% Whitening transformation
  % multiplication factor for principal components in whitening
  % transformation (such that they have unit variance)
  f             = sqrt(evl(1:N));
  
  % get transformation matrices that transform original variables to
  % whitened variables and back
  S		= pcvec(:, 1:N) * diag(1./f);
  Sadj	        = diag(f) * pcvec(:, 1:N)';
  
  %% whiten variables [such that cov(Y) = I * n/(n-1)]
  Y		= Xs * S;
  
  %% filter whitened data matrix (separately for each ensemble member)
  % Lanczos lowpass filter after detrending (CUTOFF is in number of timesteps, reflected boundary conditions)
  Y_f = Y;
  t = 1:nt; t = t';
  for j = 1:ne
      js = (j-1)*nt+1:j*nt;
      Y_cut = Y(js,:);
      for i = 1:size(Y_cut,2)
          p = polyfit(t,Y_cut(:,i),1);
          tmp = Y_cut(t,i)-p(1)*t-p(2);
          tmp = lanczos([flipud(tmp); tmp; flipud(tmp)],1,cutoff);
          Y_f(js,i) = tmp((end/3+1):2*end/3)+p(1)*t+p(2);
      end
  end
  
  % Simple Lanczos lowpass filter (periodic boundary conditions)
  %X_f = lanczos(Xs,1,cutoff);
  
  % OR INSERT ALTERNATE FILTER HERE
  
  % Added options for highpass filter
  %X_f = lanczos(X_lp,1,cutoff,[],'high');
  
  % Bandpass filter
  %X_f = lanczos(X,1,cutoff1);
  %X_f = lanczos(X_f,1,cutoff2,[],'high');
  
  % A simple running mean filter with zeros on the edges
  %X_f = X;
  %for i = 1:size(X,2)
  %    X_f(cutoff/2:end-cutoff/2,i) = rmean(X(:,i),cutoff);
  %end
  
  %% slow covariance matrix of whitened variables
  % (i.e. covariance matrix of filtered and whitened principal components)
  Gamma = cov(Y_f);

  %% SVD of slow covariance matrix (such that r are eigenvalues and V are eigenvectors)
  [~, r, V]	= csvd(Gamma);

  %% fingerprint patterns (canonical vectors) and forced patterns (FPs) in original scaling
  % Note: canonical vectors are called u_k in Wills et al. (2020)
  fingerprints	= repmat(scale', 1, N) .* (S * V);       % weights are columns
  LFPs	= (V' * Sadj) ./ repmat(scale, N, 1);    % patterns are rows 
  
  % choose signs of patterns, weights, eofs, and pcs such that the
  % scalar product of the vectors and the scale vector is positive
  for j=1:size(LFPs, 1)
    if LFPs(j, :)*scale' < 0
      LFPs(j, :) = -LFPs(j, :);
      fingerprints(:, j)  = -fingerprints(:, j);
    end
  end
  
  for j=1:size(EOF, 1)
    if EOF(j, :)*scale' < 0
      EOF(j, :)  = -EOF(j, :);
      pcs(:, j)  = -pcs(:, j);
    end
  end
  
%% timeseries (tk)
  
if nargin > 4
    Xs = Xs./repmat(scale,n,1);
end

LFCs = Xs * fingerprints;

%% fraction of variance in forced patterns

w = fingerprints./repmat(scale', 1, N);
p = LFPs.*repmat(scale, N, 1);

tot_var = diag(p*Covtot*w)./diag(p*w);

pvar_LFPs = tot_var./trCovtot*100;
  