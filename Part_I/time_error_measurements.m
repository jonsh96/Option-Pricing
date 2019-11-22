function [time error] = time_error_measurements(K1, K2, T, r, sigma, Smin, Smax, N, J)
    K = 1000;
    error = zeros(1,K);
    time = zeros(1,K);
    for i = 1:K
        % Error and cpu time measurements
        start = cputime;
        [V_PDE, S] = PDE_bullspread(K1, K2, T, r, sigma, Smin, Smax, N, J);
        time(i) = cputime - start;

        V_BS = blsprice(S, K1, r, T, sigma)-blsprice(S, K2, r, T, sigma);
        error(i) = norm(V_BS-V_PDE,Inf);
    end
    min(error)
    min(time)
    error = mean(error);
    time = mean(time); 
end