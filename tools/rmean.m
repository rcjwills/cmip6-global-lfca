function [series_mean] = rmean(series,timesteps,option)

% smooths series by taking running average with width timesteps

if nargin > 2 && strfind(option,'same')
    % keep running mean the same dimension as original data by by adding 
    % zeros to the either end of the timeseries
    series_mean = conv(series,ones(1,timesteps)/timesteps,'same');
end

% ordinary running mean
series_mean = filter(ones(1,timesteps)/timesteps,1,series);
series_mean = series_mean(timesteps:end);

