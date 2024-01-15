clear all
%close all
clc
%Load the countoursp data
A1=xlsread('countoursp.xlsx');
A2=xlsread('profile1.xlsx');
A3=xlsread('profile2.xlsx');

A=[A1(:,[3 4 7]);A2(:,[4 5 9]);A3(:,[4 5 8])];

%A=[A1(:,[3 4 5]);A2(:,[4 5 6]);A3(:,[4 5 6])];

figure(500)
plot(A(:,1),A(:,2),'b.')

hold on

%convert degree to ditance

[x,y,utmzone] = deg2utm(A(:,1),A(:,2));

xpos=x-min(x);
ypos=y-min(y);
dist=sqrt(xpos.^2+ypos.^2);

figure
plot(xpos,ypos,'r.')

kkkk = boundary(xpos,ypos,1);
hold on
plot(xpos(kkkk),ypos(kkkk),'-b.')




d_obs1=A(:,3);

figure
scatter(xpos,ypos,40,d_obs1,'filled')
xlabel('Easting (m)');
ylabel('Northing (m)');
title('Anomaly(nT)');
colormap jet;
colorbar
%view([0 90])

%Countouring

 xint=0:10:300;
 yint=0:10:400;
[X Y]=meshgrid(xint,yint);

Vq = griddata(xpos,ypos,d_obs1,X,Y);






xobs=X(:);
yobs=Y(:);
d_obs=Vq(:);

% Taking only non Nan value in d_obs 
kk = find(~isnan(d_obs));

xobs=X(kk);
yobs=Y(kk);
d_obs=Vq(kk);




%countour plot
figure
scatter(xobs,yobs,40,d_obs,'filled')
% xlim ([min(xm_min) max(xm_max)])% xlim([0 10000])
% ylim ([min(ym_min) max(ym_max)])% ylim([0 10000])
xlabel('Easting (m)');
ylabel('Northing (m)');
title('Anomaly(nT)');
colormap jet;
colorbar
hold on
plot(xpos(kkkk),ypos(kkkk),'-b.')


[in,on] = inpolygon(xobs,yobs,xpos(kkkk),ypos(kkkk));

d_obs(~in)=nan;

figure
scatter(xobs,yobs,40,d_obs,'filled')
% xlim ([min(xm_min) max(xm_max)])% xlim([0 10000])
% ylim ([min(ym_min) max(ym_max)])% ylim([0 10000])
xlabel('Easting (m)','fontsize',20);
ylabel('Northing (m)','fontsize',20);
title('Anomaly(nT)');
colormap jet;
colorbar


width = 6;     % Width in inches
height = 2.5;    % Height in inches
figure;
pseudo(xobs,yobs,-d_obs,gca,1,0);
hold on
plot(xpos(171:218),ypos(171:218),'k')
hold on
plot(xpos(219:266),ypos(219:266),'k')
set(gca,'fontweight','normal','fontsize',12);
set(gca,'TickDir','out','box','off'); % The only other option is 'in'
set(gca,'ticklength',1.5*get(gca,'ticklength'))
mycolormap = customcolormap([0 .25 .5 .75 1], {'#9d0142','#f66e45','#ffffbb','#65c0ae','#5e4f9f'});
colormap(mycolormap);
hc=colorbar('EastOutside');
hc.TickDirection='out';
hc.TickLength=0.025;
set(get(hc,'XLabel'),'string','Self-potential (mV)','fontweight','normal','fontsize',12);
% xlim([0,470])
ylim([0,400])
xlabel('Distance (m)','fontweight','normal','fontsize',12);
ylabel('Depth (m)','fontweight','normal','fontsize',12);


set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);



print('ContourPlot','-dpng','-r300');
%set(gca,'TickDir','out'); % The only other option is 'in'
%contourf(X,Y,dd,32)
%surf(X,Y,dd*1e9)
%  xlim ([-10 1010])% xlim([0 10000])
%  ylim ([-10 1210])% ylim([0 10000])
% xlabel('Easting (m)');
% ylabel('Northing (m)');
% title('Anomaly(nT)');
colormap jet;
 hc = colorbar('Location','Eastoutside');
%  hc.YTick = [-15:5:15];
% hc.YTick = [1.2:0.2:2];
% hc.YTickLabel = {'1.5', '2.5', '4.0', '6.3', '10','15','25','40'};
set(get(hc,'XLabel'),'string','Self-potential(mV)','fontsize',15)
%view([0 90])
% hold on
% %plot([400 600 600 400 400],[400 400 1000 1000 400],'r-')
% plot([250 350 350 250 250],[350 350 650 650 350],'k-','LineWidth',2)
% plot([650 750 750 650 650],[600 600 800 800 600],'k-','LineWidth',2)
% plot([650 750 750 650 650],[200 200 400 400 200],'k-','LineWidth',2)
% toc
% hold off

SPP1smooth=-movmean(A2(:,9),3);
SPP2smooth=-movmean(A3(:,8),3);
figure
plot(A2(:,1),SPP1smooth,'-b.')
hold on
plot(A3(:,1),SPP2smooth,'-r.')
xlabel('distance (m)','FontSize',15);
ylabel('self-potential (mV)','FontSize',15);
legend('profile 1','profile 2')

