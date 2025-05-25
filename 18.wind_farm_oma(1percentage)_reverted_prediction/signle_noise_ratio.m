clear
clc
sqenc = 1;
ReSmp = 1;
%% Load data set no wave - 5min
load('parked_dense_node_seed1To210and1001To1300_y.mat')
Dataset10 = dataset1(:,1,1);
dataset1 = Dataset10(1:ReSmp:end,:); %resample
noise = 0.0315*randn(size(dataset1))...
                    .*(ones(size(dataset1)).*rms(dataset1));
                
r = snr(dataset1,noise) %dB

