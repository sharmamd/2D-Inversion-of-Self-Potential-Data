close all

figure

plot(xint,d0,'b.',xint,Fcal,'r-')



figure
pdeplot(p,e,t,'xydata',S*1000,'xystyle','flat','mesh','on');
%set(gca, 'edgecolor','white')
caxis([-0.1 0.05])
%colorbar('southoutside')
colormap jet
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
set(get(hc,'XLabel'),'string','Self-potential (mV)','fontweight','normal','fontsize',12);
xlim([0 520])
ylim([-80 0])
xlabel('Distance (m)','fontweight','normal','fontsize',12);
ylabel('Depth (m)','fontweight','normal','fontsize',12);


set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);



print('Naturalpotetialimage2','-dpng','-r300');
