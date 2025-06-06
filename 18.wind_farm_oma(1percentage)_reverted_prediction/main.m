clear
clc
%% freq extract
node = 11;
n_order = 2:30;
    
load('parked_dense_node_seed1To210and1001To1300_y.mat')
data1 = squeeze(dataset1(:,node,:,:));
freq_sim_owt1 = freq_extract_oma(data1,n_order,1.51,1.8,1.6*0.01,0.2);
plot(freq_sim_owt1(:),'.')

freq_sim_owt2 = freq_sim_owt1;% ref

load('parked_water25m_seed211To420and1301To1600_y.mat')
data1 = squeeze(dataset1(:,node,:,:));
freq_sim_owt3 = freq_extract_oma(data1,n_order,1.4,1.8,1.6*0.01,0.2);
% plot(freq_sim_owt3(:),'.')

load('parked_water20m_dam0.1_seed1891To1900_y.mat')
data1 = squeeze(dataset1(:,node,:,:));
freq_sim_owt1_dam = freq_extract_oma(data1,n_order,1.45,1.7,1.6*0.01,0.2);

plot(1:510,freq_sim_owt1(:),'.',1:510,freq_sim_owt3(:),'.',...
    1:510,freq_sim_owt1_dam(:),'.')
legend('undamaged 1','undamaged 2','damaged 1')
xlabel('water level')
ylabel('feature')


plot(1:51,mean(freq_sim_owt1),1:51,mean(freq_sim_owt3),...
    1:51,mean(freq_sim_owt1_dam))

%% interposition 
tide_simu = -4.8:0.2:5.2;
load('2020ILF.mat');
h = h-4.8;
time_train = (121*96):(121*96+15*96);
tide_train = h(time_train);
freq_owt1_train = measure_gen(tide_simu,freq_sim_owt1,tide_train);
freq_owt2_train = measure_gen(tide_simu,freq_sim_owt2,tide_train);
freq_owt3_train = measure_gen(tide_simu,freq_sim_owt3,tide_train);
freq_train = [freq_owt1_train;freq_owt2_train;freq_owt3_train];

time_test = (121*96+15*96):(121*96+31*96);
tide_test = h(time_test);
freq_owt1_test = measure_gen(tide_simu,freq_sim_owt1,tide_test);
freq_owt2_test = measure_gen(tide_simu,freq_sim_owt2,tide_test);
freq_owt3_test = measure_gen(tide_simu,freq_sim_owt3,tide_test);
freq_test = [freq_owt1_test;freq_owt2_test;freq_owt3_test];

time_test_dam = (121*96+31*96):(121*96+38*96);
tide_test_dam = h(time_test_dam);
freq_owt1_test_dam = measure_gen...
    (tide_simu,freq_sim_owt1_dam,tide_test_dam)+0.01;
freq_owt2_test_dam = measure_gen...
    (tide_simu,freq_sim_owt2,tide_test_dam);
freq_owt3_test_dam = measure_gen...
    (tide_simu,freq_sim_owt3,tide_test_dam);
freq_test_dam = [freq_owt1_test_dam;freq_owt2_test_dam;...
    freq_owt3_test_dam];


%% plot freq vs time - two yaxis
figurewidth = 12; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.35]*36.36);
plot(1:3651,[freq_owt1_train;freq_owt1_test;freq_owt1_test_dam])
xticks([15*96 31*96 38*96])
xticklabels({'16 May','31 May','7 Jun'});
xlabel('Date')
ylabel('f_{OWT1}')
xlim([15*96 38*96])
xline(31*96,'r--')

figurewidth = 12; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.35]*36.36);
plot(1:3651,[freq_owt2_train;freq_owt2_test;freq_owt2_test_dam])
xticks([15*96 31*96 38*96])
xticklabels({'16 May','31 May','7 Jun'});
xlabel('Date')
ylabel('f_{OWT2}')
xlim([15*96 38*96])
xline(31*96,'r--')

