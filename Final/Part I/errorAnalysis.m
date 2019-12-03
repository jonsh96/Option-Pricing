function errorAnalysis(K1, K2, T, r, sigma, Smin, Smax, N, J, BS_bullspread)

    for i = Smin+1:Smax
        [V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, i, N, J);
        V_BS = BS_bullspread(S); 
        error(i-1) = norm(V_PDE-V_BS,Inf);
    end
    figure
    plot(2:200,error)
    grid on
    xlim([2 200])
    xlabel('Maximum stock price (£)','FontSize',14)
    ylabel('Maximum error in option stock price (£)','FontSize',14)

end