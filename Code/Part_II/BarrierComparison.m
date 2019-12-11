function BarrierComparison(Smin, Smax, rate, volatility, dt, T, M, barrier_payoff)
    % INPUTS:   
    %  - Smin:          Minimum stock price
    %  - Smax:          Maximum stock price
    %  - rate:          Interest rate (constant or function_handle)
    %  - volatility:    Volatility (constant or function_handle)
    %  - dt:            Time step
    %  - T:             Time to maturity
    %  - M:             Number of Monte Carlo Simulations
    %
    % ABOUT:
    %  - Plots the price of the down-and-out barrier with Sb ranging from 0 and 5:8:45
    
    for Sb = 5:8:45
        [times_barrier, prices_barrier, variances_barrier, sample_sizes_barrier] = AntitheticVarianceReduction(Smin, Smax, rate, volatility, dt, T, M, barrier_payoff, Sb);
        PlotBarriers(Smin, Smax, prices_barrier, Sb);
        hold on
    end
    [times_barrier, prices_barrier, variances_barrier, sample_sizes_barrier] = AntitheticVarianceReduction(Smin, Smax, rate, volatility, dt, T, M, barrier_payoff, 0);
    PlotBarriers(Smin, Smax, prices_barrier, 0);
    legend("Barrier £5","Barrier £13","Barrier £21","Barrier £29","Barrier £37","Barrier £45","Barrier £0",'FontSize',14)
end