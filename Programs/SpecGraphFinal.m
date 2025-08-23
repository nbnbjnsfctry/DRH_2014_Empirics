
clear all

load('OutputFinal.mat')

x(:,:) = mean(thetaMC(:,:,1:200),1);
imagesc(x);

colorbar
title('log(Z_S): \delta = 5')
xlabel('Year')
ylabel('Location')
xlim([1 200])
ylim([1 length(l)])
