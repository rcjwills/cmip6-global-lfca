function [xcov,xcov_mean] = seasonal_crosscov(x1,x2,nyears,ctrs,months_avg,surpress_plot)

% month in year of x1 is shown on y axis

for i = 1:12
    x1(i:12:end) = x1(i:12:end)- mean(x1(i:12:end));
    x2(i:12:end) = x2(i:12:end)- mean(x2(i:12:end));
end

xcov = zeros(nyears*12*2+1,12);
offset = nyears*12+1;

for i = 1:12
    for j = 1:12
        lag = j-i;
        xcf = crosscorr(x1(i:12:end),x2(j:12:end),nyears).*std(x1(i:12:end)).*std(x2(j:12:end));
        if lag==0
            xcov((offset-nyears*12):12:end,i) = xcf;
        elseif lag>0
            xcov((offset-nyears*12+lag):12:end,i) = xcf(1:end-1);
        elseif lag<0
            xcov((offset-nyears*12+lag+12):12:end,i) = xcf(2:end);
        end
    end
end

if nargin > 4
    xcov_mean = mean(xcov(:,months_avg),2);
else
    xcov_mean = mean(xcov(:,:),2);
end
    
if nargin < 6
if nargin > 3
    if nargin > 4
        figure; area_red_blue(gca,12*nyears:-1:-12*nyears,xcov_mean)
        if nyears <= 4
            set(gca,'xtick',-120:12:120); set(gca,'xticklabel',-10:1:10);
        elseif nyears<=12
            set(gca,'xtick',-120:24:120); set(gca,'xticklabel',-10:2:10);
        else
            set(gca,'xtick',-2400:120:2400); set(gca,'xticklabel',-200:10:200);
        end
        set(gca,'xlim',[-12*nyears 12*nyears])
        pretty_figure(500,250,'Lag (yr)','Heat Flux (W m^{-2})','none','none',16)
    else
        if (1)
            plot_field(12*nyears:-1:-12*nyears,-4:7,[xcov(:,8:12), xcov(:,1:7)],ctrs);
            if nyears<=12
                set(gca,'xtick',-120:24:120); set(gca,'xticklabel',-10:2:10);
                set(gca,'xlim',[-12*nyears 12*nyears])
            else
                set(gca,'xtick',-2400:120:2400); set(gca,'xticklabel',-200:10:200);
                set(gca,'xlim',[-12*nyears 12*nyears])
            end
            set(gca,'ytick',-4:7); set(gca,'yticklabel',{'','Sept','','','Dec','','','Mar','','','Jun',''});
            xlabel('Lag (yr)','fontsize',16)
            ylabel('Variable 1 Month','fontsize',16)
        else
            plot_field(0:11,12*nyears:-1:-12*nyears,[xcov(:,12), xcov(:,1:11)]',ctrs);
            if nyears<=12
                set(gca,'ytick',-120:24:120); set(gca,'yticklabel',-10:2:10);
                set(gca,'ylim',[-12*nyears 12*nyears])
            else
                set(gca,'ytick',-2400:120:2400); set(gca,'yticklabel',-200:10:200);
                set(gca,'ylim',[-12*nyears 12*nyears])
            end
            set(gca,'xtick',0:11); set(gca,'xticklabel',{'','Jan','','','Apr','','','July','','','Oct',''});
            ylabel('Lag (yr)','fontsize',16)
            xlabel('Sea-Ice Month','fontsize',16)
            pretty_figure(300,300,'none','none','none','none',16)
        end
    end
end
end