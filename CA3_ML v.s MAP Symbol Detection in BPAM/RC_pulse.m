function [t , Pulse] = RC_pulse(T, Fs, B)


t = -6*T:T/Fs:6*T;
Pulse = zeros(1, length(t));

for i = 1 : length(t)
   if ( (t(1,i) == -T/(2*B) ) || ( t(1,i) == T/(2*B) ) )
       Pulse(1,i) = (pi/4)*sinc(1/(2*B));
   else 
       Pulse(1,i) = (cos(pi*B*t(1,i)/T).*sinc(t(1,i)/T))./((1-(2*B.*t(1,i)./T).^2));
   end
   
end
