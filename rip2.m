function rip2
tic
ti=35;
tmax=200;
c=1;
gl=50*(10^(-3));
vl=-65;
vthresh=-45;
vr=-65;
tau=2;
dt=.1;
N=(tmax-ti)/dt;
V=[1;zeros(size(N))];
T =[ti:dt:tmax];
Ie=[1;zeros(size(N))];
Vspk=-20;
numspikes=0;
V(1)=vl;
tspike=0;
I0=1.1;
for i=1:N
if T(i)<40
        Ie(i+1)=1.1;
    elseif T(i)>40
        Ie(i+1)=1.1;
end
V(i+1)=V(i)+dt.*(((-gl.*(V(i)-vl)+Ie(i))./c));
if (V(i+1) > vthresh)
     if numspikes>0
         if (T(i)>=(tspike+tau))
 V(i+1) = vr;
 V(i)=-30;
 tspike=T(i);
 numspikes=numspikes+1;
         end
else
 V(i+1)=vr;
 V(i)=-30;
 tspike=T(i);
 numspikes=numspikes+1;
     end
end
end
drawnow
figure(1)
subplot(2,1,1)
plot(T,V,'color','black');
ylabel('Voltage');
xlabel('Time');
title('Voltage v Time');
subplot(2,1,2);
plot(T,Ie);
ylabel('External Current');
xlabel('Time');
title('Voltage v Time');
hold off
toc
end