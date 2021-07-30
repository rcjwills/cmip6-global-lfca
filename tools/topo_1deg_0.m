
load topo_1deg.mat
hold on;
map_lon = [map_lon(181:360)-360, map_lon, map_lon(1:180)+360];
map_flip = [map(1:180,:); map(181:360,:); map(1:180,:); map(181:360,:)];
contour(map_lon,map_lat',map_flip',[0 0],'color',[0.4 0.4 0.4],'linewidth',2)
%contour(map_lon,map_lat',map_flip',[0 0],'k','linewidth',2)
%contour(map_lon,map_lat',map',[0 0],'k','linewidth',2)
%contour(map_lon-180,map_lat',map',[0 0],'k','linewidth',2)