function [time error] = time_error_measurements(K1, K2, T, r, sigma, Smin, Smax, N, J)
% Error and cpu time measurements
time = zeros(1,J-round(N/10));
error = zeros(1,J-round(N/10));

for i = round(N/10):J
    start = cputime;
    [V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);
    time(i-round(N/10)+1) = cputime - start;
    
    V_BS = blsprice(S, K1, r, T, sigma)-blsprice(S, K2, r, T, sigma);
    error(i-round(N/10)+1) = norm(V_BS-V_PDE,Inf);
end