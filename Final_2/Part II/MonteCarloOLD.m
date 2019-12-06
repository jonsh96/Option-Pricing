% function [times, prices, variances, sample_sizes] = MonteCarlo(Smin, Smax, rate, volatility, dt, T, M, option_payoff, barrier)
%     % INPUTS:
%     %   - M:            Number of Monte Carlo simulations
%     %
%     % OUTPUTS:
%     %   - times:        CPU times required to run each of the methods
%     %   - prices:       Option prices as a function of stock price each of the methods 
%     %   - variances:    Variances from each of the methods
%     %   - errors:       
%     %   - sample_sizes: 
%     
%     % Preallocating memory for the matrices
%     prices = zeros(3,Smax);
%     variances = zeros(3,Smax);
%     times = zeros(3,1);
%     sample_sizes = zeros(3, Smax);
% 
%     % Naive method
%     [times(1), prices(1,:), variances(1,:), sample_sizes(1,:)] = NaiveMethod(Smin, Smax, rate, volatility, dt, T, M, option_payoff, option_price);
%     
%     % Antithetic variance reduction
%     [times(2), prices(2,:), variances(2,:), sample_sizes(2,:)] = AntitheticVarianceReduction(Smin, Smax, rate, volatility, dt, T, M, option_payoff, option_price);
% 
%     % Control variates
%     [times(3), prices(3,:), variances(3,:), sample_sizes(3,:)] = ControlVariates(Smin, Smax, rate, volatility, dt, T, M, option_payoff, option_price);
%     
%     
% %     S0 = Smin:Smax;
% %     Nsteps = T/dt;
% %     S = zeros(M, Nsteps+1);
% %     confidence_sample = @(v) (sqrt(v).*1.96/0.05).^2;
% % 
% %     prices = zeros(3,Smax);
% % %     errors = zeros(4,Smax);
% %     variances = zeros(3,Smax);
% %     times = zeros(3,1);
% %     sample_sizes = zeros(3, Smax);
% % 
% %     % Naive method
% %     start = cputime;
% %     for i = 1:Smax
% %         for j = 1:M
% %             S(j,:) = GeometricBrownianMotion(i,rate,volatility,dt,T);
% %         end
% %         if nargin(option_payoff) == 2
% %             prices(1,i) = mean(option_payoff(S(:,end), barrier));
% %             variances(1,i) = var(option_payoff(S(:,end), 0));
% %         else
% %             prices(1,i) = mean(option_payoff(S(:,end)));
% %             variances(1,i) = var(option_payoff(S(:,end)));
% %         end
% %     end
% %     sample_sizes(1,:) = confidence_sample(variances(1,:));
% %     times(1) = (cputime-start)/Smax;
% %     
% %     % Antithetic variance reduction
% %     start = cputime;
% %     for i = 1:Smax
% %         S = zeros(M, Nsteps+1);
% %         Splus = zeros(M, Nsteps+1);
% %         Sminus = zeros(M, Nsteps+1);
% %         for j = 1:M
% %             [S(j,:), Splus(j,:), Sminus(j,:)] = GeometricBrownianMotion(i,rate,volatility,dt,T);
% %         end
% %         if nargin(option_payoff) == 1
% %             Z = (option_payoff(Splus(:,end)) + option_payoff(Sminus(:,end)))/2;
% %             prices(2,i) = mean(Z);
% %             variances(2,i) = var(Z);
% %         else
% %             Z = (option_payoff(Splus(:,end), barrier) + option_payoff(Sminus(:,end), barrier))/2;
% %             prices(2,i) = mean(Z);
% %             variances(2,i) = var(Z);
% %         end 
% %     end
% %     sample_sizes(2,:) = confidence_sample(variances(2,:));
% %     times(2) = (cputime-start)/Smax;
% % 
% %     % Control variates
% %     start = cputime;
% %     g = @(S) S;
% % 
% %     if nargin(option_payoff) == 2
% %         f =@(S, barrier) option_payoff(S, barrier);
% %     else
% %         f =@(S) option_payoff(S);
% %     end
% %     
% %     for i = 1:Smax
% %         if(isa(rate,'function_handle'))
% %             gm = i;
% %             Nsteps = T/dt;
% %             for j = 1:Nsteps
% %                 gm = gm*exp(dt*(rate(j*dt)));   % Forward value
% %             end
% %         else
% %             gm = S0(i)*exp(rate*T);
% %         end
% %          % gv = S0(i)^2*exp(2*r*T)*(exp(sigma^2*T)-1);
% %         S = zeros(M, Nsteps+1);
% %         Splus = zeros(M, Nsteps+1);
% %         Sminus = zeros(M, Nsteps+1);
% %         for j = 1:M
% %             [S(j,:), Splus(j,:), Sminus(j,:)] = GeometricBrownianMotion(i,rate,volatility,dt,T);
% %         end
% %         if nargin(option_payoff) == 2
% %             covariance_matrix = cov(f(S(:,end),barrier),S(:,end));
% %             c = covariance_matrix(1,2)/var(S(:,end));
% %             fc = f(S(:,end),barrier)-c*(g(S(:,end))-gm); 
% %         else
% %             covariance_matrix = cov(f(S(:,end)),S(:,end));
% %             c = covariance_matrix(1,2)/var(S(:,end));
% %             fc = f(S(:,end))-c*(g(S(:,end))-gm); 
% %         end
% %         prices(3,i) = mean(fc);
% %         variances(3,i) = var(fc);
% %     end
% %     sample_sizes(3,:) = confidence_sample(variances(3,:));
% %     times(3) = (cputime-start)/Smax;
% 
% end