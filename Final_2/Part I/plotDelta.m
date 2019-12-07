function plotDelta(Smin, Smax, S_PDE, delta, option_delta)
    plot(S_PDE(2:end), delta,'r-d','LineWidth',2)
    hold on
    plot(Smin:Smax, option_delta(Smin:Smax),'k','LineWidth',1)
%     plot(S_PDE(1:end-1),calculateDelta(S_PDE,V_PDE))
    grid on
    xlabel('Stock price (£)','FontSize',14)
    ylabel('Delta value (\Delta)','FontSize',14)
    legend('Numerical solution','Black Scholes solution','FontSize',14)
end