close all
clear all
clc
addpath('Distmesh');
addpath('Finite Elements Functions');
addpath('Inverse-Reg');
addpath('Plot tools');   
%load('all_information.mat')

load('all_ERTAmbetProfile2.mat')

figure
pdeplot(p,e,t ,'xydata',log10(1./sig),'xystyle','flat','mesh','on');
set(gca,'fontweight','normal','fontsize',12);
hc=colorbar('EastOutside');
% set(get(hc,'XLabel'),'string','log Resistivity (\Omega\cdotm)','fontweight','bold','fontsize',12);
%  caxis([1 2.5])
 colormap jet
%colormap(parula(3))
     cmap=colormap;
     cmap1=flipdim(cmap,1);
     colormap(cmap1);

     
     
%SP = awgn(SP,30,'measured');
%SP=SP+405.8790;

AmbetSP1data=xlsread('AmbetSPProfile2.xlsx');
 g_obs1=-movmean(AmbetSP1data(:,2),3);

xint1 = AmbetSP1data(:,1);
xint=[7:7.9:450]';
g_obs=interp1(xint1,g_obs1,xint);
 


figure
 plot(xint,g_obs)

 clear A
for i=1:size(p,2)
     disp('remaining iterations');
     size(p,2)-i % remaining iterations
    eee=zeros(size(p,2),1);
    eee(i)=1;
    
    %[SPdata] = FWD_SP(data,p,e,t,sig,eee(1,1:no_of_triangle),eee(1,no_of_triangle+1:end),xint) ;
    [SP1] = FWD_SPdivJS(data,p,e,t,sig,eee,xint);
    A(:,i)=SP1;
end

save all_inversionAmbetSP2
