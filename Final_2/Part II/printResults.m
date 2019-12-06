function PrintResults(times, variances, sample_sizes)
    % TODO: COMMENT
    time = times';
    variance = max(variances');
    sizes = ceil(max(sample_sizes'));
    
    disp("-----------------------------------------------------------------------------------")
    fprintf("\t\t\t\t\t\t\tNaive method\tAntithetic variance\t\tControl Variate\n")
    disp("-----------------------------------------------------------------------------------")
    fprintf("Maximum variance:\t\t\t%.4f \t\t%.4f\t\t\t\t\t%.4f\n", variance(1), variance(2), variance(3))
    fprintf("Maximum sample size needed:\t%d\t\t\t%d\t\t\t\t\t%d\n", sizes(1), sizes(2), sizes(3))
    fprintf("Average CPU time elapsed:\t%.4f\t\t\t%.4f\t\t\t\t\t%.4f\n\n", time(1), time(2), time(3))

end