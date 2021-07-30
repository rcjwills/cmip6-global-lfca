function [] = area_red_blue(ax,x,y,offset)

if nargin<4
    offset = 0;
end

colors = ([0.8500    0.3250    0.0980; 0    0.4470    0.7410]);
%colors = ([0    0.4470    0.7410;  0.8500    0.3250    0.0980]);

y = y + offset;

yplus = y;
yplus(y<offset) = offset;
yminus = y;
yminus(y>offset) = offset;

j = 0;
xnew = x;
for i = 1:length(x)
    if (i+j)<length(yplus)
    if (yplus(i+j) == 0 && yminus(i+j+1) == 0) || (yminus(i+j) == 0 && yplus(i+j+1) == 0)
        xcut = xnew(i+j:end);
        xnew(i+j+1:i+j+length(xcut)) = xcut;
        xnew(i+j) = (x(i) + x(i+1))/2;
        ep = yplus(end);
        em = yminus(end);
        yplus(i+j+1:end) = yplus(i+j:end-1);
        yminus(i+j+1:end) = yminus(i+j:end-1);
        yplus(length(yplus)+1) = ep;
        yminus(length(yminus)+1) = em;
        yplus(i+j) = 0;
        yminus(i+j) = 0;
        j = j + 1;
    end
    end
end

area(ax,xnew,yplus,offset,'linestyle','none','facecolor',colors(1,:));
hold on;
area(ax,xnew,yminus,offset,'linestyle','none','facecolor',colors(2,:));

%colormap(colors);