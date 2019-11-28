%% Initialising the parameters
set_parameters;

%% Pricing a put option using stochastic interest rates and a local volatility model
price = zeros(Smax, 9);
variance = zeros(Smax, 9);
error = zeros(Smax, 9);
sample_size = zeros(Smax, 9);
time = zeros(1, 9);

% Naive method
[price(:,1), variance(:,1), error(:,1), sample_size(:,1), time(1)] = run_NaiveMethod(Smin, Smax, dt, T, put_payoff, rate, volatility)

% Antithetic variance reduction
[price(:,2), variance(:,2), error(:,2), sample_size(:,2), time(2)] = run_AntitheticVarianceReduction(Smin, Smax, dt, T, put_payoff, rate, volatility)

% Control variates
[price(:,3), variance(:,3), error(:,3), sample_size(:,3), time(3)] = run_AntitheticVarianceReduction(Smin, Smax, dt, T, put_payoff, rate, volatility)

%% Pricing a put option using constant interest rates and a local volatility model
Sb = 30;

% Naive method
start = cputime;
for i = Smin:Smax
    S = zeros(N,N);
    for j = 1:N
        S(j,:) = geometric_brownian_motion(i, r(1), sigma(1), dt, T);
    end
    price(i,4) = mean(put_payoff(S(:,end)));
    variance(i,4) = var(put_payoff(S(:,end)));
    error(i,4) = put_payoff(i) - price(i,4);   
    sample_size(i,4) = confidence_sample(variance(i,4));
end
time(4) = (cputime - start)/Smax;

% Antithetic variance reduction
start = cputime;
for i = Smin:Smax
    S = zeros(N,N);
    Splus = zeros(N,N);
    Sminus = zeros(N,N);
    for j = 1:N
        [S(j,:), Splus(j,:), Sminus(j,:)] = geometric_brownian_motion(i, r(1), sigma(1), dt, T);
    end 
    Z = (put_payoff(Splus(:,end)) + put_payoff(Sminus(:,end)))/2;
    price(i,5) = mean(Z);
    variance(i,5) = var(Z);
    error(i,5) = put_payoff(i) - price(i,5);   
    sample_size(i,5) = confidence_sample(variance(i,5));
end
time(5) = (cputime - start)/Smax;

% Control variates
start = cputime;
g = @(S) S;
for i = Smin:Smax
    gm = i;
    for j = 1:N
        gm = gm*exp(dt*(rate(j*dt)));   % Forward value
    end
    S = zeros(N,N);
    %gv = S0.^2.*exp(2*rate(0)*T).*(exp(volatility(S0,0).^2.*T)-1);
    for j = 1:N
        S(j,:) = geometric_brownian_motion(i, r(1), sigma(1), dt, T);
    end
    covariance_matrix = cov(put_payoff(S(:,end)),S(:,end));
    c = covariance_matrix(1,2)/var(S(:,end));
    fcv = var(put_payoff(S(:,end)))*(1-(covariance_matrix(1,2))^2/(var(put_payoff(S(:,end)))*var(g(S(:,end)))));
    fc = put_payoff(S(:,end))-c.*(g(S(:,end))-gm);
    price(i,6) = mean(fc);
    variance(i,6) = var(Z);
    error(i,6) = put_payoff(i) - price(i,6);   
    sample_size(i,6) = confidence_sample(variance(i,6));
end
time(6) = (cputime - start)/Smax;

%% PRICING DOWN AND OUT PUT OPTION
% THIS IS WRONG... PLS FIX
%% Pricing a put option using constant interest rates and a local volatility model
% Naive method
Sb = 30;
start = cputime;
for i = 50:50
    S = zeros(N,N);
	barrier = ones(N,1);
    for j = 1:N
        S(j,:) = geometric_brownian_motion(i, r(1), sigma(1), dt, T);
        barrier(j) = min(S(j,:)) > Sb;
    end
    price(i,7) = mean(put_payoff(S(:,end)));
    variance(i,7) = var(put_payoff(S(:,end)));
    error(i,7) = put_payoff(i) - price(i,7);   
    sample_size(i,7) = confidence_sample(variance(i,7));
