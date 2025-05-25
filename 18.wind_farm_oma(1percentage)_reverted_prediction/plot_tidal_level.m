load('2020ILF.mat');
h = h-4.8;
%% plot tidal level - one year
figurewidth0 = 19; %cm
f = figure('Position',[10 10 figurewidth0 figurewidth0*0.25]*36.36);
% f.PositionConstraint = 'outerposition';
x = 1:length(h);y = h;
plot(x,y,...
    'LineWidth',1)
% xticks([31		90		151		212		273		334	]*96);
% xticklabels({'1 Feb','1 Apr','1 Jun','1 Aug','1 Oct','1 Dec'})
xticks([1,[31	60	91	121	152	182	213	244	274	305	335	366]*96]);
xticklabels({'1 Jan', '1 Feb','1 Mar','1 Apr','1 May','1 Jun',...
    '1 Jul','1 Aug','1 Sep','1 Oct', '1 Nov','1 Dec'});
yticks(-5:2:5)
xlim([min(x),max(x)])
ylim([-5.5 5.5])
xlabel('Date');
ylabel('Observed tidal levels (m)');
% legend('Data','GPR predictions','location','northwest','Box','off');
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,'fig.tidal_level_1year.eps','Resolution',1000)

%% plot tidal level - one month
figurewidth = 9; %cm
f = figure('Position',[10 10 figurewidth figurewidth0*0.25]*36.36);
x = 1:length(h);y = h;
plot(x,y,...
    'LineWidth',1)
xticks([121*96+1,152*96]);
xticklabels({'1 May','1 Jun'});
yticks(-5:2:5)
xlim([121*96+1,152*96])
ylim([-5.5 5.5])
xlabel('Date');
ylabel('Observed tidal levels (m)');
% legend('Data','GPR predictions','location','northwest','Box','off');
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,'fig.tidal_level_1month.eps','Resolution',1000);

%% plot tidal level - one day
figurewidth = 9; %cm
f = figure('Position',[10 10 figurewidth figurewidth0*0.25]*36.36);
x = 1:length(h);y = h;
plot(x,y,...
    'LineWidth',1,...
    'MarkerSize',2)
xticks([121*96+1,122*96]);
xticklabels({'1 May','2 May'});
yticks(-5:2:5)
xlim([121*96+1,122*96])
ylim([-5.5 5.5])
xlabel('Date');
ylabel('Observed tidal levels (m)');
% legend('Data','GPR predictions','location','northwest','Box','off');
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,'fig.tidal_level_1day.eps','Resolution',1000);