function [S, Splus, Sminus] = GeometricBrownianMotion(S0, rate, volatility, dt, T)
    % INPUTS: 
    %  - S0:            Initial stock price
    %  - rate:          Interest rate
    %  - volatility:    Volatility
    %  - dt:            Time step
    %  - T:             Time to maturity
    %
    % OUTPUTS:
    %  - S:             Stock path
    %  - Splus:         (Optional) Stock path with positive random process
    %  - Sminus:        (Optional) Stock path with negative random process
    %
    % ABOUT:
    %  - Simulates the gemoetric Brownian motion in any of the scenarios
    %    needed in part I and part II. (No path recycling)
    
    Nsteps = T/dt;
    dW = sqrt(dt)*randn(1,Nsteps);
    
    % If the interest rates and volatility are function handles, i.e. local
    % volatility and time-dependent interest rates
    if(isa(rate,'function_handle') && isa(volatility,'function_handle'))
        S = zeros(1,Nsteps+1);
        Splus = zeros(1,Nsteps+1);
        Sminus = zeros(1,Nsteps+1);
        S(1) = S0;
        Splus(1) = S0;
        Sminus(1) = S0;
        
        % Simulate the geometric Brownian motion
        for i = 1:Nsteps
            dS = rate((i)*dt)*S(i)*dt+volatility(S(i),(i)*dt)*S(i)*dW(i);
            S(i+1) = S(i) + dS;
            Splus(i+1) = Splus(i) + dS;
            Sminus(i+1) = Sminus(i) - dS;
        end
    else
        % Otherwise assume constant interest rates and volatility
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

            % Simulate the geometric Brownian motion
            for i = 1:Nsteps
                dS = rate*S(i)*dt+volatility*S(i)*dW(i);
                S(i+1) = S(i) + dS;
                Splus(i+1) = Splus(i) + dS;
                Sminus(i+1) = Sminus(i) - dS;
            end
        end
    end
end
