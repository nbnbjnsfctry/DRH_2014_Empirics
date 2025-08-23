%This program computes the distribution of land prices. It requires
%MonCarFinal.m output. 

clear all

load('OutputFinal','R_SMC','R_MMC','Z_SMC')

T1 = 90;
T2 = 110;
bins = 100;
l = 1:500;
niter = 100;

lb = 1;

j=0;
k=0;

hold on

RT1(:,:) = max(R_SMC(:,:,T1),R_MMC(:,:,T1));
RT2(:,:) = max(R_SMC(:,:,T2),R_MMC(:,:,T2));

ni = 0;
for j = 1:niter
    if max(max(Z_SMC(j,:,:))) == 1
        ni = ni + 1;
    end 
end 

ubound = max(max(max(log(RT1))),max(max(log(RT2))));
lbound = min(min(min(log(RT1))),min(min(log(RT2))));
Vbins = lbound:(ubound-lbound)/bins:ubound;

for j = 1:niter
[F1(j,:),x1(j,:)] = hist(log(RT1(j,:)),Vbins);
[F2(j,:),x2(j,:)] = hist(log(RT2(j,:)),Vbins);

F1(j,:) = min(F1(j,:)/(sum(F1(j,lb:bins))*(x1(j,2)-x1(j,1))),5);
F2(j,:) = min(F2(j,:)/(sum(F2(j,lb:bins))*(x2(j,2)-x2(j,1))),5);
       
end


distx1 = mean(x1(:,lb:bins),1);
disty1 = max(smooth(mean(F1(:,lb:bins),1),45,'rloess'),-0.00001); %lowess
distx2 = mean(x2(:,lb:bins),1);
disty2 = max(smooth(mean(F2(:,lb:bins),1),45,'rloess'),-0.00001);

sum1 = 0;
sum2 = 0;
for i = 1:bins-lb
    sum1 = sum1 + (distx1(i+1)-distx1(i))*disty1(i+1); 
    sum2 = sum2 + (distx2(i+1)-distx2(i))*disty2(i+1);
end

disty1 = disty1/sum1;
disty2 = disty2/sum2;

norma = 0;
for i = 1:bins-lb
    norma = norma + disty1(i)*distx1(i); 
end

norma = norma/sum(disty1);

plot(distx1 - norma,disty1,'y',distx2 - norma,disty2,'r','linewidth',3)
box on
hold off

title('"Urban" Land Rent Density (Model: Benchmark)')

xlabel('Land Rents')
ylabel('Density')

hold on

LRdata = importdata('landrents.txt');

normadata = sum(LRdata(:,1).*LRdata(:,2))/sum(LRdata(:,2));

plot(LRdata(:,1)-normadata,LRdata(:,2),'y--', LRdata(:,3)-normadata,LRdata(:,4),'r--','linewidth',3)



