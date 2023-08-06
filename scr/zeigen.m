%% Z-eigenvalue Calculations
%
%   This file contains code to perform Z-eigenvalue calculations for 
%   tensors with Kronecker structure.
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: August 6, 2023

maxN = 25;                  % Maximum size of factor tensors
itrs = 5;                   % Number of trials for each size

tA = zeros(maxN, itrs);     % Time to record calculations on A
tBC = zeros(maxN, itrs);    % Time to record calculations on B and C

for n=1:maxN
    disp(n);
    for i=1:itrs
        B = randSym3way(n); % Sample random supersymmetric tensors B and C
        C = randSym3way(n); % from a uniform distribution
        A = superkron(B,C); % Construct composite tensor A = B kron C
        
        xB = rand(n, 1);    % Set initial guess for B and C randomly
        xC = rand(n, 1);
        xA = kron(xB,xC);   % Set initial guess for A
        
        tic;                % Time Z-eigenvalue calculations for B and C
        [eB,vB] = eig_sshopm(tensor(B), 'Start', xB);
        [eC,vC] = eig_sshopm(tensor(C), 'Start', xC);
        tBC(n,i) = toc;
        
        tic;                % Time Z-eigenvalue calculations for A
        [eA,vA] = eig_sshopm(tensor(A), 'Start', xA);
        tA(n,i) = toc;
        
        disp(string(tBC(n,i)) + " -- " + string(tA(n,i)));
        disp(sum(abs(vA - kron(vB,vC))));
    end
end

tA_eig = tA;
tBC_eig = tBC;

save("out_zeigen_experiment.mat");