%% Initialising the values 
SetParameters;

%% Calculate the option prices numerically and with Black-Scholes
[V_PDE, S_PDE] = PDE_bullspread(K1, K2, T, rate, volatility, Smin, Smax, N, J);
V_BS = option_price(S_PDE); 
error = norm(V_PDE-V_BS,Inf);

%% Plotting the result
PlotComparison(S_PDE, V_PDE, V_BS)

%% Error analysis of Smax for constant N and J
ErrorAnalysis(K1, K2, T, rate, volatility, Smin, Smax, N, J, option_price)

%% Measurements of M = 1000 Monte Carlo simulations
[times, prices, variances, sample_sizes] = MonteCarlo(K1, K2, Smin, Smax, rate, volatility, dt, T, M, option_payoff, option_price);

%% Printing the results
PrintResults(times, variances, sample_sizes);

%% Plotting the different methods
PlotMonteCarlo(Smin, Smax, prices, option_price)

%% Plotting the different methods (not used in report)
figure
for i = 1:4
    subplot(4,1,i)
    PlotDifference(Smin, Smax, prices, i, option_price)
end

%% Plotting the results
PlotResults(sample_sizes);

%% Calculating the delta of the bull call spread
delta = AntitheticDelta(M, rate, volatility, dt, T, Smin, Smax, option_payoff);
plot(Smin:Smax,delta,'r-o')
hold on
plot(Smin:Smax,option_delta(Smin:Smax),'k','LineWidth',1.5)
plot(S_PDE(1:end-1),calculateDelta(S_PDE,V_PDE))
grid on
xlabel('Stock price (£)','FontSize',14)
ylabel('Delta value (\Delta)','FontSize',14)
legend('Numerical solution','Black Scholes solution','FontSize',14)

% DO PATH RECYCLING?
function delta = calculateDelta(S,V)
    delta = zeros(1,size(S,2)-1);
    for i = 1:size(S,2)-1
        delta(i) = (V(i+1)-V(i))/(S(i+1)-S(i));
    end
end