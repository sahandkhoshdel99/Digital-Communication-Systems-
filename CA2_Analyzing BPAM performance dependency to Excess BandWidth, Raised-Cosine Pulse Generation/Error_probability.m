function Pe = Error_probability(repeated_symbols, detected_symbols, N)
num_errors = sum((repeated_symbols ~= detected_symbols),2);
Pe = reshape(num_errors, [1 11])/N;
end
