function delta = FiniteDifferenceDelta(S_PDE, V_PDE)
    % INPUTS:
    %   - S_PDE:    Stock prices (solution of PDE_bullspread)
    %   - V_PDE:    Option prices (solution of PDE_bullspread)
    %
    % ABOUT:
    %   - Calculates the forward finite difference delta for the bull call
    %     spread
    
    delta = zeros(1,size(S_PDE,2)-1);
    for i = 1:size(S_PDE,2)-1
        delta(i) = (V_PDE(i+1) - V_PDE(i))/(S_PDE(i+1) - S_PDE(i));
    end
end