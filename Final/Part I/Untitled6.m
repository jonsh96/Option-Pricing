% Working barrier put
dW = sqrt(1/250)*randn(200,200);
Sb = 30;
K = 50;
bp = @(S) max(K-S(end),0)*(min(S,[],2) > Sb);

for i = 1:200
    S(i,1) = i;
    for j = 2:200
        S(i,j) = S(i,j-1) + r*S(i,j-1)*dt + sigma*dW(i,j-1);
    end
    B(i) = bp(S(i,:));
end
plot(B)