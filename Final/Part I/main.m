%% Initialising the values 
SetParameters;

%% Calculate the option prices numerically and with Black-Scholes
[V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);
V_BS = BS_bullspread(S); 
error(Smax-1) = norm(V_PDE-V_BS,Inf);


%% Plotting the result
plotComparison(S, V_PDE, V_BS)

%% Error analysis of Smax for constant N and J
errorAnalysis(K1, K2, T, r, sigma, Smin, Smax, N, J, BS_bullspread)

%% Measurements of 1000 Monte Carlo simulations
M = 1000;
[times, prices, variances, errors, sample_sizes] = MonteCarloBullspread(Smin, Smax, K1, K2, r, sigma, T, M, payoff, BS_bullspread);

%% Printing the results
printResults(times, variances, errors, sample_sizes);

%% Plotting the different methods
plotMonteCarlo(Smin, Smax, prices, BS_bullspread)

%% Plotting the different methods
figure
for i = 1:4
    subplot(4,1,i)
    plotDifference(Smin, Smax, prices, i, BS_bullspread)
end

%% Plotting the results
plotResults(times, prices, variances, errors, sample_sizes);

%% DELTA STUFF
% plot(delta(1:200))
% grid on
delta = calculateDelta(1:200,prices(2,:));
% plot(S(1:end-1),delta,'r-o')
% hold on
% plot(S,BS_delta(S),'k-d')
plot(delta)
grid on
xlabel('Stock price (£)','FontSize',14)
ylabel('Delta value (\Delta)','FontSize',14)
legend('Numerical solution','Black Scholes solution','FontSize',14)

% norm(delta-BS_delta(S(1:end-1)),Inf)

% DO PATH RECYCLING


function delta = calculateDelta(S,V)
    delta = zeros(1,size(S,2)-1);
    for i = 1:size(S,2)-1
        delta(i) = (V(i+1)-V(i))/(S(i+1)-S(i));
    end
end