figurewidth = 12; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.35]*36.36);
plot(1:3651,[freq_owt3_train;freq_owt3_test;freq_owt3_test_dam])
xticks([15*96 31*96 38*96])
xticklabels({'16 May','31 May','7 Jun'});
xlabel('Date')
ylabel('f_{OWT3}')
xlim([15*96 38*96])
xline(31*96,'r--')
% plot_freq_tide_date(time_train,tide_train,time_train,freq_owt2_test_dam)
% hold on
% plot_freq_tide_date(time_train,tide_train,freq_owt1_test_dam)
% 
% plot(1:length(freq_owt1_test_dam),freq_owt1_test_dam,1:length(freq_owt1_test_dam),freq_owt2_test_dam)
% plot(1:length(freq_owt1_test_dam),freq_owt1_test_dam,1:length(freq_owt1_test),freq_owt1_test)

% plot(time_train,freq_owt1_train);hold on
% plot(time_test,freq_owt1_test)
%% Gaussian process regression
% gprMd3l = fitrgp(freq_owt3_train,freq_owt1_train,...
%     'KernelFunction','ardsquaredexponential',...
%     'OptimizeHyperparameters','auto',...
%     'HyperparameterOptimizationOptions',struct('kfold',5),...
%     'Basis','linear',...
%     'FitMethod','exact','PredictMethod','exact');
% ypred31 = resubPredict(gprMd3l);
% gprMd3l = fitrgp(freq_owt3_train,freq_owt1_train,'Basis','linear',...
%       'FitMethod','exact','PredictMethod','exact');
% 
% gprMd12 = fitrgp(freq_owt1_train,freq_owt2_train,'Basis','linear',...
%       'FitMethod','exact','PredictMethod','exact');
% 
% gprMd23 = fitrgp(freq_owt2_train,freq_owt3_train,'Basis','linear',...
%       'FitMethod','exact','PredictMethod','exact');

gprMd13 = fitrgp(freq_owt1_train,freq_owt3_train,'Basis','linear',...
      'FitMethod','exact','PredictMethod','exact');

gprMd21 = fitrgp(freq_owt2_train,freq_owt1_train,'Basis','linear',...
      'FitMethod','exact','PredictMethod','exact');

gprMd32 = fitrgp(freq_owt3_train,freq_owt2_train,'Basis','linear',...
      'FitMethod','exact','PredictMethod','exact');

% freq_owt1_train_prd = resubPredict(gprMd3l);
% freq_owt1_train_prd = predict(gprMd3l,freq_owt3_train);
% freq_owt2_train_prd = predict(gprMd12,freq_owt1_train);
% freq_owt3_train_prd = predict(gprMd23,freq_owt2_train);
% 
% 
% freq_owt1_test_prd = predict(gprMd3l,freq_owt3_test);
% freq_owt2_test_prd = predict(gprMd12,freq_owt1_test);
% freq_owt3_test_prd = predict(gprMd23,freq_owt2_test);
% 
% 
% freq_owt1_test_dam_prd = predict(gprMd3l,freq_owt3_test_dam);
% freq_owt2_test_dam_prd = predict(gprMd12,freq_owt1_test_dam);
% freq_owt3_test_dam_prd = predict(gprMd23,freq_owt2_test_dam);
freq_owt1_train_prd = predict(gprMd21,freq_owt2_train);
freq_owt2_train_prd = predict(gprMd32,freq_owt3_train);
freq_owt3_train_prd = predict(gprMd13,freq_owt1_train);


freq_owt1_test_prd = predict(gprMd21,freq_owt2_test);
freq_owt2_test_prd = predict(gprMd32,freq_owt3_test);
freq_owt3_test_prd = predict(gprMd13,freq_owt1_test);


freq_owt1_test_dam_prd = predict(gprMd21,freq_owt2_test_dam);
freq_owt2_test_dam_prd = predict(gprMd32,freq_owt3_test_dam);
freq_owt3_test_dam_prd = predict(gprMd13,freq_owt1_test_dam);


%% plot regression
plot_regression(freq_owt3_train,freq_owt1_train,freq_owt1_train_prd,...
    'Frequencies of OWT 3 (Hz)','Frequencies of OWT 1 (Hz)',...
    'fig.regression1.eps');
plot_regression(freq_owt1_train,freq_owt2_train,freq_owt2_train_prd,...
    'Frequencies of OWT 1 (Hz)','Frequencies of OWT 2 (Hz)',...
    'fig.regression2.eps');
plot_regression(freq_owt2_train,freq_owt3_train,freq_owt3_train_prd,...
    'Frequencies of OWT 2 (Hz)','Frequencies of OWT 3 (Hz)',...
    'fig.regression3.eps');

