function [S, Splus, Sminus] = GeometricBrownianMotion(S0, rate, volatility, dt, T)
    % TODO: COMMENT
    Nsteps = T/dt;
    dW = sqrt(dt)*randn(1,Nsteps+1);
    
    if(isa(rate,'function_handle') && isa(volatility,'function_handle'))
        S = zeros(1,Nsteps+1);
        Splus = zeros(1,Nsteps+1);
        Sminus = zeros(1,Nsteps+1);
        S(1) = S0;
        Splus(1) = S0;
        Sminus(1) = S0;
        
        for i = 1:Nsteps
            dS = rate(i*dt)*S(i)*dt+volatility(S(i),i*dt)*S(i)*dW(i);
            dSplus = rate(i*dt)*Splus(i)*dt+volatility(Splus(i),i*dt)*Splus(i)*dW(i);
            dSminus = rate(i*dt)*Sminus(i)*dt+volatility(Sminus(i),i*dt)*Sminus(i)*dW(i);
            S(i+1) = S(i) + dS;
            Splus(i+1) = Splus(i) + dSplus;
            Sminus(i+1) = Sminus(i) - dSminus;
        end
    else
        if(dt == T)
            S = S0*exp((rate-0.5*volatility^2)*T+volatility.*dW);
            Splus = S0*exp((rate-0.5*volatility^2)*T+volatility.*dW);
            Sminus = S0*exp((rate-0.5*volatility^2)*T-volatility.*dW);
        else
            S = zeros(1,Nsteps);
            Splus = zeros(1,Nsteps);
            Sminus = zeros(1,Nsteps);

            S(1) = S0;
            Splus(1) = S0;
            Sminus(1) = S0;
            for i = 1:Nsteps
                dS = rate*S(i)*dt+volatility*S(i)*dW(i);
                dSplus = rate*Splus(i)*dt+volatility*Splus(i)*dW(i);
                dSminus = rate*Sminus(i)*dt+volatility*Sminus(i)*dW(i);
                S(i+1) = S(i) + dS;
                Splus(i+1) = Splus(i) + dSplus;
                Sminus(i+1) = Sminus(i) - dSminus;
            end
        end
    end
end
