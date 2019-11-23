function plot_comparison(S, V_BS, V_PDE)
    plot(S,V_PDE,'b-')
    hold on
    plot(S,V_BS,'r*')
    grid on
    xlabel('Stock price (£)','FontSize',12)
    ylabel('Option price (£)','FontSize',12)
    legend('Numerical solution','Black-Scholes solution','FontSize',12)
end