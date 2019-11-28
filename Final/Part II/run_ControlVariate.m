function [price, variance, error, sample_size, time] = run_ControlVariate(Smin, Smax, dt, T, payoff, rate, volatility)
    % Control variate
    price = zeros(Smax, 1);
    variance = zeros(Smax, 1);
    error = zeros(Smax, 1);
    sample_size = zeros(Smax, 1);
    N = T/dt;
    confidence_sample = @(v) (sqrt(v).*1.96/0.05).^2;

    start = cputime;
    g = @(S) S;
    for i = Smin:Smax
        if(isa(rate,'function_handle') && isa(volatility,'function_handle'))
            gm = i;
            for j = 1:N
                gm = gm*exp(dt*(rate(j*dt)));   % Forward value
            end
        else 
            gm = i*exp(rate*T);
        end

        S = zeros(N,N);
        %gv = S0.^2.*exp(2*rate(0)*T).*(exp(volatility(S0,0).^2.*T)-1);
        for j = 1:N
            S(j,:) = geometric_brownian_motion(i, rate, volatility, dt, T);
        end
        covariance_matrix = cov(payoff(S(:,end)),S(:,end));
        c = covariance_matrix(1,2)/var(S(:,end));
        fcv = var(payoff(S(:,end)))*(1-(covariance_matrix(1,2))^2/(var(payoff(S(:,end)))*var(g(S(:,end)))));
        fc = payoff(S(:,end)-c.*(g(S(:,end))-gm));
        price(i) = mean(fc);
        variance(i) = var(fc);
        error(i) = payoff(i) - price(i);   
        sample_size(i) = confidence_sample(variance(i));
    end
    time = (cputime - start)/Smax;
end