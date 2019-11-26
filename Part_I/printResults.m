function printResults(times, prices, variances, errors, sample_sizes)
    time = mean(times);
    price = mean(prices);
    error = mean(errors);
    size = ceil(size);
    
    disp("---------------------------------------------------------------------------------------------------")
    fprintf("\t\t\t\t\tNaive method\tAntithetic variance\t\tControl Variate \tImportance sampling\n")
    disp("---------------------------------------------------------------------------------------------------")
    fprintf("True price:\t\t\t%.4f\t\t\t%.4f\t\t\t\t\t%.4f\t\t\t\t%.4f\n", true_price, true_price, true_price, true_price)
    fprintf("Calculated price:\t%.4f\t\t\t%.4f\t\t\t\t\t%.4f\t\t\t\t%.4f\n", price(1), price(2), price(3), price(4))
    fprintf("Variance:\t\t\t%.4f\t\t%.4f\t\t\t\t%.4f\t\t\t%.4f\n", variance(1), variance(2), variance(3), variance(4))
    fprintf("Error in pricing:\t%.4f\t\t\t%.4f\t\t\t\t\t%.4f\t\t\t\t%.4f\n", error(1), error(2), error(3), error(4))
    fprintf("Sample size needed:\t%d\t\t\t%d\t\t\t\t\t%d\t\t\t\t%d\n", size(1), size(2), size(3), size(4))
    fprintf("CPU time elapsed:\t%.4f\t\t\t%.4f\t\t\t\t\t%.4f\t\t\t\t%.4f\n", time(1), time(2), time(3), time(4))

    
    % Table for LaTeX
    disp('\begin{tabular}{|c|c|c|c|c|}')
    disp('\hline')
    disp('& Naive method & Antithetic variance & Control Variate & Importance sampling\\')
    disp('\hline')
    fprintf("True price: & pounds %.4f & pounds %.4f & pounds %.4f & pounds %.4f \\\\ \n",true_price, true_price, true_price, true_price)
    fprintf("Calculated price: & pounds %.4f & pounds %.4f & pounds %.4f & pounds %.4f \\\\ \n",price(1), price(2), price(3), price(4))
    fprintf("Variance: & %.4f & %.4f & %.4f & %.4f \\\\ \n",variance(1), variance(2), variance(3), variance(4))
    fprintf("Pricing error: & pounds %.4f & pounds %.4f & pounds %.4f & pounds%.4f \\\\ \n",error(1), error(2), error(3), error(4))
    fprintf("Sample size needed: & %d & %d & %d & %d \\\\ \n",size(1), size(2), size(3), size(4))
    fprintf("CPU time elapsed: & %.4f & %.4f & %.4f & %.4f \\\\ \n",time(1), time(2), time(3), time(4))
    disp('\hline')
    disp('\end{tabular}')

end