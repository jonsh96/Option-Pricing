[V, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);


call_1 = @(S) blsprice(S, K1, r, T, sigma);
call_2 = @(S) blsprice(S, K2, r, T, sigma);
true_price =@(S) call_1(S)-call_2(S);

plot(S,V,'b+')
hold on
range = Smin:0.05:Smax;
plot(range,true_price(range),'k--')
xlabel('Stock price')
ylabel('Option price')