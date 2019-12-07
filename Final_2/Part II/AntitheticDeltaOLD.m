% %% TODO FIX FOR PART II
% function delta = AntitheticDelta(M, rate, volatility, dt, T, Smin, Smax, option_payoff)
%     % INPUTS:   
%     % - M:              Number of Monte Carlo simulations
%     % - rate:           Interest rates
%     % - volatility:     Volatility
%     % - dt:             Size of time steps (in years)
%     % - T:              Time to maturity (in years)
%     % - Smin:           Minimum stock price 
%     % - Smax:           Maximum stock price
%     % - option_payoff:  Option payoff of the bull call spread
%     %                   (function_handle)
%     %
%     % ABOUT:
%     % - Calculates the delta of the bull call spread with the antithetic 
%     %   variance reduction method with path recycling 
%     
%     ds = 1;
%     dW = sqrt(dt)*randn(M,Smax); % Explain in report - used for path recycling
%     delta = zeros(1,Smax);
%     for S = Smin:Smax
%         % Shorthand: P = plus, M = minus, R = right, L = left
%         SPL = (S-ds)*exp((rate-0.5*volatility^2)*T+volatility*dW(:,S));
%         SPR = (S+ds)*exp((rate-0.5*volatility^2)*T+volatility*dW(:,S));
%         SML = (S-ds)*exp((rate-0.5*volatility^2)*T-volatility*dW(:,S));
%         SMR = (S+ds)*exp((rate-0.5*volatility^2)*T-volatility*dW(:,S));
%         FPL = option_payoff(SPL);
%         FPR = option_payoff(SPR);
%         FML = option_payoff(SML);
%         FMR = option_payoff(SMR);
%         FR = (FPR + FMR)/2;
%         FL = (FPL + FML)/2;
%         delta(S) = (mean(FR) - mean(FL))/2;
%     end
% end