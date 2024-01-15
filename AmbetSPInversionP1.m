close all
clear all
clc
addpath('Distmesh');
addpath('Finite Elements Functions');
addpath('Inverse-Reg');
addpath('Plot tools');   
%load('all_information.mat')

load('all_inversionAmbetSP1.mat')

width = 6;     % Width in inches
height = 2.5;    % Height in inches


figure
pdeplot(p,e,t ,'xydata',log10(1./sig),'xystyle','flat','mesh','off');
set(gca,'fontweight','normal','fontsize',12);
set(gca,'TickDir','out'); % The only other option is 'in'
set(gca,'ticklength',2.5*get(gca,'ticklength'))
mycolormap = customcolormap([0 .25 .5 .75 1], {'#9d0142','#f66e45','#ffffbb','#65c0ae','#5e4f9f'});
colormap jet;
hc=colorbar('EastOutside');
hc.TickDirection='out';
hc.TickLength=0.025;
% hc.Label.Rotation = 270;
% set(get(hc,'XLabel'),'TickDir','out'); % The only other option is 'in'
% set(get(hc,'XLabel'),'ticklength',2.5*get(gca,'ticklength'))
set(get(hc,'XLabel'),'string','Log(Resistivity,Ohm m)','fontweight','normal','fontsize',12);
xlim([0,470])
ylim([-78,0])
xlabel('Distance (m)','fontweight','normal','fontsize',12);
ylabel('Depth (m)','fontweight','normal','fontsize',12);


set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);



print('ERTAmbetP1','-dpng','-r300');
% set(gca,'fontweight','normal','fontsize',12);
% hc=colorbar('EastOutside');
% set(get(hc,'XLabel'),'string','log Resistivity (\Omega\cdotm)','fontweight','bold','fontsize',12);
%  caxis([1 2.5])
%  colormap jet
% %colormap(parula(3))
%      cmap=colormap;
%      cmap1=flipdim(cmap,1);
%      colormap(cmap1);

 
     
%SP = awgn(SP,30,'measured');
%SP=SP+405.8790;

% AmbetSP1data=xlsread('AmbetSPProfile1.xlsx');
% 
% g_obs=-movmean(AmbetSP1data(:,2),3);
% xint = AmbetSP1data(:,1);
%  figure
%  plot(xint,g_obs)
%  
 
G=A;
% sig=0*sig+1;
% sigma=ones*([sig sig])';
% deb=0.1*sigma;
% g_cal=A*deb;
% de=g_obs-g_cal;

% gg=center(p',t');
% %depthweight=(gg(:,2)).^6;
% [P11]=precandi(p,t,xint,0*xint);
% P=[P11;P11];
% no_triangle=2*no_of_triangle;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inversion 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




 
 
 dm=zeros(size(p,2),1);
 
 m=0*ones(size(p,2),1);
 d0=g_obs;
 [d]= FWD_SPdivJS(data,p,e,t,sig,m,xint);
 model=m;
 
 Msmin=-1;
 Msmax=2;
 
% depthweight=(p(2,:)).^2;
% P=depthweight';
[P]=precandi_divJS(p,xint,0*xint);

 %[ C ] = Unstructured_Constraint(p,e,t,sig);
%  C=eye(size(p,2));
%  C=C.*(1./depthweight');

%  lem=std((d0)); 
 
%  MaxIter=200;
 
no_triangle=size(p,2);

% Zu=10*rand([11,1]);
n=size(p,2);
W = eye(n);
beta=10^-2;
%k=input('\n put the total number of iteration required\n')
% m=1;
% P=1;
% q=0;
Gobs=d0;
maxiter=20;

Wz=diag(P);
%Wz=eye(size(p,2));

%[S,Fcal] = LastKInv(A,Max_iter,target,data,p,e,t,sig,m,xint);
[S,Fcal] = LastKInv(A,maxiter,.001,data,p,e,t,sig,d0,xint,Wz);

 
figure
width = 6;     % Width in inches
height = 2.5;    % Height in inches
plot(xint,d0,'b.',xint,Fcal,'r-')
set(gca,'fontweight','normal','fontsize',12);
set(gca,'TickDir','out','box','off'); % The only other option is 'in'
set(gca,'ticklength',2.5*get(gca,'ticklength'))


xlabel('Distance (m)','fontweight','normal','fontsize',12);
ylabel('Self-potential (mV)','fontweight','normal','fontsize',12);
legend({'Data','Model'},'Location','Southeast')


set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);



print('DatafitP1','-dpng','-r300');

% plot(xint,d0,'b.',xint,Fcal,'r-')



figure


width = 6;     % Width in inches
height = 2.5;    % Height in inches

pdeplot(p,e,t,'xydata',S*1000,'xystyle','flat','mesh','off');
caxis([-0.1 0.5])
set(gca,'fontweight','normal','fontsize',12);
set(gca,'TickDir','out'); % The only other option is 'in'
set(gca,'ticklength',2.5*get(gca,'ticklength'))
mycolormap = customcolormap(linspace(0,1,11), {'#a60026','#d83023','#f66e44','#faac5d','#ffdf93','#ffffbd','#def4f9','#abd9e9','#73add2','#4873b5','#313691'});
%mycolormap = customcolormap(linspace(0,1,11), {'#','#','#','#','#','#','#','#','#','#','#'});
colormap(mycolormap);
hc=colorbar('EastOutside');
hc.TickDirection='out';
hc.TickLength=0.025;
% hc.Label.Rotation = 270;
% set(get(hc,'XLabel'),'TickDir','out'); % The only other option is 'in'
% set(get(hc,'XLabel'),'ticklength',2.5*get(gca,'ticklength'))
set(get(hc,'XLabel'),'string','Natural current (mA)','fontweight','normal','fontsize',12);
xlim([0,470])
ylim([-78,0])
xlabel('Distance (m)','fontweight','normal','fontsize',12);
ylabel('Depth (m)','fontweight','normal','fontsize',12);


set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);



print('currentresponsep1','-dpng','-r300');



%set(gca, 'edgecolor','white')
caxis([-0.1 0.05])
%colorbar('southoutside')
% colormap jet
[~,~,~,V_cal,xx,yy,divJS,GammaD1] = FWD_SPdivJS(data,p,e,t,sig,S,xint);



width = 6;     % Width in inches
height = 2.5;    % Height in inches

figure
pdeplot(p,e,t,'xydata',V_cal,'xystyle','flat','mesh','off');
set(gca,'fontweight','normal','fontsize',12);
set(gca,'TickDir','out'); % The only other option is 'in'
set(gca,'ticklength',2.5*get(gca,'ticklength'))
mycolormap = customcolormap([0 .25 .5 .75 1], {'#9d0142','#f66e45','#ffffbb','#65c0ae','#5e4f9f'});
colormap(mycolormap);
hc=colorbar('EastOutside');
hc.TickDirection='out';
hc.TickLength=0.025;
set(get(hc,'XLabel'),'string','Self-potential (mV)','fontweight','normal','fontsize',12);
xlim([0,470])
ylim([-78,0])
xlabel('Distance (m)','fontweight','normal','fontsize',12);
ylabel('Depth (m)','fontweight','normal','fontsize',12);


set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);



print('Naturalpotetialimage1','-dpng','-r300');

save all_Spinversion1

aq



