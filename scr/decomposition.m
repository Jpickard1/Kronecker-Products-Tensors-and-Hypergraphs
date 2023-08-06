%% Tensor Decompositions
%
%   This file contains code to perform the tensor train and canonical
%   poliadic decompositions to tensors with Kronecker structure.
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: August 6, 2023

%% Tensor Train Decomposition
close all; clear; clc;

n = 25;                 % maximum size of factor tensors
itrs = 5;               % number of trials for each size

tA = zeros(n, itrs);    % records the time to compute decompositions of A, 
tB = zeros(n, itrs);    % B, and C
tC = zeros(n, itrs);

for i=1:n
    for j=1:itrs
        disp(i);
        B = rand(i,i,i);    % Sample random tensors B and C from uniform
        C = rand(i,i,i);    % distribution
        A = superkron(B,C); % Form composite tensor A = B kron C
    
        tic;
        eb = tt_tensor(B);  % time TTD of B
        tB(i,j) = toc;
        tic;
        ec = tt_tensor(C);  % time TTD of C
        tC(i,j) = toc;
        tic;
        ea = tt_tensor(A);  % time TTD of A
        tA(i,j) = toc;
    end
end

tt_TTD = tB+tC; % rename and sum total time for the Kronecker TTD
tA_TTD = tA;    % rename time variable for A

save("out_ttd_experiment.mat");

%% Canonical Polyiadic Decomposition
close all; clear; clc;

n = 25;                 % maximum size of factor tensors
itrs = 5;               % number of trials for each size

tA = zeros(n, itrs);    % records the time to compute decompositions of A, 
tB = zeros(n, itrs);    % B, and C
tC = zeros(n, itrs);

r = 4;                      % CP rank of B and C
for i=1:n
    for j=1:itrs
        disp(i);
        B = rand(i,i,i);    % Sample random tensors B and C from uniform
        C = rand(i,i,i);    % distribution
        A = superkron(B,C); % Form composite tensor A = B kron C

        tic;
        Bc = cp_als(tensor(B), r);  % time CPD of B
        tB(i,j) = toc;
        tic;
        Cc = cp_als(tensor(C), r);  % time CPD of C
        tC(i,j) = toc;
        tic;
        Ac = cp_als(tensor(A), r^2);% time CPD of A
        tA(i,j) = toc;
    end
end
tt_CPD = tB + tC;   % rename and sum total time for the Kronecker CPD
tA_CPD = tA;        % rename time variable for A

save("out_cpd_experiment.mat");
