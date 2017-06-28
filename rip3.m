function rip3
n = 50;   % desired # spikes
lambda = 10;  % rate -> spikes/sec
T=40; %first few parts we do with t=5, to get the hisotgrams we do various times, 10,20,30,40,50
dt=.2;
nb=T/dt;
e=[0:dt:5];
% compute spike times from ISIs
S =zeros(100,1);
for j=1:50
for i = 2: length(S)
    u = rand(100,1);% n random #s, uniform distribution
ISI = -log(u)./lambda;   % ISIs in sec
S(1) = ISI(1);
    S(j,i) = S(j,i-1)+ISI(i);
    S(S>T)=NaN;
    if isnan(S(j,i))
        S(j,i)=0;
        end
    count(i)=S(j,i);
    timev=cumsum(ISI);
end
drawnow
%plot(S,1:100,'.k');
axis([0 5 0.5 50]);
cv(j)=std(ISI)/mean(ISI);
FF(j)=var(count)/mean(count);
end
figure(1)
plot(cv,T,'.k');
axis([0 5 0.5 50]); %allows us to see 1-50
xlabel('CV');
hold on
figure(2)
plot(FF,T,'.k');
axis([0 5 0.5 50]);
xlabel('FF');
hold on
%below is used for part 1,2,6,7 in PART I
hold on
xlabel('Time');
ylabel('Trial #');
figure(2)
plot(cv,1:50,'.k');
xlabel('cvk');
ylabel('Trial #');
figure(3)
T2=[0 .5 1 2 5 10 20 30 40 50 60 70 80 90 100];
a = sum(cv)/50 %% close to one
b = sum(count)/100*T %% close to expected 10
c = sum(FF)/50 %% close to one
plot(T2, a)
end
