clear all

load('OutputFinal.mat')

niter = 100;
subplot(2,2,1)
mcar2 = 0;
for mcar1 = 1:niter
   if max(max(phi_SMC(mcar1,:,:))) > 0
       mcar2 = mcar2 + 1;
       p_MMC2(mcar2,:,:) = p_MMC(mcar1,:,:);
       MMC2(mcar2,:,:) = MMC(mcar1,:,:); 
       L_MMC2(mcar2,:,:) = L_MMC(mcar1,:,:);
       SMC2(mcar2,:,:) = SMC(mcar1,:,:);
       L_SMC2(mcar2,:,:) = L_SMC(mcar1,:,:);
       thetaMC2(mcar2,:,:) =  thetaMC(mcar1,:,:);
       Z_SMC2(mcar2,:,:) = Z_SMC(mcar1,:,:);
   end    
end

for mcar = 1:mcar2
    for i = 1:length(l)
       
        for t = 1:T 
            if thetaMC2(mcar,i,t) == 0 
                VA_MNANMC(mcar,i,t) = NaN;
                L_MNANMC(mcar,i,t) = NaN;
            else
                VA_MNANMC(mcar,i,t) = log(p_MMC2(mcar,i,t)*MMC2(mcar,i,t));
                L_MNANMC(mcar,i,t) = log(L_MMC2(mcar,i,t));
            end
            if (1-thetaMC2(mcar,i,t)) == 0 
                VA_SNANMC(mcar,i,t) = NaN;
                L_SNANMC(mcar,i,t) = NaN;
            else
                
                VA_SNANMC(mcar,i,t) = log(SMC2(mcar,i,t));
                L_SNANMC(mcar,i,t) = log(L_SMC2(mcar,i,t));
                 
            end
        end
    end
end

p11(1,:) = nanmean(nanstd(L_MNANMC,0,2),1)./nanmean(nanstd(L_SNANMC,0,2),1);
p13(1,:) = nanmean(nanstd(VA_MNANMC,0,2),1)./nanmean(nanstd(VA_SNANMC,0,2),1);
plot([1:200],p11(1:200),'b','linewidth',1.5)
hold on
xlabel('Year')
ylabel('Emp. (red) and VA (blue) SD in M / SD in S')
xlim([0 200])

subplot(2,2,2)
p41(1,:) = mean(log(sum(thetaMC.*R_MMC,2)/length(l)),1);
p42(1,:) = mean(log(sum((1-thetaMC).*R_SMC,2)/length(l)),1);
p43(1,:) = mean(log(RIMC*Lbar),1);

plot([1:200],p41(1:200),'b',[1:200],p42(1:200),'r',[1:200],p43(1:200), 'g','linewidth',2)
hold on
hold off
xlabel('Year')
ylabel('logs of R_M (blue), R_S (red) and Rbar (green)')
xlim([0 200])

subplot(2,2,3)

p51(1,:) = mean(sum(p_MMC,2)/length(l),1);
plot([1:200],p51(1:200),'b','linewidth',2)
hold on
hold off
xlabel('Year')
ylabel('Avg. p_M')
xlim([0 200])

subplot(2,2,4)
hold on
box

p61(1,:) = mean(log(UbarMC),1);
p62(1,:) = mean(log(sum(wMC,2)/length(l)),1);

plot([1:200],p61(1:200),'g',[1:200],p62(1:200),'k','linewidth',2)
hold on
hold off
xlabel('Year')
ylabel('Logs of Ubar (green), Avg. w (black)')
xlim([0 200])

