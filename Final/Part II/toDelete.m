% set_parameters;
% sample_size = @(v) (sqrt(v)*1.96/0.05)^2;
% 
% M = 10000;
% price = zeros(3,100);
% variance = zeros(3,100);
% errors = zeros(3,N);
% time = zeros(3,N);
% 
% % Naive method
% set_parameters;
% 
% S0 = linspace(1,200,N);
% sample_size = @(v) (sqrt(v)*1.96/0.05)^2;
% 
% M = 100;
% time = zeros(M,3);
% price = zeros(M,3);
% variance = zeros(M,3);
% errors = zeros(M,3);
% sample_size_mc = zeros(1,3);
% 
% % Naive method
% Nr = 1000; % Number of simulations per stock price
% for i = 1:100
%     start = cputime;
%     S = geometric_brownian_motion(i, rate, volatility, N, T);
%     price(i,1) = payoff(S);
%     variance(i,1) = mean(var(S));
% %   errors(i,1) = price_BS - price(i,1);
%     time(i,1) = cputime-start;
% end
% sample_size_mc(1) = sample_size(mean(variance(:,1)));
% %%
% % Antithetic variance reduction
% for i = 1:100
%     time(i,2) = cputime;
%     S = zeros(Nr,N);
%     Splus = zeros(Nr,N);
%     Sminus = zeros(Nr,N);
%     for j = 1:Nr
%         [S(j,:), Splus(j,:), Sminus(j,:)] = geometric_brownian_motion(i, rate, volatility, N, T);
%     end
%     
%     Z = (payoff(Splus(end,i))+payoff(Sminus(end,i)))/2;
%     price(i,2) = mean(Z);
%     variance(i,2) = var(Z)
% %    errors(i,2) = price_BS - price(i,2);
%     time(i,2) = (cputime-start)/Nr;
% end
% sample_size_mc(2) = sample_size(mean(variance(:,2)));
% 
% 
% %%
% % Control variates
% % g = @(S) S;
% % % TODO: FIX GM
% % 
% % for i = 1:100
% %    	start = cputime;
% %     gm = i;
% %     for j = 1:N
% %         gm = gm*exp(dt*(rate(j*dt)));
% %     end
% %     S = zeros(Nr,N);
% % 
% %     %gv = S0.^2.*exp(2*rate(0)*T).*(exp(volatility(S0,0).^2.*T)-1);
% %     for j = 1:Nr
% %         S(j,:) = geometric_brownian_motion(i, rate, volatility, N, T);
% %     end
% %     covariance_matrix = cov(payoff(S),S);
% %     c = covariance_matrix(1,2)/var(ST);
% %     fcv = var(payoff(ST))*(1-(covariance_matrix(1,2))^2/(var(payoff(ST))*var(g(ST))));
% %     fc = payoff(ST)-c.*(g(ST)-gm);
% %     price(i,3) = mean(fc);
% %     variance(i,3) = var(fc);
% %     time(i,3) = cputime-start;
% % end
% 
% %% COMPARISON
% V_MC = price(:,1);
% plot(price(:,1),'ro')
% hold on
% plot(price(:,2),'b+')
% 
% plot(1:100, put,'k--')
% grid on
% title('Price of put option')
% xlabel('Stock price (£)')
% ylabel('Option price (£)')
% legend('Naive method','Antithetic variance reduction','Black-Scholes solution')
% %
% sample_size_mc(3) = sample_size(mean(variance(:,3)));
% 
% compare_monte_carlo(mean(price), mean(variance), mean(time), sample_size_mc)
% 
