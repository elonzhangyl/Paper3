function plot_regression(freq_owt3_train,freq_owt1_train,...
    freq_owt1_train_prd,...
    xlab,ylab,filename_regression)

[x_reg,idx_reg] = sort(freq_owt3_train);
y_reg = freq_owt1_train(idx_reg);
y_reg_prd = freq_owt1_train_prd(idx_reg);

figurewidth = 9; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.625]*36.36);
plot(x_reg,y_reg,'.');
hold on;
plot(x_reg,y_reg_prd,'LineWidth',1.5);
xlabel(xlab);
ylabel(ylab);
legend('Actual','Predicted','location','northwest','Box','off');
hold off
% yticks(1.45:0.02:1.54)
xlim([min(x_reg),max(x_reg)])
ylim([min(y_reg),max(y_reg)])
set(findall(gcf,'-property','FontSize'),'FontSize',7)
%exportgraphics(f,filename_regression,'Resolution',1000)

end