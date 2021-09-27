function [t , Pulse] = RC_pulse(T, Fs, B, sampling_error, start, ending)

t = (start*Fs:ending*Fs)/Fs-sampling_error;
display(t)
Pulse = zeros(1,length(t));

for i = 1 : length(t)
   if ( (t(1,i) == -T/(2*B) ) || ( t(1,i) == T/(2*B) ) )
       Pulse(1,i) = (pi/4)*sinc(1/(2*B));
   else 
       Pulse(1,i) = (cos(pi*B*t(1,i)/T).*sinc(t(1,i)/T))./((1-(2*B.*t(1,i)./T).^2));
   end
   
end
