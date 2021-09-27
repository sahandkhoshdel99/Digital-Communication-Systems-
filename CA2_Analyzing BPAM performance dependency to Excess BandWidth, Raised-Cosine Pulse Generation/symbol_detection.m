function [detected_symbols] = symbol_detection(samples ,N)
detected_symbols = zeros(11,N);

pos = samples >= 0;
neg = samples < 0;
detected_symbols(pos) = 1;
detected_symbols(neg) = -1;
end