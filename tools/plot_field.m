function [h,hc] = plot_field(lon,lat,field,ctrs,cmap,filter)

%edge_darkening = 0.6;
edge_darkening = 0.7;

field = squeeze(field);

%colors = {[0 0 1] [0 0.5 1] [1 0.5 0] [0.75 0 0]}; %blue-red
%colors = {[0.6 0 0] [1 0.5 0] [0 0.6 1] [0 0 0.6]}; %red-blue
%colors = {[13 87 150]/256 [72 153 199]/256 [168 210 228]/256 [248 162 52]/256 [223 57 41]/256 [146 27 30]/256}; % alternate blue-red
colors = {[13 87 150]/256 [72 153 199]/256 [168 210 228]/256 [210 228 239]/256 [251 230 145]/256 [248 162 52]/256 [223 57 41]/256 [146 27 30]/256}; % alternate blue-red
%colors = {[13 87 150]/256 [49 123 184]/256 [72 153 199]/256 [168 210 228]/256 [210 228 239]/256 [251 230 145]/256 [248 162 52]/256 [223 57 41]/256 [189 34 39]/256 [146 27 30]/256}; % alternate blue-red

if nargin > 5
    try
        field = conv2(field,filter,'same');
    catch
        disp('No filtering applied')
    end
end

if nargin < 4
    ctrs = linspace(min(min(field)),max(max(field)),20);
end

if abs(max(lon)-min(lon)-360)<5
    if size(lon,1) == 1
        lon = [lon, lon(1:end/2)+360];
    else
        lon = [lon; lon(1:end/2)+360];
    end
    field = [field; field(1:end/2,:)];
end

field(field<min(ctrs)) = min(ctrs);

lcmap = length(ctrs)-1;
ch = [min(ctrs)-1e-8 max(ctrs)];
 
figure; [~,h] = contourf(lon,lat',field',ctrs,'linestyle','none'); hc = colorbar; 
caxis(ch); 
% if nargin > 4
%     colormap(cmap);
% elseif lcmap == 15
%     load('/Users/willsr/Documents/Research/Climate_analysis/CMAPS/jet_15.mat');
%     colormap(cmap);
% elseif lcmap == 12
%     load('/Users/willsr/Documents/Research/Climate_analysis/CMAPS/light_jet_12.mat');
%     colormap(cmap);
% else
%    cmap = colormap(parula(lcmap));
    if nargin > 4
        colormap(cmap);
    else
%        cmap = colormap(diverging0(colors,[1 1 1],lcmap));
%    else
        cmap = colormap(white0(colors,[1 1 1],lcmap));
    end
% end
%cmap = colormap(flipud(hot(lcmap)));
%cmap = colormap(white0(colors,[1 1 1],lcmap));

hold on;
if min(ctrs) == -max(ctrs)
    for i = 1:length(cmap)/2
        hold on; contour(lon,lat',field',[ctrs(i) ctrs(i)],'LineColor',cmap(i,:)*edge_darkening);
    end
    for i = length(cmap)/2+1:length(cmap)
        if sum(cmap(i,:)==1)~=3
            hold on; contour(lon,lat',field',[ctrs(i) ctrs(i)],'LineColor',cmap(i,:)*edge_darkening);
        end
    end
else
    for i = 1:length(cmap)
        if sum(cmap(i,:)==1)~=3
            hold on; contour(lon,lat',field',[ctrs(i) ctrs(i)],'LineColor',cmap(i,:)*edge_darkening);
        end
    end
end

%if round(length(lon)/length(lat)) == 2

if max(lat) > 60 && max(lon) > 200 && max(lat) < 100
    pretty_figure(600,250,'none','none',45:45:315,-90:30:90,16,{'','90°E','','180°','','90°W',''},{'','60°S','30°S','EQ','30°N','60°N',''});
elseif max(lon) > 30 && max(lon) < 40
    pretty_figure(600,250,'none','none',-30:10:50,30:5:70,16,{'30°W','','10°W','','10°E','','30°E'},{'30°N','','40°N','','50°N','','60°N','','70°N'});
else
    pretty_figure(600,250,'none','none','none','none',16);
end

set(gca,'color',[0.8 0.8 0.8])

set(gcf,'renderer','painters')