function DistributionComparison
    % ABOUT:
    %   - Simulates the stock price assuming a local volatility model and
    %     time-dependent interest rates and also for constant interest
    %     rates and volatility. The simulations are then compared with a
    %     histogram with a normal distribution fitting, normfit.
    
    figure
    % Setting the parameters, S0 = 40 was chosen at random. The initial
    % stock price here serves no purpose other than initialising the stock
    % price simulations.
    
    S0 = 40;
    Nsteps = 260;
    M = 100000;
    dt = 1/Nsteps;

    % Defining the interest rate parameters and model
    r = [0.05, 0.5];
    sigma = [0.30, 0.12, 0.60];

    % Defining the volatility parameters and model
    rate = @(t) r(1)*exp(r(2)*t);
    volatility = @(S,t) sigma(1)*(1+sigma(2)*cos(2*pi*t))*(1+sigma(3)*exp(-S/100));

    % Initialising the matrices
    S_est = zeros(M,Nsteps+1);
    S_act = zeros(M,Nsteps+1);
    dW = sqrt(dt)*randn(M,Nsteps);

    % Initialising the simulations
    S_est(:,1) = S0;
    S_act(:,1) = S0;

    % Simulating the stock prices
    for i = 1:M
        for j = 1:Nsteps
            d_est = r(1)*S0*dt + sigma(1)*S0*dW(i,j);
            S_est(i,j+1) = S_est(i,j) + d_est;
            d_act = rate(j*dt)*S_act(i,j)*dt + volatility(S_act(i,j),j*dt)*S_act(i,j)*dW(i,j);
            S_act(i,j+1) = S_act(i,j) + d_act;
        end
    end

    % Comparing the distributions
    h_act = histfit(S_act(:,end),100,'lognormal')
    set(h_act(1),'facecolor','b'); set(h_act(2),'color','k')
    hold on
    h_est = histfit(S_est(:,end),100)
    set(h_est(1),'facecolor','r'); set(h_est(2),'color','k')
    grid on
    legend('Actual distribution', 'Actual lognormal pdf fit', 'Estimated distribution', 'Estimated normal pdf fit', 'FontSize',14)
end