% clc;clear;
% %% Load data set no wave - 5min
load('parked_dense_node_seed1To210and1001To1300_y.mat')
dataset11 = dataset1;
load('parked_water20m_dam0.1_seed1891To1900_y.mat')
dataset21 = dataset1;

alpha = 0.0315;
dataset_test_1 = dataset11(:,11,26,2);
Dataset10 = dataset_test_1 + alpha*randn(size(dataset_test_1))...
                    .*(ones(size(dataset_test_1)).*rms(dataset_test_1));
dataset_test_2 = dataset21(:,11,26,2);
Dataset2 = dataset_test_2 + alpha*randn(size(dataset_test_2))...
                    .*(ones(size(dataset_test_2)).*rms(dataset_test_2));
fs = 20;
% plot(100:200,Dataset10(100:200))
% pwelch(Dataset10,[],[],[],fs)
%% plot
figurewidth = 9; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.4]*29.1);
plot(1:length(Dataset10),Dataset10)
xlim([0,12000])
xticks(0:2*60*fs:10*60*fs);
xticklabels({'0','120','240','360','480','600'})
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
% ylim([-0.01,0.01])
% title('(a)')
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,'fig.acceleration_a.eps','Resolution',1000)

figurewidth = 9; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.4]*29.1);
plot(1:length(Dataset2),Dataset2)
xlim([0,12000])
xticks(0:2*60*fs:10*60*fs);
xticklabels({'0','120','240','360','480','600'})
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
% ylim([-0.01,0.01])
% title('(a)')
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,'fig.acceleration_b.eps','Resolution',1000)

figurewidth = 9; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.4]*29.1);
plot(400*fs:410*fs,Dataset10(400*fs:410*fs,1))
xticks(400*fs:40:410*fs)
xticklabels({'400','402','404','406','408','410'})
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
ylim([-0.01,0.01])
% title('(c)')
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,'fig.acceleration_c.eps','Resolution',1000)

figurewidth = 9; %cm
f = figure('Position',[10 10 figurewidth figurewidth*0.4]*29.1);
plot(400*fs:410*fs,Dataset2(400*fs:410*fs,1))
xticks(400*fs:40:410*fs)
xticklabels({'400','402','404','406','408','410'})
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
ylim([-0.01,0.01])
% title('(d)')
set(findall(gcf,'-property','FontSize'),'FontSize',7)
exportgraphics(f,'fig.acceleration_d.eps','Resolution',1000)

% get(figure,'default')

% set(findall(gcf,'-property','linewidth'),'linewidth',1)
% [acf,lags,~] = autocorr(Dataset10,'NumLags',20);
% plot(lags,acf,'-o')



