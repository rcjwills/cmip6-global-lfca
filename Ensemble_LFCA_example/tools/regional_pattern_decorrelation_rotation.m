function [LFPsr,LFCsr] = regional_pattern_decorrelation_rotation(LFPs,LFCs,regions,LON_AXIS,LAT_AXIS,icol_ret,icol_disc)

[Y,X] = meshgrid(LAT_AXIS,LON_AXIS);
area = cos(Y*pi/180);
area(icol_disc) = 0;
s = size(area);

Gamma = 0;

for i = 1:length(regions)
    region = regions{i};

    switch region
        case 'Pacific'
            domain = ones(size(area));
            domain(X<100) = 0;
            domain(X<103 & Y<5) = 0;
            domain(X<105 & Y<2) = 0;
            domain(X<111 & Y<-6) = 0;
            domain(X<114 & Y<-7) = 0;
            domain(X<127 & Y<-8) = 0;
            domain(X<147 & Y<-18) = 0;
            domain(Y>70) = 0;
            domain(Y>65 & (X<175 | X>200)) = 0;
            domain(Y<-45) = 0;
            domain(X>260 & Y>17) = 0;
            domain(X>270 & Y<=17 & Y>14) = 0;
            domain(X>276 & Y<=14 & Y>9) = 0;
            domain(X>290 & Y<=9) = 0;
            
            domain = reshape(domain,s(1)*s(2),1)';
            domain(icol_disc) = 0;
            
        case 'Pacific_30S-70N'
            domain = ones(size(area));
            domain(X<100) = 0;
            domain(X<103 & Y<5) = 0;
            domain(X<105 & Y<2) = 0;
            domain(X<111 & Y<-6) = 0;
            domain(X<114 & Y<-7) = 0;
            domain(X<127 & Y<-8) = 0;
            domain(X<147 & Y<-18) = 0;
            domain(Y>70) = 0;
            domain(Y>65 & (X<175 | X>200)) = 0;
            domain(Y<-30) = 0;
            domain(X>260 & Y>17) = 0;
            domain(X>270 & Y<=17 & Y>14) = 0;
            domain(X>276 & Y<=14 & Y>9) = 0;
            domain(X>290 & Y<=9) = 0;
            
            domain = reshape(domain,s(1)*s(2),1)';
            domain(icol_disc) = 0;
            
        case 'Atlantic_exp'
            domain = ones(size(area));
            domain(Y>85) = 0;
            domain(Y<-45) = 0;
            domain(X<260 & X>60 & Y>17) = 0;
            domain(X<270 & X>36 & Y<=17 & Y>14) = 0;
            domain(X<276 & X>36 & Y<=14 & Y>9) = 0;
            domain(X<290 & X>24 & Y<=9) = 0;
            
            domain = reshape(domain,s(1)*s(2),1)';
            domain(icol_disc) = 0;
            
        case 'Atlantic'
            domain = ones(size(area));
            domain(Y>85) = 0;
            domain(Y<0) = 0;
            domain(X<260 & X>60 & Y>17) = 0;
            domain(X<270 & X>36 & Y<=17 & Y>14) = 0;
            domain(X<276 & X>36 & Y<=14 & Y>9) = 0;
            domain(X<290 & X>24 & Y<=9) = 0;
            
            domain = reshape(domain,s(1)*s(2),1)';
            domain(icol_disc) = 0;
            
        case 'Pacific_20-70N'
            domain = ones(size(area));
            domain(X<105) = 0;
            domain(Y>70) = 0;
            domain(Y<20) = 0;
            domain(X>260) = 0;
            domain(Y>65 & (X<175 | X>200)) = 0;
            
            domain = reshape(domain,s(1)*s(2),1)';
            domain(icol_disc) = 0;
            
        case 'Global'
            domain = ones(size(area));
            domain = reshape(domain,s(1)*s(2),1)';
            
        case 'Global_Ocean'
            domain = ones(size(area));
            
            domain = reshape(domain,s(1)*s(2),1)';
            domain(icol_disc) = 0;
            
        case 'Global_Ocean_20-80N'
            domain = ones(size(area));
            
            domain = reshape(domain,s(1)*s(2),1)';
            domain(Y<20) = 0;
            domain(Y>80) = 0;
            domain(icol_disc) = 0;
            
        case 'Southern_Ocean'
            domain = ones(size(area));
            
            domain = reshape(domain,s(1)*s(2),1)';
            domain(Y>-35) = 0;
            domain(icol_disc) = 0;
    end
    
    AREA_WEIGHTS = reshape(area,s(1)*s(2),1)';
    icol_ret_region = find(AREA_WEIGHTS~=0 & domain);
    
    Gamma = Gamma + cov(LFPs(:,icol_ret_region)');
end

AREA_WEIGHTS = AREA_WEIGHTS(icol_ret);
normvec          = AREA_WEIGHTS' ./ sum(AREA_WEIGHTS);
scale    = sqrt(normvec)';

[~, r, V]	= csvd(Gamma);
for j = 1:size(LFPs,1)
    LFPsr(j,:) = V(:,j)'*LFPs;
    LFCsr(:,j) = LFCs*V(:,j);
    if LFPsr(j,icol_ret)*scale' < 0
        LFPsr(j,:) = -LFPsr(j,:);
        LFCsr(:,j) = -LFCsr(:,j);
    end
end