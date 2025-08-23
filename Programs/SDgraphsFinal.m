%Graphs for SD using outputMC coming from MonCar.m

load('OutputFinal.mat')
niter = 100;

subplot(2,2,1)
hold on
box
p21(1,:) = mean(log(sum(MMC/length(l),2)./((sum(L_MMC.*thetaMC,2)./length(l)).^mu)),1);
p22(1,:) = mean(log(sum(SMC/length(l),2)./((sum(L_SMC.*(1-thetaMC),2)./length(l)).^sigma)),1);
p23(1,:) = mean(log(sum(MMC,2)./sum((L_MMC.^mu).*(thetaMC),2)),1);
p24(1,:) = mean(log(sum(SMC,2)./sum((L_SMC.^sigma).*(1-thetaMC),2)),1);

plot([1:T],p21,'b',[1:T],p22,'r','linewidth',2)
xlabel('Time')
ylabel('Agg. Z_M (blue) and Z_S(red)')
xlim([0 T])

hold off

subplot(2,2,2)

p71(1,:) = mean(sum(thetaMC.*L_MMC,2)/(length(l)*Lbar),1);
p72(1,:) = mean(sum((1-thetaMC).*L_SMC,2)/(length(l)*Lbar),1);
plot([1:T],p71,'b',[1:T],p72,'r','linewidth',2)
xlabel('Time')
ylabel('M (blue) and S (red) labor share')
xlim([0 T])


subplot(2,2,3)
p81(:,:) = mean(log(Z_MMC),1);
p91(:,:) = mean(log(Z_SMC),1);

hold on
imagesc(p81,[0 max([max(max(p81)),max(max(p91))])])
colorbar('off')
title('log(Z_M)')
xlabel('Time')
ylabel('Location')
xlim([1 T+1])
ylim([1 length(l)])



subplot(2,2,4)
hold on
imagesc(p91,[0 max([max(max(p81)),max(max(p91))])])
colorbar
title('log(Z_S)')
xlabel('Time')
ylabel('Location')
xlim([1 T+1])
ylim([1 length(l)])

hold off
