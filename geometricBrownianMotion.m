function stock_path = geometricBrownianMotion(S0, r, sigma, dt, T)
    
    N = T/dt;
    stock_path = zeros(N,1);
    stock_path(1) = S0;
    dW = sqrt(dt)*randn(N,1);
    for i = 2:N
        dS(i-1) = r*stock_path(i-1)*dt+sigma*stock_path(i-1)*dW(i-1);
        stock_path(i) = stock_path(i-1) + dS(i-1);
    end
end