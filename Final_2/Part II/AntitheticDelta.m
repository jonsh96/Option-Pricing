function delta = AntitheticDelta(M, rate, volatility, dt, T, Smax, option_payoff, barrier)
    % Antithetic variance reduction WITH PATH RECYCLING

    dS = 1;
    dW = sqrt(dt)*randn(M,Smax); % Explain in report - used for path recycling
    delta = zeros(1,Smax);
    for i = 1:Smax
        
        
        for j = 1:M
            dS = rate*S(i,j)*dt+volatility*S(i,j)*dW(i,j);
            dSplus = rate(i*dt)*Splus(i,j)*dt+volatility*Splus(i,j)*dW(i,j);
            dSminus = rate(i*dt)*Sminus(i,j)*dt+volatility(Sminus(i,j),i*dt)*Sminus(i,j)*dW(i,j);
            
            S(i+1,j) = S(i,j) + dS;
            Splus(i+1,j) = Splus(i,j) + dSplus;
            Sminus(i+1,j) = S(i,j) + dSminus;
        end 
        
        if nargin(option_payoff) == 1
            FPL = option_payoff(SPL);
            FPR = option_payoff(SPR);
            FML = option_payoff(SML);
            FMR = option_payoff(SMR);
 
        else
            FPL = option_payoff(SPL,barrier);
            FPR = option_payoff(SPR,barrier);
            FML = option_payoff(SML,barrier);
            FMR = option_payoff(SMR,barrier);
        end
        FR = (FPR + FMR)/2;
        FL = (FPL + FML)/2;
        delta(S) = (mean(FR) - mean(FL))/2;
    end
end