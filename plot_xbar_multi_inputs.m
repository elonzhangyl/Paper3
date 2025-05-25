
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
];
xbar_future1 = [0.03582445
0.035543919
0.03624213
0.03759616
0.039280593
0.037355526
0.03969578];
xbar2 = [0.001238077
0.000955053
0.001325354
-0.001250545
0.002070943
0.002438751
-0.000139642
0.001547285
0.000603454
0.001306652
3.49105E-05
0.001719344
-0.002170688
0.000494982
-0.000441369
0.0022243];
xbar_future2 = [-0.016098747
-0.014744717
-0.014041519
-0.01564117
-0.011328471
-0.012925628
-0.014194876];
xbar3=[2.10744E-05
0.00070861
-0.00026789
0.000299427
0.001652625
0.001553879
0.00259983
0.001503908
0.001194368
0.001550591
0.001688945
0.001045851
0.000946756
0.001422401
0.001231136
0.001013766
];
xbar_future3 = [-0.00791627
-0.008254358
-0.007793361
-0.005522751
-0.008427587
-0.006582352
-0.007027805];


%% x bar
plot_xbar(xbar1, xbar_future1,'fig.xbar1.eps')
plot_xbar(xbar2, xbar_future2,'fig.xbar2.eps')
plot_xbar(xbar3, xbar_future3,'fig.xbar3.eps')

function plot_xbar(xbar, xbar_future, filename)
n_sam = 16;
% plot xbar
figurewidth = 9; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.5]*36.36);
p1 = plot(1:length(xbar),xbar,'o');hold on    
p2 = plot(length(xbar)+1:length(xbar)+length(xbar_future),...
    xbar_future,'o');
hold off
xline(n_sam+0.5,'--')
xticks([1 16 23])
xticklabels({'16 May','31 May','7 Jun'});
xlabel('Date')
ylabel('Sample mean')
ylim([-0.02,0.05])
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,filename,'Resolution',1000)

end