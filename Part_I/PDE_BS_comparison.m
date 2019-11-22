[V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);
V_BS = @(S) blsprice(S, K1, r, T, sigma)-blsprice(S, K2, r, T, sigma);
plot(S,V_PDE,'b')
hold on
plot(S,V_BS(S),'r*')
grid on
xlabel('Stock price (£)','FontSize',14)
ylabel('Option price (£)','FontSize',14)
legend('Numerical solution','Black-Scholes solution','FontSize',14)