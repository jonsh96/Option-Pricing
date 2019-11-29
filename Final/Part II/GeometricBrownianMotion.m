function [S, Splus, Sminus] = GeometricBrownianMotion(S0, rate, volatility, dt, T)
    
    N = T/dt;
    S = zeros(1,N);
    Splus = zeros(1,N);
    Sminus = zeros(1,N);
    
    S(1) = S0;
    Splus(1) = S0;
    Sminus(1) = S0;
    
    dW = sqrt(dt)*randn(1,N);
    
    if(isa(rate,'function_handle') && isa(volatility,'function_handle'))
        for i = 2:N
            dS = rate((i-1)*dt)*S(i-1)*dt+volatility(S(i-1),(i-1)*dt)*S(i-1)*dW(i-1);
            S(i) = S(i-1) + dS;
            Splus(i) = S(i-1) + dS;
            Sminus(i) = S(i-1) - dS;
        end
    else
        for i = 2:N
            dS = rate*S(i-1)*dt+volatility*S(i-1)*dW(i-1);
            S(i) = S(i-1) + dS;
            Splus(i) = S(i-1) + dS;
            Sminus(i) = S(i-1) - dS;
        end
    end
end

