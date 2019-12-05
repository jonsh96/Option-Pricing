function printResults(times, variances, sample_sizes)
    time = times';
    variance = max(variances');
%     error = max(errors');
    sizes = ceil(max(sample_sizes'));
    
    disp("-----------------------------------------------------------------------------------")
    fprintf("\t\t\t\t\t\t\tNaive method\tAntithetic variance\t\tControl Variate\n")
    disp("-----------------------------------------------------------------------------------")
    fprintf("Maximum variance:\t\t\t%.4f \t\t%.4f\t\t\t\t\t%.4f\n", variance(1), variance(2), variance(3))
    fprintf("Maximum sample size needed:\t%d\t\t\t%d\t\t\t\t\t%d\n", sizes(1), sizes(2), sizes(3))
    fprintf("Average CPU time elapsed:\t%.4f\t\t\t%.4f\t\t\t\t\t%.4f\n\n", time(1), time(2), time(3))

    
%     Table for LaTeX
%     disp('\begin{tabular}{|c|c|c|c|c|}')
%     disp('\hline')
%     disp('& Naive method & Antithetic variance & Control Variate & Importance sampling\\')
%     disp('\hline')
%     fprintf("Variance: & %.4f & %.4f & %.4f & %.4f \\\\ \n",variance(1), variance(2), variance(3), variance(4))
%     fprintf("Pricing error: & pounds %.4f & pounds %.4f & pounds %.4f & pounds%.4f \\\\ \n",error(1), error(2), error(3), error(4))
%     fprintf("Sample size needed: & %d & %d & %d & %d \\\\ \n",sizes(1), sizes(2), sizes(3), sizes(4))
%     fprintf("CPU time elapsed: & %.4f & %.4f & %.4f & %.4f \\\\ \n",time(1), time(2), time(3), time(4))
%     disp('\hline')
%     disp('\end{tabular}')

end