end
time(7) = (cputime - start)/Smax;
%%
% Antithetic variance reduction
start = cputime;
for i = Smin:Smax
    S = zeros(N,N);
    Splus = zeros(N,N);
    Sminus = zeros(N,N);
	barrier_plus = ones(N,1);
	barrier_minus = ones(N,1);
    for j = 1:N
        [S(j,:), Splus(j,:), Sminus(j,:)] = geometric_brownian_motion(i, r(1), sigma(1), dt, T);
        barrier_plus(j) = min(Splus(j,:)) > Sb; 
        barrier_minus(j) = min(Sminus(j,:)) > Sb; 
    end 
    Z = (put_payoff(Splus(:,end).*barrier_plus) + put_payoff(Sminus(:,end).*barrier_minus))/2;
    price(i,8) = mean(Z);
    variance(i,8) = var(Z);
    error(i,8) = put_payoff(i) - price(i,5);   
    sample_size(i,8) = confidence_sample(variance(i,5));
end
time(8) = (cputime - start)/Smax;

% Control variates
start = cputime;
g = @(S) S;
for i = Smin:Smax
    gm = i;
    for j = 1:N
        gm = gm*exp(dt*(rate(j*dt)));   % Forward value
    end
    S = zeros(N,N);
	barrier = ones(N,1);
    %gv = S0.^2.*exp(2*rate(0)*T).*(exp(volatility(S0,0).^2.*T)-1);
    for j = 1:N
        S(j,:) = geometric_brownian_motion(i, r(1), sigma(1), dt, T);
        barrier(j) = min(S(j,:)) > Sb;
    end
    covariance_matrix = cov(put_payoff(S(:,end)),S(:,end));
    c = covariance_matrix(1,2)/var(S(:,end));
    fcv = var(put_payoff(S(:,end)))*(1-(covariance_matrix(1,2))^2/(var(put_payoff(S(:,end)))*var(g(S(:,end)))));
    fc = put_payoff(S(:,end)-c.*(g(S(:,end))-gm)).*barrier;
    price(i,9) = mean(fc.*barrier);
    variance(i,9) = var(Z);
    error(i,9) = put_payoff(i) - price(i,9);   
    sample_size(i,9) = confidence_sample(variance(i,9));
end
time(9) = (cputime - start)/Smax;

%% COMPARISON (STOCHASTIC)
% MAKE INTO FUNCTION!!!
figure
plot(price(:,1),'o')
hold on
plot(price(:,2),'o')
plot(price(:,3),'o')
plot(1:100, put(1:100),'k--','LineWidth',2)
grid on
title('Price of put option')
xlabel('Stock price (£)')
ylabel('Option price (£)')
xlim([Smin Smax])

%% COMPARISON (NONSTOCHASTIC)
figure
plot(price(:,4),'o')
hold on
plot(price(:,5),'o')
plot(price(:,6),'o')
plot(1:100, put(1:100),'k--','LineWidth',2)
grid on
title('Price of put option')
xlabel('Stock price (£)')
ylabel('Option price (£)')
xlim([Smin Smax])

%% DOWN AND OUT PUT
figure
plot(price(:,7),'o')
hold on
plot(price(:,8),'o')
plot(price(:,9),'o')
plot(1:100, put(1:100),'k--','LineWidth',2)
grid on
title('Price of put option')
xlabel('Stock price (£)')
ylabel('Option price (£)')
xlim([Smin Smax])


%% PRINTING THE RESULT
printResults(time(1:3), variance(:,1:3), error(:,1:3), sample_size(:,1:3))

%% PLOTTING THE DIFFERENCE
for i = 1:3
    subplot(3,1,i)
    plotDifference(Smin, Smax, price(:,i), put_payoff)
end    