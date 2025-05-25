function plot_xbar2(freq_owt1_train_prd,freq_owt1_train,...
    freq_owt1_test_prd,freq_owt1_test,...
    freq_owt1_test_dam_prd,freq_owt1_test_dam,filename)
n_ob = 96;
n_sam = 16;
c4 = 4*(n_ob-1)/(4*n_ob-3);
A3 = 3/(c4*sqrt(n_ob));

x = reshape(freq_owt1_test_prd(2:end)-freq_owt1_test(2:end),...
    n_ob,n_sam);
xbar = mean(x);
xbarbar = mean(xbar);
sbar = mean(std(x));

ucl = xbarbar+A3*sbar;
lcl = xbarbar-A3*sbar;

nend1 = length(freq_owt1_test_dam_prd);
nend2 = length(freq_owt1_test_dam);
x_future = reshape(freq_owt1_test_dam_prd(2:nend1)-...
    freq_owt1_test_dam(2:nend2),n_ob,7);
xbar_future = mean(x_future);

% plot xbar
figurewidth = 9; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.5]*36.36);
p1 = plot(1:length(xbar),xbar,'o');hold on    
p2 = plot(length(xbar)+1:length(xbar)+length(xbar_future),...
    xbar_future,'o');
hold off
% ylim([min(xbar_future)-0.005,ucl+0.01])
yline(ucl,'r');
yline(lcl,'r');
xline(n_sam+0.5,'--')
% text(1,ucl+0.002,'UCL')
% text(1,lcl-0.002,'LCL')
xticks([1 16 17 23])
xticklabels({'16 May','31','1','7 Jun'});
xlabel('Date')
ylabel('Sample mean')
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,filename,'Resolution',1000)

end