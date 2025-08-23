clear all

load('OutputMu05.mat')
clear p*

subplot(2,2,1)
Z_MMC = Z_MMC(:,:,1:200);
Z_SMC = Z_SMC(:,:,1:200);
p811 = mean(log(Z_MMC),1);
p81(:,:) = p811(1,:,:);
p911 = mean(log(Z_SMC),1);
p91(:,:) = p911(1,:,:);

hold on
bound1 = max(max(p81));
imagesc(p81,[0 bound1])
colorbar
title('log(Z_M): \mu = \delta = 0.5')
xlabel('Year')
ylabel('Location')
xlim([1 200])
ylim([1 length(l)])



subplot(2,2,2)
hold on
bound2 = max(max(p91));
imagesc(p91,[0 bound2])
colorbar
title('log(Z_S): \mu = \delta = 0.5')
xlabel('Year')
ylabel('Location')
xlim([1 200])
ylim([1 length(l)])

hold off

subplot(2,2,3)
hold on
box
p21(1,:) = mean(log(sum(MMC/length(l),2)./((sum(L_MMC.*thetaMC,2)./length(l)).^mu)),1);
p22(1,:) = mean(log(sum(SMC/length(l),2)./((sum(L_SMC.*(1-thetaMC),2)./length(l)).^sigma)),1);

plot([1:T],p21,'b',[1:T],p22,'r','linewidth',2)
hold on
xlabel('Year')
ylabel('Agg. Z_M (blue) and Z_S(red)')
xlim([0 200])

hold off
