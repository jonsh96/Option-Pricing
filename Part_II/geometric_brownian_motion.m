function [S, Splus, Sminus] = geometric_brownian_motion(S0, r, sigma, N, T)

    dt = T/N;
    S = zeros(1,N);
    Splus = zeros(1,N);
    Sminus = zeros(1,N);
    
    S(1) = S0;
    Splus(1) = S0;
    Sminus(1) = S0;
    
    dS = zeros(1,N);
    dW = sqrt(dt)*randn(1,N);
    
    if(isa(r,'function_handle') && isa(sigma,'function_handle'))
        for i = 2:N
            dS(i-1) = r((i-1)*dt)*S(i-1)*dt+sigma(S(i-1),(i-1)*dt)*S(i-1)*dW(i-1);
            S(i) = S(i-1) + dS(i-1);
            Splus(i) = S(i-1) + dS(i-1);
            Sminus(i) = S(i-1) - dS(i-1);
        end
    else
        for i = 2:N
            dS(i-1) = r*S(i-1)*dt+sigma*S(i-1)*dW(i-1);
            S(i) = S(i-1) + dS(i-1);
            Splus(i) = S(i-1) + dS(i-1);
            Sminus(i) = S(i-1) - dS(i-1);
        end
    end
end

