function delta = AntitheticDelta(M, rate, volatility, dt, T, Smin, Smax, option_payoff, barrier)
    % INPUTS:   
    % - M:              Number of Monte Carlo simulations
    % - rate:           Interest rates
    % - volatility:     Volatility
    % - dt:             Size of time steps (in years)
    % - T:              Time to maturity (in years)
    % - Smin:           Minimum stock price 
    % - Smax:           Maximum stock price
    % - option_payoff:  Option payoff of the bull call spread
    %                   (function_handle)
    %
    % ABOUT:
    % - Calculates the delta of the bull call spread with the antithetic 
    %   variance reduction method with path recycling 

    % The time step will be one working day (260 working days/year)
    Nsteps = 260*T;
    
    % Initialise the matrices
    dS = 1;
    dW = sqrt(dt)*randn(M,Nsteps);
    SPR = zeros(M,Nsteps+1);
    SPL = zeros(M,Nsteps+1);
    SMR = zeros(M,Nsteps+1);
    SML = zeros(M,Nsteps+1);
    delta = zeros(1,Smax);
    
    % Simulate for all stock prices
    for i = Smin:Smax
        SPR(:,1) = i+dS;
        SPL(:,1) = i-dS;
        SMR(:,1) = i+dS;
        SML(:,1) = i-dS;
        % Local volatility and time dependent interest rates
        if(isa(rate,'function_handle'))
           for j = 1:Nsteps
               % Simulates the plus/minus left/right paths
               SPR(:,j+1) = SPR(:,j).*(1 + rate(j.*dt)*dt+volatility(SPR(:,j),j.*dt).*dW(:,j));
               SPL(:,j+1) = SPL(:,j).*(1 + rate(j.*dt)*dt+volatility(SPL(:,j),j.*dt).*dW(:,j));
               SMR(:,j+1) = SMR(:,j).*(1 + rate(j.*dt)*dt-volatility(SMR(:,j),j.*dt).*dW(:,j));
               SML(:,j+1) = SML(:,j).*(1 + rate(j.*dt)*dt-volatility(SML(:,j),j.*dt).*dW(:,j));
            end
        else
        % Constant volatility and interest rates
            for j = 1:Nsteps
               % Simulates the plus/minus left/right paths
               SPR(:,j+1) = SPR(:,j).*(1 + rate(j.*dt)*dt+volatility(SPR(:,j),j.*dt).*dW(:,j));
               SPL(:,j+1) = SPL(:,j).*(1 + rate(j.*dt)*dt+volatility(SPL(:,j),j.*dt).*dW(:,j));
               SMR(:,j+1) = SMR(:,j).*(1 + rate(j.*dt)*dt-volatility(SMR(:,j),j.*dt).*dW(:,j));
               SML(:,j+1) = SML(:,j).*(1 + rate(j.*dt)*dt-volatility(SML(:,j),j.*dt).*dW(:,j));
            end
        end
        
        % Calculates the payoff
        if(nargin(option_payoff) == 1)
            fSPR = option_payoff(SPR);
            fSPL = option_payoff(SPL);
            fSMR = option_payoff(SMR);
            fSML = option_payoff(SML);
        else
            fSPR = option_payoff(SPR, barrier);
            fSPL = option_payoff(SPL, barrier);
            fSMR = option_payoff(SMR, barrier);
            fSML = option_payoff(SML, barrier);
        end

        % Calculate the option and then the delta
        fSR = (fSPR + fSMR)/2;
        fSL = (fSPL + fSML)/2;
        VR  = mean(fSR);
        VL  = mean(fSL);

        delta(i) = (VR - VL)/2;
    end
end