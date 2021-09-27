function[ Hs2s1, G_k] = entropy(transition_states,k)

% Step1: find inital prob vector p:
ts_len = length(transition_states); 
ts_tp = transpose(transition_states);

ts_tp = ts_tp - eye(ts_len);

% adding axiom #3 to system of equations:
ts = [ts_tp ; ones(1 , ts_len)];
U = [zeros(ts_len, 1) ;ones(1,1)] ;
P = linsolve(ts , U);% solving system of equations 

Hs1 = 0 ; % Step 2: caculating state entropy
for i = 1:ts_len
    Hs1 = Hs1 + ( -1 * ( P(i) * log2(P(i)) ) ); 
end

Hs2s1 = 0; % Step 3: calculating transition entropy 
temp= 0;

for i = 1:ts_len
    temp= 0;
    for j = 1:ts_len
        temp= temp+ ( -1 * ( transition_states(i,j) * log2(transition_states(i,j)) ) );
    end
    Hs2s1 = Hs2s1 + (temp* P(i,1) );
end
G_k = (1/k) * ( Hs1 + (k) * Hs2s1 ) ; % Step 4: calculating G_k with chain rule and markovity fact

end

