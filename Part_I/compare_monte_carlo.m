function compare_monte_carlo(true_price, price, variance, time, errors, sample_size_mc)
    sample_size_mc = ceil(sample_size_mc);
    
    disp("---------------------------------------------------------------------------------------------------")
    fprintf("\t\t\t\t\tNaive method\tAntithetic variance\t\tControl Variate \tImportance sampling\n")
    disp("---------------------------------------------------------------------------------------------------")
    fprintf("True price:\t\t\t%.4f\t\t\t%.4f\t\t\t\t\t%.4f\t\t\t\t%.4f\n", true_price, true_price, true_price, true_price)
    fprintf("Calculated price:\t%.4f\t\t\t%.4f\t\t\t\t\t%.4f\t\t\t\t%.4f\n", price(1), price(2), price(3), price(4))
    fprintf("Variance:\t\t\t%.4f\t\t%.4f\t\t\t\t%.4f\t\t\t%.4f\n", variance(1), variance(2), variance(3), variance(4))
    fprintf("Error in pricing:\t%.4f\t\t\t%.4f\t\t\t\t\t%.4f\t\t\t\t%.4f\n", errors(1), errors(2), errors(3), errors(4))
    fprintf("Sample size needed:\t%d\t\t\t%d\t\t\t\t\t%d\t\t\t\t%d\n", sample_size_mc(1), sample_size_mc(2), sample_size_mc(3), sample_size_mc(4))
    fprintf("CPU time elapsed:\t%.4f\t\t\t%.4f\t\t\t\t\t%.4f\t\t\t\t%.4f\n", time(1), time(2), time(3), time(4))
end