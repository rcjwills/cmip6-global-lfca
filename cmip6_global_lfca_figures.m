
version = 'cmip6';
l = 400*12;
        
load('cmip6_piControl_detrends_indices.mat')
load('cmip6_piControl_detrend_Global_Ocean_SST_Monthly_cutoff_120_neofs_65_rotated.mat')

LLFC = LFCs(:,65);
GMTOA = -GMTOA;
rlut_global = -rlut_global;
rsut_global = -rsut_global;
qflux_global = -qflux_global;

%% LFC 1

nyr = 20;

plot_field_div(LON_AXIS,LAT_AXIS,reshape(LFPsr(1,:),[180 87]),linspace(-0.8,0.8,25)); topo_1deg_0; set(gca,'xlim',[0 358]); set(gca,'ylim',[-86 86])
hc = colorbar; set(hc,'ytick',-0.8:0.4:0.8); set(hc,'yticklabel',{'-0.8','-0.4','0','0.4','0.8°C'})

seasonal_crosscov(GMST,LFCsr(:,1),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global Mean Temperature','none','none',16)
set(gca,'ytick',-0.01:0.01:0.05); set(gca,'ygrid','on'); set(gca,'xgrid','on');
set(gca,'ylim',[0 0.06])
[~,xcov_mean] = seasonal_crosscov(rmean(GMST,120),LFCsr(60:end-60,1),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
Tg_rmean_max(1) = max(xcov_mean);

seasonal_crosscov(GMTOA,LFCsr(:,1),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global TOA Radiation (W m^{-2})','none','none',16)
set(gca,'ylim',[-0.04 0.04])
set(gca,'ytick',-0.06:0.02:0.06); set(gca,'ygrid','on'); set(gca,'xgrid','on');
[~,xcov_mean] = seasonal_crosscov(rmean(GMTOA,120),LFCsr(60:end-60,1),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
TOAg_rmean_max(1) = max(xcov_mean);

% LFC 2

plot_field_div(LON_AXIS,LAT_AXIS,reshape(LFPsr(2,:),[180 87]),linspace(-0.8,0.8,25)); topo_1deg_0; set(gca,'xlim',[0 358]); set(gca,'ylim',[-86 86])
hc = colorbar; set(hc,'ytick',-0.8:0.4:0.8); set(hc,'yticklabel',{'-0.8','-0.4','0','0.4','0.8°C'})

[xcov,xcov_mean] = seasonal_crosscov(GMST,LFCsr(:,2),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global Mean Temperature','none','none',16)
set(gca,'ytick',-0.01:0.01:0.05); set(gca,'ygrid','on'); set(gca,'xgrid','on');
set(gca,'ylim',[-0.01 0.05])
[~,xcov_mean] = seasonal_crosscov(rmean(GMST,120),LFCsr(60:end-60,2),nyr,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
Tg_rmean_max(2) = max(xcov_mean);

[xcov,xcov_mean] = seasonal_crosscov(GMTOA,LFCsr(:,2),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global TOA Radiation (W m^{-2})','none','none',16)
set(gca,'ylim',[-0.03 0.05])
set(gca,'ytick',-0.06:0.02:0.06); set(gca,'ygrid','on'); set(gca,'xgrid','on');
[~,xcov_mean] = seasonal_crosscov(rmean(GMTOA,120),LFCsr(60:end-60,2),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
TOAg_rmean_max(2) = max(xcov_mean);

% LFC 3

plot_field_div(LON_AXIS,LAT_AXIS,reshape(LFPsr(3,:),[180 87]),linspace(-0.8,0.8,25)); topo_1deg_0; set(gca,'xlim',[0 358]); set(gca,'ylim',[-86 86])
hc = colorbar; set(hc,'ytick',-0.8:0.4:0.8); set(hc,'yticklabel',{'-0.8','-0.4','0','0.4','0.8°C'})

[xcov,xcov_mean] = seasonal_crosscov(GMST,LFCsr(:,3),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global Mean Temperature','none','none',16)
set(gca,'ytick',-0.01:0.01:0.05); set(gca,'ygrid','on'); set(gca,'xgrid','on');
set(gca,'ylim',[-0.03 0.03])
[~,xcov_mean] = seasonal_crosscov(rmean(GMST,120),LFCsr(60:end-60,3),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
Tg_rmean_max(3) = max(xcov_mean);

[xcov,xcov_mean] = seasonal_crosscov(GMTOA,LFCsr(:,3),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global TOA Radiation (W m^{-2})','none','none',16)
set(gca,'ylim',[-0.05 0.03])
set(gca,'ytick',-0.06:0.02:0.06); set(gca,'ygrid','on'); set(gca,'xgrid','on');
[~,xcov_mean] = seasonal_crosscov(rmean(GMTOA,120),LFCsr(60:end-60,3),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
TOAg_rmean_max(3) = max(xcov_mean);

%% LFC 4

nyr = 20;

plot_field_div(LON_AXIS,LAT_AXIS,reshape(LFPsr(4,:),[180 87]),linspace(-0.8,0.8,25)); topo_1deg_0; set(gca,'xlim',[0 358]); set(gca,'ylim',[-86 86])
hc = colorbar; set(hc,'ytick',-0.8:0.4:0.8); set(hc,'yticklabel',{'-0.8','-0.4','0','0.4','0.8°C'})

seasonal_crosscov(GMST,LFCsr(:,4),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global Mean Temperature','none','none',16)
set(gca,'ytick',-0.01:0.01:0.05); set(gca,'ygrid','on'); set(gca,'xgrid','on');
set(gca,'ylim',[-0.03 0.03])
% set(gca,'ytick',-0.01:0.01:0.05); set(gca,'ygrid','on'); set(gca,'xgrid','on');
% set(gca,'ylim',[-0.01 0.05])
[~,xcov_mean] = seasonal_crosscov(rmean(GMST,120),LFCsr(60:end-60,4),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
Tg_rmean_max(4) = max(xcov_mean);

seasonal_crosscov(GMTOA,LFCsr(:,4),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global TOA Radiation (W m^{-2})','none','none',16)
set(gca,'ylim',[-0.04 0.04])
set(gca,'ytick',-0.06:0.02:0.06); set(gca,'ygrid','on'); set(gca,'xgrid','on');
% set(gca,'ylim',[-0.05 0.06])
% set(gca,'ytick',-0.06:0.02:0.06); set(gca,'ygrid','on'); set(gca,'xgrid','on');
[~,xcov_mean] = seasonal_crosscov(rmean(GMTOA,120),LFCsr(60:end-60,4),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
TOAg_rmean_max(4) = max(xcov_mean);

% LFC 5

plot_field_div(LON_AXIS,LAT_AXIS,reshape(LFPsr(5,:),[180 87]),linspace(-0.8,0.8,25)); topo_1deg_0; set(gca,'xlim',[0 358]); set(gca,'ylim',[-86 86])
hc = colorbar; set(hc,'ytick',-0.8:0.4:0.8); set(hc,'yticklabel',{'-0.8','-0.4','0','0.4','0.8°C'})

seasonal_crosscov(GMST,LFCsr(:,5),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global Mean Temperature','none','none',16)
% set(gca,'ytick',-0.01:0.01:0.05); set(gca,'ygrid','on'); set(gca,'xgrid','on');
% set(gca,'ylim',[-0.01 0.04])
set(gca,'ytick',-0.01:0.01:0.05); set(gca,'ygrid','on'); set(gca,'xgrid','on');
set(gca,'ylim',[-0.01 0.05])
[~,xcov_mean] = seasonal_crosscov(rmean(GMST,120),LFCsr(60:end-60,5),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
Tg_rmean_max(5) = max(xcov_mean);

seasonal_crosscov(GMTOA,LFCsr(:,5),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global TOA Radiation (W m^{-2})','none','none',16)
% set(gca,'ylim',[-0.04 0.06])
% set(gca,'ytick',-0.06:0.02:0.06); set(gca,'ygrid','on'); set(gca,'xgrid','on');
set(gca,'ylim',[-0.04 0.04])
set(gca,'ytick',-0.06:0.02:0.06); set(gca,'ygrid','on'); set(gca,'xgrid','on');
[~,xcov_mean] = seasonal_crosscov(rmean(GMTOA,120),LFCsr(60:end-60,5),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
TOAg_rmean_max(5) = max(xcov_mean);

% LFC 6

plot_field_div(LON_AXIS,LAT_AXIS,reshape(LFPsr(6,:),[180 87]),linspace(-0.8,0.8,25)); topo_1deg_0; set(gca,'xlim',[0 358]); set(gca,'ylim',[-86 86])
hc = colorbar; set(hc,'ytick',-0.8:0.4:0.8); set(hc,'yticklabel',{'-0.8','-0.4','0','0.4','0.8°C'})

seasonal_crosscov(GMST,LFCsr(:,6),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global Mean Temperature','none','none',16)
set(gca,'ytick',-0.01:0.01:0.05); set(gca,'ygrid','on'); set(gca,'xgrid','on');
set(gca,'ylim',[-0.03 0.03])
% set(gca,'ytick',-0.01:0.01:0.05); set(gca,'ygrid','on'); set(gca,'xgrid','on');
% set(gca,'ylim',[-0.01 0.05])
[~,xcov_mean] = seasonal_crosscov(rmean(GMST,120),LFCsr(60:end-60,6),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
Tg_rmean_max(6) = max(xcov_mean);

seasonal_crosscov(GMTOA,LFCsr(:,6),nyr,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global TOA Radiation (W m^{-2})','none','none',16)
set(gca,'ylim',[-0.04 0.04])
set(gca,'ytick',-0.06:0.02:0.06); set(gca,'ygrid','on'); set(gca,'xgrid','on');
% set(gca,'ylim',[-0.05 0.06])
% set(gca,'ytick',-0.06:0.02:0.06); set(gca,'ygrid','on'); set(gca,'xgrid','on');
[~,xcov_mean] = seasonal_crosscov(rmean(GMTOA,120),LFCsr(60:end-60,6),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
TOAg_rmean_max(6) = max(xcov_mean);

%% ENSO

plot_field_div(LON_AXIS,LAT_AXIS,nino34_SST_regression_emean,linspace(-1.2,1.2,25)); topo_1deg_0; set(gca,'xlim',[0 358]); set(gca,'ylim',[-86 86])
hc = colorbar; set(hc,'ytick',-1.2:0.6:1.2); set(hc,'yticklabel',{'-1.2','-0.6','0','0.6','1.2°C'})

seasonal_crosscov(GMST,nino34,10,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global Mean Temperature','none','none',16)
set(gca,'ytick',-0.1:0.02:0.1); set(gca,'ygrid','on'); set(gca,'xgrid','on');
set(gca,'ylim',[-0.03 0.09])
[~,xcov_mean] = seasonal_crosscov(rmean(GMST,120),nino34(60:end-60),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
Tg_rmean_max(7) = max(xcov_mean);

seasonal_crosscov(GMTOA,nino34,10,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global Mean TOA Imbalance (W m^{-2})','none','none',16)
set(gca,'ylim',[-0.24 0.16])
set(gca,'ytick',-0.2:0.05:0.2); set(gca,'ygrid','on'); set(gca,'xgrid','on');
[~,xcov_mean] = seasonal_crosscov(rmean(GMTOA,120),nino34(60:end-60),20,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1)
TOAg_rmean_max(7) = max(xcov_mean);

%% LFC END

plot_field_div(LON_AXIS,LAT_AXIS,reshape(LFPs(end,:),[180 87]),linspace(-1.2,1.2,25)); topo_1deg_0; set(gca,'xlim',[0 358]); set(gca,'ylim',[-86 86])
hc = colorbar; set(hc,'ytick',-1.2:0.6:1.2); set(hc,'yticklabel',{'-1.2','-0.6','0','0.6','1.2°C'})

seasonal_crosscov(GMST,LFCs(:,end),10,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global Mean Temperature','none','none',16)
set(gca,'ytick',-0.1:0.02:0.1); set(gca,'ygrid','on'); set(gca,'xgrid','on');
set(gca,'ylim',[-0.06 0.06])
[~,xcov_mean] = seasonal_crosscov(rmean(GMST,120),LFCs(60:end-60,end),10,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(120:-1:-120,xcov_mean,'k','linewidth',1)
Tg_rmean_max(8) = max(xcov_mean);

seasonal_crosscov(GMTOA,LFCs(:,end),10,linspace(-0.2,0.2,25),1:12);
pretty_figure(400,250,'Lag (yr)','Global Mean TOA Imbalance (W m^{-2})','none','none',16)
set(gca,'ylim',[-0.2 0.2])
set(gca,'ytick',-0.2:0.05:0.2); set(gca,'ygrid','on'); set(gca,'xgrid','on');
[~,xcov_mean] = seasonal_crosscov(rmean(GMTOA,120),LFCs(60:end-60,end),10,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(120:-1:-120,xcov_mean,'k','linewidth',1)
TOAg_rmean_max(8) = max(xcov_mean);


%% Relative Amplitude

for i = 1:35
    is = (i-1)*l+1:i*l;
    std_LFC(i,:) = std(LFCsr(is,:),0,1);
end

bwidth = 0.25;

ins = 1:18;
N = length(ins);

figure; bar(1:4:4*N,std_LFC(ins,1),bwidth)
hold on; bar(2:4:4*N,std_LFC(ins,2),bwidth)
hold on; bar(3:4:4*N,std_LFC(ins,3),bwidth)
set(gca,'xtick',2:4:4*N); set(gca,'xticklabel',models(ins))
xtickangle(45)
pretty_figure(800,350,'none','Relative Amplitude','none','none',16)
set(gca,'xlim',[0 4*N])
set(gca,'ygrid','on')

ins = 19:35;
N = length(ins);

figure; bar(1:4:4*N,std_LFC(ins,1),bwidth)
hold on; bar(2:4:4*N,std_LFC(ins,2),bwidth)
hold on; bar(3:4:4*N,std_LFC(ins,3),bwidth)
set(gca,'xtick',2:4:4*N); set(gca,'xticklabel',models(ins))
xtickangle(45)
pretty_figure(800,350,'none','Relative Amplitude','none','none',16)
set(gca,'xlim',[0 4*N])
set(gca,'ygrid','on')

%% Spectra

is = 1:l;
[P,s,ci] = pmtmPH(LFCsr(is,1),1/12,3,0);
P_avg_1 = 0.*P;
P_avg_2 = P_avg_1;
P_avg_3 = P_avg_1;
P_avg_4 = P_avg_1;
P_avg_5 = P_avg_1;
P_avg_6 = P_avg_1;
P_avg_65 = P_avg_1;
P_avg_ENSO = P_avg_1;
figure
for i = 1:length(models)
    is = (i-1)*l+1:i*l;
    [P,s,ci] = pmtmPH(LFCsr(is,1),1/12,3,0);
    P_avg_1 = P_avg_1+P./length(models);
    %hold on; plot(1./s,P,'color',[0.5 0.5 0.5]); set(gca,'xscale','log'); set(gca,'yscale','log')
    [P,s,ci] = pmtmPH(LFCsr(is,2),1/12,3,0);
    P_avg_2 = P_avg_2+P./length(models);
    [P,s,ci] = pmtmPH(LFCsr(is,3),1/12,3,0);
    P_avg_3 = P_avg_3+P./length(models);
    [P,s,ci] = pmtmPH(LFCsr(is,4),1/12,3,0);
    P_avg_4 = P_avg_4+P./length(models);
    [P,s,ci] = pmtmPH(LFCsr(is,5),1/12,3,0);
    P_avg_5 = P_avg_5+P./length(models);
    [P,s,ci] = pmtmPH(LFCsr(is,6),1/12,3,0);
    P_avg_6 = P_avg_6+P./length(models);
    [P,s,ci] = pmtmPH(LFCs(is,end),1/12,3,0);
    P_avg_65 = P_avg_65+P./length(models);
    [P,s,ci] = pmtmPH(nino34(is),1/12,3,0);
    P_avg_ENSO = P_avg_ENSO+P./length(models);
end
hold on; plot(s,P_avg_1,'linewidth',1.5); set(gca,'xscale','log'); set(gca,'yscale','log')
hold on; plot(s,P_avg_2,'linewidth',1.5); 
hold on; plot(s,P_avg_3,'linewidth',1.5); 
hold on; plot(s,P_avg_4,'linewidth',1.5); 
hold on; plot(s,P_avg_5,'linewidth',1.5); 
hold on; plot(s,P_avg_6,'linewidth',1.5); 
%hold on; plot(1./s,P_avg_50,'k','linewidth',1.5); 
hold on; plot(s,P_avg_65,'k--','linewidth',1.5); 
hold on; plot(s,P_avg_ENSO,'k','linewidth',1.5); 
set(gca,'xlim',[1/2 250]);
set(gca,'ylim',[1e-4 1])
set(gca,'xdir','reverse')
set(gca,'xminortick','off')
set(gca,'xtick',[0.5 0.6 0.7 0.8 0.9 1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400]); set(gca,'xticklabel',{'','','','','','1','2','','4','','','','','','10','20','','40','','','','','','100','200','','400'})
%set(gca,'ytick',[1e-4 1e-3 1e-2 1e-1 1]); set(gca,'yticklabel',{'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}'});
pretty_figure(550,250,'Period (yr)','Power Spectral Density','none','none',16) 
set(gca,'box','off'); set(gca,'ygrid','on'); set(gca,'xgrid','on'); set(gca,'xminorgrid','off'); set(gca,'yminorgrid','off')

%% Tg spectra

%load('piControl_detrend_ts_Monthly_indices.mat')

Tg_norm = GMST./std(GMST);

P_avg = 0.*P;
figure
for i = 1:length(models)
    is = (i-1)*l+1:i*l;
    [P,s,ci] = pmtmPH(Tg_norm(is),1/12,3,0);
    P_avg = P_avg+P./length(models);
    %hold on; plot(1./s,P,'color',[0.5 0.5 0.5]); 
end
hold on; plot(s,P_avg,'linewidth',1.5); set(gca,'xscale','log'); set(gca,'yscale','log')
set(gca,'xlim',[1/2 250]);
set(gca,'ylim',[1e-4 1])
set(gca,'xdir','reverse')
set(gca,'xminortick','off')
set(gca,'xtick',[0.5 0.6 0.7 0.8 0.9 1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400]); set(gca,'xticklabel',{'','','','','','1','2','','4','','','','','','10','20','','40','','','','','','100','200','','400'})
%set(gca,'ytick',[1e-4 1e-3 1e-2 1e-1 1]); set(gca,'yticklabel',{'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}'});
pretty_figure(550,250,'Period (yr)','Power Spectral Density','none','none',16) 
set(gca,'box','off'); set(gca,'ygrid','on'); set(gca,'xgrid','on'); set(gca,'xminorgrid','off'); set(gca,'yminorgrid','off')

% TOAg spectra

%load('piControl_detrend_TOA_Monthly_indices.mat')
TOA_global_norm = GMTOA./std(GMTOA);

P_avg = 0.*P;
%figure
for i = 1:length(models)
    is = (i-1)*l+1:i*l;
    [P,s,ci] = pmtmPH(TOA_global_norm(is),1/12,3,0);
    P_avg = P_avg+P./length(models);
    %hold on; plot(1./s,P,'color',[0.5 0.5 0.5]); 
end
hold on; plot(s,P_avg,'linewidth',1.5); set(gca,'xscale','log'); set(gca,'yscale','log')
set(gca,'xlim',[1/2 250]);
set(gca,'ylim',[1e-4 1])
set(gca,'xdir','reverse')
set(gca,'xminortick','off')
set(gca,'xtick',[0.5 0.6 0.7 0.8 0.9 1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400]); set(gca,'xticklabel',{'','','','','','1','2','','4','','','','','','10','20','','40','','','','','','100','200','','400'})
%set(gca,'ytick',[1e-4 1e-3 1e-2 1e-1 1]); set(gca,'yticklabel',{'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}'});
pretty_figure(550,250,'Period (yr)','Power Spectral Density','none','none',16) 
set(gca,'box','off'); set(gca,'ygrid','on'); set(gca,'xgrid','on'); set(gca,'xminorgrid','off'); set(gca,'yminorgrid','off')

%% LFC Coherence Spectra

for i = 1:2

    switch i
        case 1
            ks = 1:2:15;
        case 2
            ks = 2:2:16;
    end

%ks = 17;
%ks = 18:23;
%ks = 24;

figure;

for k = ks
    switch k
        case 1
            x = LFCsr(:,1);
            y = GMST;
        case 2
            x = LFCsr(:,1);
            y = GMTOA;
        case 3
            x = LFCsr(:,2);
            y = GMST;
        case 4
            x = LFCsr(:,2);
            y = GMTOA;
        case 5
            x = LFCsr(:,3);
            y = GMST;
        case 6
            x = LFCsr(:,3);
            y = GMTOA;
        case 7
            x = LFCsr(:,4);
            y = GMST;
        case 8
            x = LFCsr(:,4);
            y = GMTOA;
        case 9
            x = LFCsr(:,5);
            y = GMST;
        case 10
            x = LFCsr(:,5);
            y = GMTOA;
        case 11
            x = LFCsr(:,6);
            y = GMST;
        case 12
            x = LFCsr(:,6);
            y = GMTOA;
        case 13
            x = LFCs(:,65);
            y = GMST;
        case 14
            x = LFCs(:,65);
            y = GMTOA;
        case 15
            x = nino34;
            y = GMST;
        case 16
            x = nino34;
            y = GMTOA;
        case 17
            x = GMST;
            y = GMTOA;
        case 18
            x = LFCsr(:,1);
            y = nino34;
        case 19
            x = LFCsr(:,2);
            y = nino34;
        case 20
            x = LFCsr(:,3);
            y = nino34;
        case 21
            x = LFCsr(:,4);
            y = nino34;
        case 22
            x = LFCsr(:,5);
            y = nino34;
        case 23
            x = LFCsr(:,6);
            y = nino34;
        case 24
            x = qflux_global;
            y = GMTOA;
    end

[s,c,ph,ci,phi] = cmtm(y(1:l),x(1:l),1/12,8);
c_avg = 0.*c;
ph_avg = c_avg;
%figure
for i = 1:length(models)
    is = (i-1)*l+1:i*l;
    [s,c,ph,ci,phi] = cmtm(y(is),x(is),1/12,8);
    c_avg = c_avg+c.^2./length(models);
    ph_avg = ph_avg+ph./length(models);
    %hold on; plot(1./s,c.^2,'color',[0.5 0.5 0.5]); set(gca,'xscale','log');
end
if k == 13 || k == 14
    hold on; plot(1./s,c_avg,'k--','linewidth',1.5); set(gca,'xscale','log');
elseif k == 15 || k == 16
    hold on; plot(1./s,c_avg,'k','linewidth',1.5); set(gca,'xscale','log');
else
    hold on; plot(1./s,c_avg,'linewidth',1.5); set(gca,'xscale','log');
end
set(gca,'xlim',[1/2 250]);
%set(gca,'ylim',[1e-4 1])
set(gca,'xdir','reverse')
set(gca,'xminortick','off')
set(gca,'xtick',[0.5 0.6 0.7 0.8 0.9 1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400]); set(gca,'xticklabel',{'','','','','','1','2','','4','','','','','','10','20','','40','','','','','','100','200','','400'})
%set(gca,'ytick',[1e-4 1e-3 1e-2 1e-1 1]); set(gca,'yticklabel',{'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}'});
pretty_figure(550,250,'Period (yr)','Coherence^2','none','none',16) 
set(gca,'box','off'); set(gca,'ygrid','on'); set(gca,'xgrid','on'); set(gca,'xminorgrid','off'); set(gca,'yminorgrid','off')

end

end

%% Fix y labels

% fix y labels on log-log plots (run on each figure separately)

yt = yticklabels; 
for i=1:length(yt)
    yt{i} = [yt{i},'   ']; % note pad with a few spaces 
end 
yticklabels(yt)

%% Lead-lag TOA components

is = 1:3;

for i = is
    [~,xcov_mean] = seasonal_crosscov(rlut_global,LFCsr(:,i),20,linspace(-0.2,0.2,25),1:12,1);
    figure; plot(240:-1:-240,xcov_mean,'color',[0.85,0.33,0.10],'linewidth',1.5)
    pretty_figure(450,250,'Lag (yr)','Global Energy Fluxes (W m^{-2})','none','none',16)
    set(gca,'ytick',-0.1:0.05:0.1); set(gca,'ygrid','on'); set(gca,'xgrid','on');
    set(gca,'ylim',[-0.1 0.1])
    if i >= 3
        set(gca,'xtick',-2400:60:2400); set(gca,'xticklabel',-200:5:200);
        set(gca,'xlim',[-12*10 12*10])
        set(gca,'ylim',[-0.05 0.1])
    else
        set(gca,'xtick',-2400:120:2400); set(gca,'xticklabel',-200:10:200);
        set(gca,'xlim',[-12*20 12*20])
    end
    [~,xcov_mean] = seasonal_crosscov(rsut_global,LFCsr(:,i),20,linspace(-0.2,0.2,25),1:12,1);
    hold on; plot(240:-1:-240,xcov_mean,'color',[0.47,0.67,0.19],'linewidth',1.5)
    [~,xcov_mean] = seasonal_crosscov(GMTOA,LFCsr(:,i),20,linspace(-0.2,0.2,25),1:12,1);
    hold on; plot(240:-1:-240,xcov_mean,'k','linewidth',1.5)
    [~,xcov_mean] = seasonal_crosscov(qflux_global(~isnan(qflux_global)),LFCsr(~isnan(qflux_global),i),20,linspace(-0.2,0.2,25),1:12,1);
    hold on; plot(240:-1:-240,xcov_mean,'color',[0.07,0.62,1.00],'linewidth',1.5)
    legend('LW','SW','TOA','OHU')
end

%%

% for inset (normalizations determined such that std(xcov_mean) is equal across all lines - seems like this should be true and it looks reasonable):
% EN = nino34;
% EN(EN<1) = 0; % 0.5
% EN = EN./0.0353.*0.0820; % 0.0414
% LN = nino34;
% LN(LN>-1) = 0;
% LN = LN./0.0334.*0.0820; % 0.0397

[~,xcov_mean] = seasonal_crosscov(rlut_global,nino34,6,linspace(-0.2,0.2,25),1:12,1);
figure; plot(72:-1:-72,xcov_mean,'color',[0.85,0.33,0.10],'linewidth',1.5)
pretty_figure(450,250,'Lag (yr)','Global Energy Fluxes (W m^{-2})','none','none',16)
set(gca,'ytick',-0.2:0.1:0.3); set(gca,'ygrid','on'); set(gca,'xgrid','on');
set(gca,'ylim',[-0.2 0.3])
set(gca,'xtick',-120:12:120); set(gca,'xticklabel',-10:1:10);
set(gca,'xlim',[-12*4 12*4]);
[~,xcov_mean] = seasonal_crosscov(rsut_global,nino34,6,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(72:-1:-72,xcov_mean,'color',[0.47,0.67,0.19],'linewidth',1.5)
[~,xcov_mean] = seasonal_crosscov(GMTOA,nino34,6,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(72:-1:-72,xcov_mean,'k','linewidth',1.5)
[~,xcov_mean] = seasonal_crosscov(qflux_global(~isnan(qflux_global)),nino34(~isnan(qflux_global)),6,linspace(-0.2,0.2,25),1:12,1);
hold on; plot(72:-1:-72,xcov_mean,'color',[0.07,0.62,1.00],'linewidth',1.5)
 legend('LW','SW','TOA','OHU')

%% Inter-model difference scatter plots

markers = {'^','v','s','d','x','+'}; M = length(markers);
colors = {[0    0.4470    0.7410],[0.6350    0.0780    0.1840],[0.9290    0.6940    0.1250],[0.4940    0.1840    0.5560],[0 0 0],[0.47    0.67    0.19],[0.8500    0.3250    0.0980]};

%% Temp. vs. TOA impact (10-year mean lag-0) 

clear ECS_AMO ECS_SOMV ECS_PDO ECS_ENSO

ECS_forced = 3.5;
Tg_forced = 1;
TOAg_forced = -4./ECS_forced.*Tg_forced;
ENSO_rmean_width = 120; % change to change running mean length used for ENSO plots

for n = 1:5
    figure;
    for i = 1:length(models)
        is = (i-1)*l+1:i*l;
        TOAg_rmean = rmean(GMTOA(is),121);
        Tg_rmean = rmean(GMST(is),121);
        TOAg_short_rmean = rmean(GMTOA(is),ENSO_rmean_width+1);
        Tg_short_rmean = rmean(GMST(is),ENSO_rmean_width+1);
        if n == 4
            LFC = nino34(is)./std(nino34(is));
        elseif n == 5
            LFC = LFCs(is,65)./std(LFCs(is,65));
        else
            LFC = LFCsr(is,n)./std(LFCsr(is,n));  % normalized
        end
        if n >= 7
            cov_Tg(i,n) = 2*mean(Tg_short_rmean'.*LFC(ENSO_rmean_width/2+1:end-ENSO_rmean_width/2));
            cov_TOAg(i,n) = 2*mean(TOAg_short_rmean'.*LFC(ENSO_rmean_width/2+1:end-ENSO_rmean_width/2));
        else
            cov_Tg(i,n) = 2*mean(Tg_rmean'.*LFC(61:end-60));
            cov_TOAg(i,n) = 2*mean(TOAg_rmean'.*LFC(61:end-60));
        end
        k = rem(i-1,M)+1;
        j = floor((i-1)/M)+1;
        plot(cov_Tg(i,n),cov_TOAg(i,n),'marker',markers{k},'color',colors{j},'linewidth',2,'linestyle','none','markersize',11); hold on
    end
    
    if n <= 2
        set(gca,'xlim',[-0.025 0.325]);
    elseif n == 4 && ENSO_rmean_width == 24
        set(gca,'ylim',[-0.5 0.1]); set(gca,'xlim',[0 0.16])
    elseif n == 4 && ENSO_rmean_width == 120
        set(gca,'ylim',[-0.18 0.01]); set(gca,'xlim',[-0.005 0.035])
    end
    xl = get(gca,'xlim'); yl = get(gca,'ylim');
    hold on; plot(xl,[0 0],'k','linewidth',1.5)
    hold on; plot([0 0],yl,'k','linewidth',1.5)
    set(gca,'xlim',xl); set(gca,'ylim',yl)
    
    Tgs = -0.1:0.02:0.4;
    TOAgs = -0.5:0.01:0.4;
    ECSs = -4.*(Tg_forced + Tgs')./(TOAg_forced + TOAgs);
        
    ctrs = -0.8:0.2:1.4;
    if n >= 3
        ctrs = -1:0.1:1.6;
        TOAgs = -0.3:0.01:0.3;
        ECSs = -4.*(Tg_forced + Tgs')./(TOAg_forced + TOAgs);
    end
    if n >= 4
        ctrs = -1:0.1:1.6;
    end
    hold on; contour(Tgs,TOAgs,ECSs'-ECS_forced,ctrs,'color',[0.5 0.5 0.5],'ShowText','on') 
    
    for i = 1:length(models)
        k = rem(i-1,M)+1;
        j = floor((i-1)/M)+1;
        plot(cov_Tg(i,n),cov_TOAg(i,n),'marker',markers{k},'color',colors{j},'linewidth',2,'linestyle','none','markersize',11); hold on
    end
    hold on; plot(mean(cov_Tg(:,n)),mean(cov_TOAg(:,n)),'p','color',[0.4 0.4 0.4],'markersize',16,'markerfacecolor',[0.4 0.4 0.4])
    pretty_figure(500,350,'Decadal GMST Anomaly (°C)','Decadal GMTOA Anomaly (W m^{-2})','none','none',16)
    set(gca,'xgrid','on'); set(gca,'ygrid','on')
    
end

%% Temp. vs. TOA impact (5-year mean lag-2.5 minus lead-2.5) 

for n = 1:5
    figure;
    for i = 1:length(models)
        is = (i-1)*l+1:i*l;
        TOAg_rmean = rmean(GMTOA(is),61); 
        Tg_rmean = rmean(GMST(is),61);
        TOAg_short_rmean = rmean(GMTOA(is),ENSO_rmean_width/2+1);
        Tg_short_rmean = rmean(GMST(is),ENSO_rmean_width/2+1);
        if n == 4
            LFC = nino34(is)./std(nino34(is));
        elseif n == 5
            LFC = LFCs(is,65)./std(LFCs(is,65));
        else
            LFC = LFCsr(is,n)./std(LFCsr(is,n));  % normalized
        end
        if n >= 4
            cov_Tg(i,n) = mean(Tg_short_rmean'.*LFC(1:end-ENSO_rmean_width/2))-mean(Tg_short_rmean'.*LFC(ENSO_rmean_width/2+1:end));
            cov_TOAg(i,n) = mean(TOAg_short_rmean'.*LFC(1:end-ENSO_rmean_width/2))-mean(TOAg_short_rmean'.*LFC(ENSO_rmean_width/2+1:end));
        else
            cov_Tg(i,n) = mean(Tg_rmean'.*LFC(1:end-60))-mean(Tg_rmean'.*LFC(61:end));
            cov_TOAg(i,n) = mean(TOAg_rmean'.*LFC(1:end-60))-mean(TOAg_rmean'.*LFC(61:end));
        end
        %[~,xcov_mean] = seasonal_crosscov(Tg_rmean,LFC(60:end-60),10,linspace(-0.4,0.4,25),1:12,0);
        %[~,xcov_mean2] = seasonal_crosscov(TOAg_rmean,LFC(60:end-60),10,linspace(-0.4,0.4,25),1:12,0);
        k = rem(i-1,M)+1;
        j = floor((i-1)/M)+1;
        plot(cov_Tg(i,n),cov_TOAg(i,n),'marker',markers{k},'color',colors{j},'linewidth',2,'linestyle','none','markersize',11); hold on
    end
    
    if n <= 2
       set(gca,'ylim',[-0.08 0.02]); set(gca,'xlim',[-0.0125 0.0225])
    elseif n == 3
        set(gca,'ylim',[-0.04 0.04]); set(gca,'xlim',[-0.05 0.01])
    elseif n == 4 && ENSO_rmean_width == 24
        set(gca,'ylim',[-0.5 0.1]); set(gca,'xlim',[0 0.16])
    elseif n == 4 && ENSO_rmean_width == 120
        set(gca,'ylim',[-0.18 0.01]); set(gca,'xlim',[-0.005 0.035])
    end
    xl = get(gca,'xlim'); yl = get(gca,'ylim');
    hold on; plot(xl,[0 0],'k','linewidth',1.5)
    hold on; plot([0 0],yl,'k','linewidth',1.5)

    Tgs = -0.1:0.02:0.4;
    TOAgs = -0.5:0.01:0.4;
    ECSs = -4.*(Tg_forced + Tgs')./(TOAg_forced + TOAgs);
    if n >= 4
        ctrs = -1:0.2:1.6;
    else
        ctrs = -0.25:0.05:1;
    end
    hold on; contour(Tgs,TOAgs,ECSs'-ECS_forced,ctrs,'color',[0.5 0.5 0.5],'ShowText','on') 
    set(gca,'xlim',xl); set(gca,'ylim',yl)
    
    for i = length(models)
        k = rem(i-1,M)+1;
        j = floor((i-1)/M)+1;
        plot(cov_Tg(i,n),cov_TOAg(i,n),'marker',markers{k},'color',colors{j},'linewidth',2,'linestyle','none','markersize',11); hold on
    end
    hold on; plot(mean(cov_Tg(:,n)),mean(cov_TOAg(:,n)),'p','color',[0.4 0.4 0.4],'markersize',16,'markerfacecolor',[0.4 0.4 0.4])
    pretty_figure(500,350,'Global-Mean Surface Temperature (°C)','Global TOA Radiation (W m^{-2})','none','none',16)
    set(gca,'xgrid','on'); set(gca,'ygrid','on')
end

%% Temp. vs. TOA impact (standard deviation of random 10-year samples), median value vs. Tg_forced and ECS_forced

ECS_forced = 2:0.125:4.5;
Tg_forced = 0.7:0.05:1.2;
TOAg_forced = 4./ECS_forced'.*Tg_forced;

if (1)
    rmean_length = 120;
    ctrs = linspace(0,1.5,16);
    ctrs2 = linspace(-1.5,1.5,31);
else
    rmean_length = 360;
    ctrs = linspace(0,0.8,17);
    ctrs2 = linspace(-0.8,0.8,33);
end

clear std_ECS

for j = 1:length(ECS_forced)
    for k = 1:length(Tg_forced)
        for i = 1:length(models)
            is = (i-1)*l+1:i*l;
            TOAg_rmean = rmean(GMTOA(is),rmean_length+1);
            Tg_rmean = rmean(GMST(is),rmean_length+1);
            std_rmean_Tg(i) = std(Tg_rmean);
            std_rmean_TOAg(i) = std(TOAg_rmean);
            std_ECS_noTOA(j,k,i) = 2*std(4.*(Tg_forced(k) + Tg_rmean)./(TOAg_forced(j,k)));  % 2 standard deviation event;
            std_ECS_noT(j,k,i) = 2*std(4.*(Tg_forced(k))./(TOAg_forced(j,k) + TOAg_rmean));  % 2 standard deviation event;
            std_ECS(j,k,i) = 2*std(4.*(Tg_forced(k) + Tg_rmean)./(TOAg_forced(j,k) + TOAg_rmean));  % 2 standard deviation event; to get approx. variance explained by first 4 modes: 2*std(4.*(1.1 + 0.68*Tg_rmean)./(1.4667 + 0.29*TOAg_rmean))
        end
    end
end
plot_field(Tg_forced,ECS_forced,median(std_ECS,3)',ctrs);
pretty_figure(300,250,'Historical Warming (°C)','EffCS (°C)',0.6:0.1:1.2,2:0.5:4.5,16)
%title('Spread in Inferred Climate Sensitivity from Decadal Variability (°C)','fontsize',14)
hold on; plot(1,3.5,'ko','markersize',8','linewidth',1.5)

plot_field(Tg_forced,ECS_forced,median(std_ECS_noTOA,3)',ctrs);
pretty_figure(300,250,'Historical Warming (°C)','EffCS (°C)',0.6:0.1:1.2,2:0.5:4.5,16)
hold on; plot(1,3.5,'ko','markersize',8','linewidth',1.5)

plot_field(Tg_forced,ECS_forced,median(std_ECS_noT,3)',ctrs);
pretty_figure(300,250,'Historical Warming (°C)','EffCS (°C)',0.6:0.1:1.2,2:0.5:4.5,16)
hold on; plot(1,3.5,'ko','markersize',8','linewidth',1.5)

plot_field(Tg_forced,ECS_forced,median(std_ECS-std_ECS_noT-std_ECS_noTOA,3)',ctrs2);
pretty_figure(300,250,'Historical Warming (°C)','EffCS (°C)',0.6:0.1:1.2,2:0.5:4.5,16)
hold on; plot(1,3.5,'ko','markersize',8','linewidth',1.5)

plot_field(Tg_forced,ECS_forced,median(std_ECS-std_ECS_noTOA,3)',ctrs);
pretty_figure(300,250,'Historical Warming (°C)','EffCS (°C)',0.6:0.1:1.2,2:0.5:4.5,16)
hold on; plot(1,3.5,'ko','markersize',8','linewidth',1.5)

%% Averaging period dependence

Tg_forced = 1;
TOAg_forced = 4/3.5*Tg_forced;

% averaging period in months
T = [2:12 14:2:24 30 36:12:120 144:24:240 300:60:3000];

figure; 

for j = 1:3
    clear c
    for i = 1:length(models)
        is = (i-1)*l+1:i*l;
        for nt = 1:length(T)
            switch j
                case 1
                    x = 4.*(Tg_forced + rmean(GMST(is),T(nt)))./(TOAg_forced); % GMST (and forced) component
                    %x = rmean(Tg(is),T(nt));
                case 2
                    x = 4.*(Tg_forced)./(TOAg_forced + rmean(GMTOA(is),T(nt))); % TOA (and forced) component
                    %x = rmean(TOA_global(is),T(nt));
                case 3
                    x = 4.*(Tg_forced + rmean(GMST(is),T(nt)))./(TOAg_forced + rmean(GMTOA(is),T(nt))) ...
                        - 4.*(Tg_forced + rmean(GMST(is),T(nt)))./(TOAg_forced) ...
                        - 4.*(Tg_forced)./(TOAg_forced + rmean(GMTOA(is),T(nt))); % nonlinear component
            end
            y = 4.*(Tg_forced + rmean(GMST(is),T(nt)))./(TOAg_forced + rmean(GMTOA(is),T(nt))); % ICS with reference forced response
            c(nt) = corr(x',y').^2;
        end
        if i == 1
            c_avg = c.^2./length(models);
        else
            c_avg = c_avg+c.^2./length(models);
        end
    end
    
    hold on; plot(T./12,c_avg,'linewidth',1.5); set(gca,'xscale','log');
    set(gca,'xlim',[1/2 250]);
    set(gca,'ytick',0:0.2:1);
    %set(gca,'ylim',[1e-4 1])
    set(gca,'xdir','reverse')
    set(gca,'xminortick','off')
    set(gca,'xtick',[0.5 0.6 0.7 0.8 0.9 1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400]); set(gca,'xticklabel',{'','','','','','1','2','','4','','','','','','10','20','','40','','','','','','100','200','','400'})
    %set(gca,'ytick',[1e-4 1e-3 1e-2 1e-1 1]); set(gca,'yticklabel',{'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}'});
    pretty_figure(550,250,'Averaging Period (yr)','Correlation^2','none','none',16)
    set(gca,'box','off'); set(gca,'ygrid','on'); set(gca,'xgrid','on'); set(gca,'xminorgrid','off'); set(gca,'yminorgrid','off')

end