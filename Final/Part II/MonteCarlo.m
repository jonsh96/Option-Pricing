function [price, variance, error, sample_size, time] = MonteCarlo(Smin, Smax, dt, T, method, payoff, rate, volatility)
    
    switch method
        case "Naive"
            [price, variance, error, sample_size, time] = NaiveMethod(Smin, Smax, dt, T, payoff, rate, volatility);
        case "Antithetic variance reduction"
            [price, variance, error, sample_size, time] = AntitheticVarianceReduction(Smin, Smax, dt, T, payoff, rate, volatility);
        case "Control variates"
            [price, variance, error, sample_size, time] = ControlVariates(Smin, Smax, dt, T, payoff, rate, volatility);
        case "Importance sampling"
            [price, variance, error, sample_size, time] = ImportanceSampling(Smin, Smax, dt, T, payoff, rate, volatility);
    end    
end

