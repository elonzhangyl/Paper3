
xbar1 = [-0.001927561
-0.002538495
-0.0021657
-0.00081167
-0.002408827
-0.00171311
0.000962534
0.000346612
6.10934E-05
0.000105978
0.000155851
-0.000787981
0.001352933
-0.003326476
-0.000988716
-0.003567109
0.03582445
0.035543919
0.03624213
0.03759616
0.039280593
0.037355526
0.03969578
];
plot_xbar(xbar1,...
    freq_owt1_test_dam_prd,freq_owt1_test_dam,'fig.xbar1.eps')
plot_xbar(freq_owt2_test_prd,freq_owt2_test,...
    freq_owt2_test_dam_prd,freq_owt2_test_dam,'fig.xbar2.eps')
plot_xbar(freq_owt3_test_prd,freq_owt3_test,...
    freq_owt3_test_dam_prd,freq_owt3_test_dam,'fig.xbar3.eps')


function plot_xbar(xbar,...
    freq_owt1_test_dam_prd,freq_owt1_test_dam,filename)
n_ob = 96;
n_sam = 16;
c4 = 4*(n_ob-1)/(4*n_ob-3);
A3 = 3/(c4*sqrt(n_ob));


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
xticks([1 16 23])
xticklabels({'16 May','31 May','7 Jun'});
xlabel('Date')
ylabel('Sample mean')
if strcmp(filename,'fig.xbar1.eps')
    ylim([-0.01,0.03])
end
if strcmp(filename,'fig.xbar2.eps')
    ylim([-0.01,0.03])
end
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,filename,'Resolution',1000)

end