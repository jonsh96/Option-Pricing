function [S, Splus, Sminus] = GeometricBrownianMotion(S0, rate, volatility, dt, T)
    
    N = T/dt;
    dW = sqrt(dt)*randn(1,N);
    
    if(isa(rate,'function_handle') && isa(volatility,'function_handle'))
        S = zeros(1,N);
        Splus = zeros(1,N);
        Sminus = zeros(1,N);
        S(1) = S0;
        Splus(1) = S0;
        Sminus(1) = S0;
        
        for i = 2:N
            dS = rate((i-1)*dt)*S(i-1)*dt+volatility(S(i-1),(i-1)*dt)*S(i-1)*dW(i-1);
            S(i) = S(i-1) + dS;
            Splus(i) = Splus(i-1) + dS;
            Sminus(i) = Sminus(i-1) - dS;
        end
    else
        if(dt == T)
            S = S0*exp((rate-0.5*volatility^2)*T+volatility.*dW);
            Splus = S0*exp((rate-0.5*volatility^2)*T+volatility.*dW);
            Sminus = S0*exp((rate-0.5*volatility^2)*T-volatility.*dW);
        else
            S = zeros(1,N);
            Splus = zeros(1,N);
            Sminus = zeros(1,N);

            S(1) = S0;
            Splus(1) = S0;
            Sminus(1) = S0;
            for i = 2:N
                dS = rate*S(i-1)*dt+volatility*S(i-1)*dW(i-1);
                S(i) = S(i-1) + dS;
                Splus(i) = Splus(i-1) + dS;
                Sminus(i) = Sminus(i-1) - dS;
            end
        end
    end
end

