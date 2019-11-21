function J = minimizeAbsError(K1, K2, T, r, sigma, Smin, Smax, N)
% Find J for given N and initial J such that the absolute error < 0.05
error = 100;    %
J = round(N/10);
while(error > 0.05)
    J = J+1;
    [V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);
    V_BS = blsprice(S, K1, r, T, sigma)-blsprice(S, K2, r, T, sigma);
    error = norm(V_BS-V_PDE,Inf);
end
