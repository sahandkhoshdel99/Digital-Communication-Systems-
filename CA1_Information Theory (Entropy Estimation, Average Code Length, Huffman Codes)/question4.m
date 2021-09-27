
X1 = [11 , 21 , 22 ];
P_X1 = [ 0.7 , 0.29 , 0.01 ] ;

X2 = [1111 , 1121 ,1122 , 2111 , 2121 , 2122, 2211 , 2221 , 2222 ];
P_X2 = reshape((transpose(P_X1)*(P_X1)), 1, [])

X3 = [111111 , 111121 , 111122 ,112111, 112121, 112122 ,112211,112221,112222,...
    211111 , 211121 , 211122 ,212111 , 212121 , 212122, 212211 , 212221 , 212222,...
    221111 , 221121 ,221122 , 222111 , 222121 , 222122, 222211 , 222221 , 222222];

P_X3 = []
for i = 1:3:(3^2)
    P_X3 = [P_X3 reshape((transpose(P_X2(i:i+2))*(P_X1)), 1, [])]
end




H1 = 0;

for i = 1:length(P_X1)
        H1 = H1 + ( -1 * ( P_X1(i) * log2(P_X1(i) ) ));
end
H2 = 2*H1
H3 = 3*H1

[~,avglen1] = huffmandict(X1,P_X1); 
[~,avglen2] = huffmandict(X2,P_X2); 
[~,avglen3] = huffmandict(X3,P_X3); 
a = 1:10
AvgLen1 = a*avglen1
AvgLen2 = a*avglen2
AvgLen3 = a*avglen3

AvgLen  = [ AvgLen1;AvgLen2;AvgLen3]

%% Ploting

K = 1 : 10 ;
G = zeros(3,10);
HN2 = zeros(3,10);
CE = zeros(3,10);
H = [H1 H2 H3 ];
for j = 1:3
    for  k = 1:10
      G(j,k) = ((k+1)/k)* H(1, j);
      HN2(j,k) = AvgLen(j,k)/k;
      CE(j,k) = H(j)/(HN2(j,k));
    end
end




figure(3);
plot(K,G(1,:) , 'b' );
hold on ;
plot(K,AvgLen1 , 'black');
title('G and Average Length for source X');
legend('Gk','Average Length');
grid on;

figure(4);
plot(K,G(2,:) , 'r' );
hold on ;
plot(K,AvgLen2 , 'black');
title('G and Average Length for source X^2');
legend('Gk','Average Length');
grid on;

figure(5);
plot(K,G(3,:) , 'g' );
hold on ;
plot(K,AvgLen3 , 'black');
title('G and Average Length for source X^3');
legend('Gk','Average Length');
grid on;


%% code efficiency



figure(6);
plot(K,H(1)*ones(1,10) , 'b');
hold on ;
plot(K,CE(1,:) , 'black');
title('Code Efficiency and Entropy for source X ');
legend('Entropy','Code Efficiecy');
grid on;

figure(7);
plot(K,H(2)*ones(1,10) , 'r');
hold on ;
plot(K,CE(2,:) , 'black');
title('Code Efficiency and Entropy for source X^2 ');
legend('Entropy','Code Efficiecy');
grid on;

figure(8);
plot(K,H(3)*ones(1,10) , 'g');
hold on ;
plot(K,CE(3,:) , 'black');
title('Code Efficiency and Entropy for source X^3 ');
legend('Entropy','Code Efficiecy');
grid on;
%%
    
    
    
    
    
    