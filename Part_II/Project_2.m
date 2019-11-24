%% PART 2
set_parameters;


price = zeros(1,100);
for i = 1:100
    price(i) = price_put(i, K, r, volatility, N);
end
S = 1:100;
[call, put] = blsprice(S, K, rate(0), T, volatility(S,0));

plot(S, price)
hold on
plot(S, put)
grid on
xlim([1 100])