close all
clc
width = 6;     % Width in inches
height = 2.5;    % Height in inches

figure
       
       xd=data.xd;
      psd=data.psd;
      [xc,yc]=meshgrid(unique(xd),unique(psd));
     zT=griddata((xd(:)),psd(:),ro,xc,yc,'linear');
     zT=log10(zT);
       %pcolor(unique(xd),unique(psd),real(zT));
       contourf(unique(xd),unique(psd),(zT),32,'LineStyle','none','tag','log');
        
       set(gca,'fontweight','normal','fontsize',12);
set(gca,'TickDir','out'); % The only other option is 'in'
set(gca,'ticklength',2.5*get(gca,'ticklength'))

mycolormap = customcolormap([0 .25 .5 .75 1], {'#9d0142','#f66e45','#ffffbb','#65c0ae','#5e4f9f'});
colormap (mycolormap)
hc=colorbar('EastOutside');
hc.TickDirection='out';
hc.TickLength=0.025;
% hc.Label.Rotation = 270;
% set(get(hc,'XLabel'),'TickDir','out'); % The only other option is 'in'
% set(get(hc,'XLabel'),'ticklength',2.5*get(gca,'ticklength'))
set(get(hc,'XLabel'),'string','Log_1_0 (App. Res.,ohm-m)','fontweight','normal','fontsize',12);
% xlim([0,470])
% ylim([-78,0])
xlabel('Distance (m)','fontweight','normal','fontsize',12);
ylabel('Depth (m)','fontweight','normal','fontsize',12);


set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);



print('ERTfielddataP2','-dpng','-r300');
       
   