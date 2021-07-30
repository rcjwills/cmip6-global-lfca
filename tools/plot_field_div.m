function [h] = plot_field_div(lon,lat,field,ctrs,filter,cmap,nan_mask)

edge_darkening = 0.7;

field = squeeze(field);

%colors = {[0.6 0 0] [1 0.5 0] [0 0.6 1] [0 0 0.6]}; %red-blue
%colors = {[0 0 0.6] [0 0.6 1] [1 0.5 0] [0.6 0 0]}; %blue-red
colors = {[0 0 0.55] [0 0.6 1] [1 0.55 0] [0.55 0 0]}; %blue-red
%colors = {[13 87 150]/256 [72 153 199]/256 [168 210 228]/256 [248 162 52]/256 [223 57 41]/256 [146 27 30]/256}; % alternate blue-red
%colors = {[13 87 150]/256 [72 153 199]/256 [168 210 228]/256 [210 228 239]/256 [251 230 145]/256 [248 162 52]/256 [223 57 41]/256 [146 27 30]/256}; % alternate blue-red
%colors = {[183 106 41]/256 [225 165 100]/256 [245 224 158]/256 [164 213 169]/256 [110 170 200]/256 [7 57 87]/256}; %precip

if nargin > 4
    try
        field = conv2(field,filter,'same');
    catch
        if ~strcmp(filter,'none')
            disp('Warning: unable to inerpret input filter, no filtering applied')
        end
    end
end

if nargin > 6
    field(nan_mask) = nan;
end

if nargin < 4
    ctrs = linspace(nanmin(nanmin(field)),nanmax(nanmax(field)),21);
end

if abs(max(lon)-min(lon)-360)<5
    if size(lon,1) == 1
        lon = [lon, lon(1:end/2)+360];
    else
        lon = [lon; lon(1:end/2)+360];
    end
    field = [field; field(1:end/2,:)];
end

field(field<ctrs(1)) = ctrs(1);

lcmap = length(ctrs)-1;
ch = [min(ctrs) max(ctrs)];

figure; [~,h] = contourf(lon,lat',field',ctrs,'linestyle','none'); colorbar; 
%cmap = colormap(jet(lcmap)); 
caxis(ch); 
if nargin > 5
    if ~ischar(cmap)
        colormap(cmap);
    elseif strcmp(cmap,'diverging')
        cmap = colormap(diverging0(colors,[1 1 1],lcmap));
    else
        cmap = colormap(white0(colors,[1 1 1],lcmap));
    end
else
    cmap = colormap(white0(colors,[1 1 1],lcmap));
    %cmap = colormap(diverging0(colors,[1 1 1],lcmap));
    %cmap = colormap(coldwarm_white(lcmap));
end
hold on;
for i = 1:length(cmap)/2
    hold on; contour(lon,lat',field',[ctrs(i) ctrs(i)],'LineColor',cmap(i,:)*edge_darkening);
end
for i = length(cmap)/2+1:length(cmap)
    if sum(cmap(i,:)==1)~=3
        hold on; contour(lon,lat',field',[ctrs(i) ctrs(i)],'LineColor',cmap(i,:)*edge_darkening);
    end
end
%if round(length(lon)/length(lat)) == 2
if max(lat) > 80 && max(lat) < 90 && min(lat) < -80 && min(lat) > -90 && min(lon) >= 0
    pretty_figure(600,250,'none','none',30:30:330,-90:30:90,16,{'','','90°E','','','180°','','','90°W','',''},{'','60°S','30°S','EQ','30°N','60°N',''});
elseif max(lat) > 80 && max(lat) < 90 && min(lat) < -80 && min(lat) > -90 && min(lon) < 0
    pretty_figure(600,250,'none','none',-150:30:150,-90:30:90,16,{'','','90°W','','','0°','','','90°E','',''},{'','60°S','30°S','EQ','30°N','60°N',''});
else
    pretty_figure(600,250,'none','none','none','none',16);
end