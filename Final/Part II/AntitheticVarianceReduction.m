function [price, variance, error, sample_size, time] = AntitheticVarianceReduction(Smin, Smax, dt, T, payoff, rate, volatility)
    % Naive method
    price = zeros(Smax, 1);
    variance = zeros(Smax, 1);
    error = zeros(Smax, 1);
    sample_size = zeros(Smax, 1);
    N = T/dt;
    ConfidenceSample = @(v) (sqrt(v).*1.96/0.05).^2;

    start = cputime;
    for i = Smin:Smax
        S = zeros(N,N);
        Splus = zeros(N,N);
        Sminus = zeros(N,N);
        for j = 1:N
            [S(j,:), Splus(j,:), Sminus(j,:)] = GeometricBrownianMotion(i, rate, volatility, dt, T);
        end 
        Z = (payoff(Splus(:,end)) + payoff(Sminus(:,end)))/2;
        price(i) = mean(Z);
        variance(i) = var(Z);
        error(i) = payoff(i) - price(i);   
        sample_size(i) = ConfidenceSample(variance(i));
    end
    time = (cputime - start)/Smax;
end