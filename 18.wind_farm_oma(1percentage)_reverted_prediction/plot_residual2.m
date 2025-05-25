function plot_residual2(time_train,time_test,time_test_dam,...
    freq_owt1_train_prd,freq_owt1_train,...
    freq_owt1_test_prd,freq_owt1_test,...
    freq_owt1_test_dam_prd,freq_owt1_test_dam,...
    filename)

figurewidth = 9; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.625]*36.36);
plot([time_train,time_test,time_test_dam],...
    [freq_owt1_train;freq_owt1_test;freq_owt1_test_dam]-...
    [freq_owt1_train_prd;freq_owt1_test_prd;freq_owt1_test_dam_prd]);
xlim([min(time_train),max(time_test_dam)])
date0 = floor(min(time_train)/96);
xline((date0+16)*96,'--');
xline((date0+31)*96,'--');
xticks([date0,date0+16,date0+31,date0+38]*96);
xticklabels({'1 May','16 May','1 Jun','8 Jun'});
xlabel('Date');
if strcmp(filename,'fig.residual3.eps')
    ylim([-0.06,0.08])
end
ylabel('Prediction residual (Hz)');
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,filename,'Resolution',1000)

end