function plot_residual(time_test,time_test_dam,...
    freq_owt1_test_prd,freq_owt1_test,...
    freq_owt1_test_dam_prd,freq_owt1_test_dam,filename)

figurewidth = 13; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.625]*36.36);
plot([time_test,time_test_dam],...
    [freq_owt1_test;freq_owt1_test_dam]-...
    [freq_owt1_test_prd;freq_owt1_test_dam_prd]);
xlabel('Date');
ylabel('Prediction residual (Hz)');
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,filename,'Resolution',1000)

end