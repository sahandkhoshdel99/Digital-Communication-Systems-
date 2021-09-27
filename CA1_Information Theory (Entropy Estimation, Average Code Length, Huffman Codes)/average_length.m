function avglen_huffman = average_length(chain , k)
 % Step1: Grouping chain into k-bit groups
 r = mod(length(chain),k);
 len = length(chain) - r; % separating the extra bits
 main_chain = zeros(1, len);
 

    for i = 1:(len)
         main_chain(1,i) = chain(1,i);
    end
    
    
reshaped_chain = reshape(main_chain, [k length(main_chain)/k]); % splitting to k-bit groups
chain_symbol = zeros(1,( length(main_chain)/k ));
% each group is a column with k elements(bits)
sum = 0;

% Step 2: Assigning symbols to k-bit sequences
for i = 1 :length(main_chain)/k % iterate over columns(k-bit groups)
    ktemp = k;
    split_chain = reshaped_chain(:,i);
    
    while ktemp > 0 
        for j = 1 : k  % giving values to each bit in k-bit sequences
            sum = sum + split_chain(j,1)*10^(ktemp - 1); % assigning sum of values as chain value(symbol) 
            ktemp = ktemp -1 ;
        end
    end
    
  chain_symbol(1,i) = sum ; %saving chain symbol(sum value) for each mini-chain(k-bit group)
   sum = 0;
end

% Step3: Calculating symbol occurance probability (frequency based)
symbols = unique(chain_symbol);% We need a unique list of symbols used in our chain to calculate probability 
count = histc(chain_symbol, symbols); %occurance frequency

symbols_probability = zeros(1, length(symbols));

for i = 1 : length(symbols)
    symbols_probability(1,i) = (count(1, i) /( length(chain_symbol)) ) ;
    
end

[~,avglen_huffman] = huffmandict(symbols,symbols_probability) ; %using huffmandict to find average length

% display(avglen)
end