%% plot prediction
plot_prediction(time_train,time_test,time_test_dam,...
    freq_owt1_train,freq_owt1_test,freq_owt1_test_dam,...
    freq_owt1_train_prd,freq_owt1_test_prd,freq_owt1_test_dam_prd,...
    'SS2 of OWT 1 (Hz)','fig.prediction1.eps');
plot_prediction(time_train,time_test,time_test_dam,...
    freq_owt2_train,freq_owt2_test,freq_owt2_test_dam,...
    freq_owt2_train_prd,freq_owt2_test_prd,freq_owt2_test_dam_prd,...
    'SS2 of OWT 2 (Hz)','fig.prediction2.eps');
plot_prediction(time_train,time_test,time_test_dam,...
    freq_owt3_train,freq_owt3_test,freq_owt3_test_dam,...
    freq_owt3_train_prd,freq_owt3_test_prd,freq_owt3_test_dam_prd,...
    'SS2 of OWT 3 (Hz)','fig.prediction3.eps');


%% plot redidual
% plot_residual(time_test,time_test_dam,...
%     freq_owt1_test_prd,freq_owt1_test,...
%     freq_owt1_test_dam_prd,freq_owt1_test_dam,'fig.redidual1.eps');
% plot_residual(time_test,time_test_dam,...
%     freq_owt2_test_prd,freq_owt2_test,...
%     freq_owt2_test_dam_prd,freq_owt2_test_dam,'fig.redidual2.eps');
% plot_residual(time_test,time_test_dam,...
%     freq_owt3_test_prd,freq_owt3_test,...
%     freq_owt3_test_dam_prd,freq_owt3_test_dam,'fig.redidual3.eps');

plot_residual2(time_train,time_test,time_test_dam,...
    freq_owt1_train_prd,freq_owt1_train,...
    freq_owt1_test_prd,freq_owt1_test,...
    freq_owt1_test_dam_prd,freq_owt1_test_dam,...
    'fig.residual1.eps');
plot_residual2(time_train,time_test,time_test_dam,...
    freq_owt2_train_prd,freq_owt2_train,...
    freq_owt2_test_prd,freq_owt2_test,...
    freq_owt2_test_dam_prd,freq_owt2_test_dam,...
    'fig.residual2.eps');
plot_residual2(time_train,time_test,time_test_dam,...
    freq_owt3_train_prd,freq_owt3_train,...
    freq_owt3_test_prd,freq_owt3_test,...
    freq_owt3_test_dam_prd,freq_owt3_test_dam,...
    'fig.residual3.eps');


%% x bar
plot_xbar(freq_owt1_test_prd,freq_owt1_test,...
    freq_owt1_test_dam_prd,freq_owt1_test_dam,'fig.xbar1.eps')
plot_xbar(freq_owt2_test_prd,freq_owt2_test,...
    freq_owt2_test_dam_prd,freq_owt2_test_dam,'fig.xbar2.eps')
plot_xbar(freq_owt3_test_prd,freq_owt3_test,...
    freq_owt3_test_dam_prd,freq_owt3_test_dam,'fig.xbar3.eps')

% plot_xbar_ppt(freq_owt1_test_prd,freq_owt1_test,...
%     freq_owt1_test_dam_prd,freq_owt1_test_dam,'fig.xbar1.eps')
% plot_xbar_ppt(freq_owt2_test_prd,freq_owt2_test,...
%     freq_owt2_test_dam_prd,freq_owt2_test_dam,'fig.xbar2.eps')
% plot_xbar_ppt(freq_owt3_test_prd,freq_owt3_test,...
%     freq_owt3_test_dam_prd,freq_owt3_test_dam,'fig.xbar3.eps')

% plot_xbar2(freq_owt1_train_prd,freq_owt1_train,...
%     freq_owt1_test_prd,freq_owt1_test,...
%     freq_owt1_test_dam_prd,freq_owt1_test_dam,'fig.xbar1.eps')
% plot_xbar2(freq_owt2_train_prd,freq_owt2_train,...
%     freq_owt2_test_prd,freq_owt2_test,...
%     freq_owt2_test_dam_prd,freq_owt2_test_dam,'fig.xbar2.eps')
% plot_xbar2(freq_owt3_train_prd,freq_owt3_train,...
%     freq_owt3_test_prd,freq_owt3_test,...
%     freq_owt3_test_dam_prd,freq_owt3_test_dam,'fig.xbar3.eps')


