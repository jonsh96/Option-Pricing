error = zeros(200);

for N = 1:200
    for J = 1:200
        [V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);
        V_BS = blsprice(S, K1, r, T, sigma)-blsprice(S, K2, r, T, sigma);
        error(N,J) = norm(V_BS-V_PDE,Inf);
    end
end
mesh(1:200, 1:200, error)
xlabel('Number of time steps','FontSize',14)
ylabel('Number of grid points','FontSize',14)
zlabel('Absolute maximum error','FontSize',14)
