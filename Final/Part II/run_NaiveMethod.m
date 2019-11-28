function [price, variance, error, sample_size, time] = run_NaiveMethod(Smin, Smax, dt, T, payoff, rate, volatility)
    % Naive method
    price = zeros(Smax, 1);
    variance = zeros(Smax, 1);
    error = zeros(Smax, 1);
    sample_size = zeros(Smax, 1);
    N = T/dt;
    confidence_sample = @(v) (sqrt(v).*1.96/0.05).^2;
    start = cputime;
    
    for i = Smin:Smax
        S = zeros(N,N);
        for j = 1:N
            S(j,:) = geometric_brownian_motion(i, rate, volatility, dt, T);
        end
        price(i) = mean(payoff(S(:,end)));
        variance(i) = var(payoff(S(:,end)));
        error(i) = payoff(i) - price(i);   
        sample_size(i) = confidence_sample(variance(i));
    end
    time = (cputime - start)/Smax;
end