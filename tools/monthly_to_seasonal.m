function [data_seasonal,year_new,correct_season] = monthly_to_seasonal(month,year,data_monthly,months,dim)

% changes monthly timeseries at a single point into seasonal timeseries

if nargin < 5
    dim = 0;
end

year_new = year(1):year(end);

if month(1) == 12 % models where file begins with December
    year_new = year(2):year(end);
    year(1:12:end) = year(1:12:end)+1;
elseif months(1) == 12  % DJF correction, group D with following year
    year_new = year(1)+1:year(end);
    year(12:12:end) = year(12:12:end)+1;
end

s = size(data_monthly);
switch dim
    case 0
        data_seasonal = zeros(length(year_new),1);
    case 1
        data_seasonal = zeros(length(year_new),s(2));
    case 2
        data_seasonal = zeros(s(1),length(year_new));
    case 3
        data_seasonal = zeros(s(1),s(2),length(year_new));
    case 4
        data_seasonal = zeros(s(1),s(2),s(3),length(year_new));
end

correct_season = zeros(size(month));
for i = 1:length(month)
    correct_season(i) = sum(month(i) == months);
end

for i = 1:length(year_new)
    switch dim
        case 0
        data_seasonal(i) = nanmean(data_monthly(year==year_new(i) & correct_season));
        case 1
        data_seasonal(i,:) = nanmean(data_monthly(year==year_new(i) & correct_season,:),1);
        case 2
        data_seasonal(:,i) = nanmean(data_monthly(:,year==year_new(i) & correct_season),2);
        case 3
        data_seasonal(:,:,i) = nanmean(data_monthly(:,:,year==year_new(i) & correct_season),3);
        case 4
        data_seasonal(:,:,:,i) = nanmean(data_monthly(:,:,:,year==year_new(i) & correct_season),4);
    end
end