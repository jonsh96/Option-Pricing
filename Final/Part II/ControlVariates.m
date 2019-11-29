function [price, variance, error, sample_size, time] = ControlVariates(Smin, Smax, dt, T, payoff, rate, volatility)
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
            mean_ST = i;
            for j = 1:N
                mean_ST = mean_ST*exp(dt*(rate(j*dt)));   % Forward value
            end

        else 
            mean_ST = i*exp(rate*T);
            var_ST = mean_ST^2*(exp(volatility^2*T)-1);

        end

        S = zeros(N,N);
        ST = zeros(1,N);
        fST = zeros(1,N);
        %gv = S0.^2.*exp(2*rate(0)*T).*(exp(volatility(S0,0).^2.*T)-1);
        for j = 1:N
            S(j,:) = GeometricBrownianMotion(i, rate, volatility, dt, T);
            ST(j) = S(j,end);
            fST(j) = payoff(S(j,:));
        end
        var_ST = var(ST);
        
        cov_fST_ST = mean(fST.*ST) - mean(fST)*mean(ST);
        c = cov_fST_ST/var_ST;
        % or
        % cov_fST_ST = cov(fST,ST);
        % c = cov_fST_ST(1,2)/var_ST;
        fc = fST-c*(ST-mean_ST);
        
        price(i) = mean(fc);
        variance(i) = var(fc);
        error(i) = payoff(i) - price(i);   
        sample_size(i) = confidence_sample(variance(i));
    end
    time = (cputime - start)/Smax;
end