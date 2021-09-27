

%% Calculating State's Probability
transition_states = [0.5 0.5 ; 0.8 0.2];

ts_length = length(transition_states);

ts_transposed = transpose(transition_states);
ts_transposed = ts_transposed - eye(ts_length);
ts = [ts_transposed ; ones(1 , ts_length)];
U = [zeros(ts_length, 1) ;ones(1,1)] ;
P = linsolve(ts , U);

%% Calculating Entropy

h11 = -1 * ( ( 0.5 * log2(0.5) ) + ( 0.5 * log2(0.5) ) ); %state 1 entropy
h22 = -1 * ( ( 0.2 * log2(0.2) ) + ( 0.8 * log2(0.8) ) ); %state 2 entropy

Hs1 = ( P(1,1) * h11 ) + ( P(2,1) * h22) ; %total entropy

%% Calculatin G

K = 1 : 10 ;

G = zeros(1,length(K));

for k = 1 : length(K)
    
    [H21 , G_k] = entropy(transition_states,k);
    G(1,k)=G_k;
   
end

%% Producing Symbols

NUM_OF_SYMBOLS = 10e7;
main_chain = zeros(1,NUM_OF_SYMBOLS);


x = rand;

if ( x < P(1,1) ) % setting the source current state with state ptrobabilities
    main_chain(1,1) = 1;
else
    main_chain(1,1) = 2 ;
end
  
for i = 1 : NUM_OF_SYMBOLS
    temp  = rand;
    if ( main_chain(1,i) == 1 )
        if( temp < transition_states(1,1))
            main_chain(1,i+1) = 1 ;
        else
            main_chain(1,i+1) = 2 ;
        end
    elseif ( main_chain(1,i) == 2)
        if( temp < transition_states(2,2) ) 
            main_chain(1,i+1) = 2 ;
        else
            main_chain(1,i+1) = 1 ;
        end 
    end
        
    
end

%% Calculating Average Length

AvgLen = zeros(1,length(K));
HN = zeros(1, length(K));

 for m = 1:length(K)
    AvgLen(1,m) = average_length(main_chain, m)
    HN(1,m) = AvgLen(1,m)/m
end

%% Calculating code efficiency and plot diagrams

H = zeros(1,length(K)); 
for i = 1:length(H)
    H(1,i) = H21;
end

CE = zeros(1,length(K));
Hhat_k = zeros(1, length(K));

for i = 1:length(CE)
    CE(1,i) = H(1,i) / HN(1,i) ;
end

for i = 1:length(Hhat_k)
    Hhat_k(1,i) = AvgLen(1,i) / K(1,i) ;
end

figure(1);
plot(K,G, 'b');
hold on ;
plot(K,AvgLen,' black');
hold on ;
plot(K,Hhat_k,'r');
title('Average Code Length and G - k ');
legend('Gk','Average Length','H-hat_k')
grid on;


figure(2)
plot(K,CE , 'black');
hold on ;
plot(K,H , 'b');
hold on ;
plot(K, Hhat_k, 'r');
title('Code Efficiency and Entropy ');
legend('Coding Efficiency','Entropy','H-hat_k')
grid on;



  


%%
