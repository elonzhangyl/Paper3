function plot_prediction(time_train,time_test,time_test_dam,...
    freq_owt1_train,freq_owt1_test,freq_owt1_test_dam,...
    freq_owt1_train_prd,freq_owt1_test_prd,freq_owt1_test_dam_prd,...
    ylab,filename_prediction)

figurewidth = 9; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.625]*36.36);
plot([time_train,time_test,time_test_dam],...
    [freq_owt1_train;freq_owt1_test;freq_owt1_test_dam]);hold on
plot([[],time_test,time_test_dam],...
    [[];freq_owt1_test_prd;freq_owt1_test_dam_prd]);
hold off
xlim([min(time_train),max(time_test_dam)])
date0 = floor(min(time_train)/96);
xline((date0+16)*96,'--');
xline((date0+31)*96,'--');
xticks([date0,date0+16,date0+31,date0+38]*96);
xticklabels({'1 May','16 May','1 Jun','8 Jun'});
xlabel('Date');
ylabel(ylab);
legend1 = legend('Actual','Predicted','location','north','Box','off');
hold off
set(legend1,...
    'Position',[0.485622545448275 0.77810934560587 0.278117362327856 0.139160159043968],...
    'FontSize',7);
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,filename_prediction,'Resolution',1000)
end