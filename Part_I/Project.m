% Initialising the variable
K1 = 90;        % Strike price 1
K2 = 120;       % Strike price 2
T = 6/12;       % Maturity
dt = T/250;     % Size of time increments
r = 0.03;       % (Constant) Risk free interest rates
sigma = 0.25;   % (Constant) Volatility of stock

Smin = 1;
Smax = 500;

N = 1000;
J = 200;

Srange = linspace(Smin, Smax, J+1)

[V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);
bullspread = @(S) blsprice(S, K1, r, T, sigma)-blsprice(S, K2, r, T, sigma);
V_BS = bullspread(Srange)

plot(Srange, V_BS(Srange))
hold on
plot(S,V_PDE,'r+')

%% ABOUT SMAX = 500
% option pricing range stability conditions
% -H Windcliff Waterloo

%% 1 
% TODO: something
% - FIX 
% - Transformation on paper http://www.math.unl.edu/~sdunbar1/MathematicalFinance/Lessons/BlackScholes/Solution/solution.pdf

%[V, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);

%interp1(S,V,(K2-K1),'spline')

call_1 = @(S) blsprice(S, K1, r, T, sigma);
call_2 = @(S) blsprice(S, K2, r, T, sigma);
true_price =@(S) call_1(S)-call_2(S);
%%
plot(S,V_PDE)
hold on
range = Smin:0.05:Smax;
plot(range,true_price(range))


%%



%%
% for i = 1:10
%     ST = geometricBrownianMotion(S0, r, sigma, dt, T);
%     plot(ST)
%     hold on
%     grid on
% end