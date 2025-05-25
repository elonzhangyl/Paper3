function plot_freq_tide_date(time_train,tide_train,freq_owt1_train)
figurewidth0 = 19; %cm
f = figure('Position',[10 10 figurewidth0 figurewidth0*0.25]*36.36);
yyaxis right
plot(time_train,-(tide_train),'-','LineWidth',1)
yticks(-5:2:5)
ylim([-7 7])
ylabel('Opposite tidal level (m)');
yyaxis left
plot(time_train,(freq_owt1_train),'.')
ylabel('Frequencies (Hz)');
yticks(1.45:0.1:1.75)
ylim([min(freq_owt1_train),max(freq_owt1_train)])
xlim([min(time_train),max(time_train)])
xticks([floor(min(time_train)/96):floor(max(time_train)/96)]*96);
xticklabels({'1 May','2','3','4','5','6','7','8','9','10','11',...
    '12','13','14','15','16 May'});
xlabel('Date');
legend('Frequency','Opposite tidal level','location',...
    'northwest','Box','on','orientation','vertical');
% grid on
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,'fig.freq_tidal_level_vs_date.eps','Resolution',1000);