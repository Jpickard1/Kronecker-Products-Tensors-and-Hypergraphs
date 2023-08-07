%% Figures
%
%   This file makes the figure to describe the run time comparisons between
%   the direct and Kronecker TTD, CPD, and Z-eigenvalue calculations.
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: August 7, 2023

close all; clear; clc;

set(groot, 'DefaultFigureRenderer', 'painters');
figure('Renderer', 'painters', 'Position', [0 0 1350 400]);
tiledlayout(1,3);
fs = 18;

load('out_cpd_experiment.mat')
nexttile;
tt = tt_CPD; tA = tA_CPD;

% Calculate mean and standard error for each row
mean_tt = mean(tt, 2);
std_error_tt = std(tt, 0, 2) / sqrt(itrs);
mean_ta = mean(tA, 2);
std_error_ta = std(tA, 0, 2) / sqrt(itrs);

% Create scatter plots
hold on;
errorbar(1:n, mean_ta, std_error_ta, 'ro', 'MarkerSize', 5, 'LineWidth', 1);
errorbar(1:n, mean_tt, std_error_tt, 'bo', 'MarkerSize', 5, 'LineWidth', 1);
hold off;

xlabel('Dimension of $$\textsf{B}$$ and $$\textsf{C}$$','Interpreter','latex');
ylabel('Time (sec.)','Interpreter','latex');
title('CPD Compute Time','Interpreter','latex');
legend(["Direct", "Kronecker"],'interpreter','latex');
set(gca, 'YScale', 'log');
set(gca, 'FontSize', fs, 'TickLabelInterpreter', 'latex');

load('out_ttd_experiment.mat');
nexttile;
tt = tt_TTD; tA = tA_TTD;
% Calculate mean and standard error for each row
mean_tt = mean(tt, 2);
std_error_tt = std(tt, 0, 2) / sqrt(itrs);
mean_ta = mean(tA, 2);
std_error_ta = std(tA, 0, 2) / sqrt(itrs);

% Create scatter plots
% figure;
hold on;
errorbar(1:25, mean_ta, std_error_ta, 'ro', 'MarkerSize', 5, 'LineWidth', 1);
errorbar(1:25, mean_tt, std_error_tt, 'bo', 'MarkerSize', 5, 'LineWidth', 1);
hold off;

xlabel('Dimension of $$\textsf{B}$$ and $$\textsf{C}$$','Interpreter','latex');
ylabel('Time (sec.)','Interpreter','latex');
title('TTD Compute Time','Interpreter','latex');
% legend(["Direct", "Kronecker"]);
set(gca, 'YScale', 'log');
set(gca, 'FontSize', fs, 'TickLabelInterpreter', 'latex');

load('out_zeigen_experiment.mat');
nexttile;
tt = tBC_eig; tA = tA_eig;
% Calculate mean and standard error for each row
mean_tt = mean(tt, 2);
std_error_tt = std(tt, 0, 2) / sqrt(itrs);
mean_ta = mean(tA, 2);
std_error_ta = std(tA, 0, 2) / sqrt(itrs);

% Create scatter plots
hold on;
errorbar(1:25, mean_ta, std_error_ta, 'ro', 'MarkerSize', 5, 'LineWidth', 1);
errorbar(1:25, mean_tt, std_error_tt, 'bo', 'MarkerSize', 5, 'LineWidth', 1);
hold off;

xlabel('Dimension of $$\textsf{B}$$ and $$\textsf{C}$$','Interpreter','latex');
ylabel('Time (sec.)','Interpreter','latex');
title('Z-Eigenvalue Compute Time','Interpreter','latex');
set(gca, 'YScale', 'log');
set(gca, 'FontSize', fs, 'TickLabelInterpreter', 'latex');

saveas(gcf, 'decomposition_and_zeigen_vf.png')
