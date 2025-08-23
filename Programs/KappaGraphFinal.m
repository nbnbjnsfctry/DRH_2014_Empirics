clear all

load('OutputFinal.mat')
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
title('log(Z_M): \kappa = 0.8')
xlabel('Time')
ylabel('Location')
xlim([1 200])
ylim([1 length(l)])



subplot(2,2,2)
hold on
bound2 = max(max(p91));
imagesc(p91,[0 bound2-1])
colorbar
title('log(Z_S): \kappa = 0.8')
xlabel('Time')
ylabel('Location')
xlim([1 200])
ylim([1 length(l)])

hold off

load('OutputKappa07.mat')
clear p*

subplot(2,2,3)

Z_MMC = Z_MMC(:,:,1:200);
Z_SMC = Z_SMC(:,:,1:200);
p811 = mean(log(Z_MMC),1);
p81(:,:) = p811(1,:,:);
p911 = mean(log(Z_SMC),1);
p91(:,:) = p911(1,:,:);

hold on
imagesc(p81,[0 bound1])
colorbar
title('log(Z_M): \kappa = 0.7')
xlabel('Time')
ylabel('Location')
xlim([1 200])
ylim([1 length(l)])



subplot(2,2,4)
hold on
imagesc(p91,[0 bound2-1])
colorbar
title('log(Z_S): \kappa = 0.7')
xlabel('Time')
ylabel('Location')
xlim([1 200])
ylim([1 length(l)])

hold off