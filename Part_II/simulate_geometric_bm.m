function [S, price] = simulate_geometric_bm(S0, K, rate, volatility, N)
    set_parameters;
    
    S = zeros(N,N);
    S(:,1) = S0;
    dS = zeros(N,N);
    dW = sqrt(dt)*rand(N,N);

    dST = rate(0)*S0.*T + volatility(S0,0).*S0.*dW(i);
    ST = S0 + dST; 
    
    if(isa(rate,'function_handle') && isa(volatility,'function_handle'))
        for i = 1:N
            for j = 2:N
                % Defining the underlying process of the stock price
                t = (j-1)*dt;
                dS(i,j-1) = rate(t)*S(i,j-1)*dt + volatility(S(i,j-1),t)*S(i,j-1)*dW(i,j-1);
                S(i,j) = S(i,j-1) + dS(i,j-1);
            end
            plot(S(i,:))
            hold on
        end
    else
        for i = 1:N
            for j = 2:N
                % Defining the underlying process of the stock price
                t = (j-1)*dt;
                dS(i,j-1) = rate*S(i,j-1)*dt + volatility*S(i,j-1)*dW(i,j-1);
                S(i,j) = S(i,j-1) + dS(i,j-1);
            end
            plot(S(i,:))
            hold on
        end
    end
    price = mean(mean(payoff(S)));
end

