function rip
tic
ti=40;
tmax=80;
c=1;
gl=50*(10^(-3));
vl=-65;
vthresh=-45;
vr=-65;
tau=2;
dt=0.01;
N=(tmax-ti)/dt;
V=[1;zeros(size(N))];
T =[ti:dt:tmax];
Ie=[1;zeros(size(N))];
Vspk=-22;
numspikes=0;
V(1)=vl;
tspike=0;
for I0=0:.1:7
    hold on
for i=1:N
if T(i)<40
        Ie(i+1)=0;
    elseif T(i)>40
        Ie(i+1)=I0;
end
V(i+1)=V(i)+dt.*(((-gl.*(V(i)-vl)+Ie(i))./c));
 
if Ie(i+1)>1 &&(V(i))<vthresh && V(i+1)>=vthresh
    numspikes=numspikes+1;
    tspike=T(i);
 if (T(i)<(tspike+tau))
 V(i+1)=vr;
 V(i)=-30;
 else
V(i+1)=vr;
V(i)=-30;
 end
end
if numspikes>0
avg=(numspikes/(tmax-40))/1000;
elseif numspikes<=0
    numspikes=0;
    avg=(numspikes/(tmax-40))/1000;
end
end
drawnow
figure(1)
subplot(2,1,1);
plot(T,V);
ylabel('Voltage');
subplot(2,1,2);
plot(T,Ie);
ylabel('External Current');
for j=1:71
avgholder(j)=avg;
I0holder(j)=I0;
yindex=find(round(V)==vthresh);
if numspikes>0 && T(i)<199
totaltimes(j)=(T(yindex(1))) ;
elseif numspikes <=0
    totaltimes(j)=0;
end
drawnow
figure(2)
plot(I0holder,avgholder);
ylabel('average firing rate');
xlabel('Amplitude of Ie');
title('Amplitude of Ie v AFR');
toc
end
end
end