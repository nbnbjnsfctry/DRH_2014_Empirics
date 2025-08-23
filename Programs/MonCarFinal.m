
%This program runs monte carlo simulations using SDMasterFinal

niter = 100; %number of random realizations for montecarlo

for mcar = 1:niter
    
    save mcar mcar niter
    mcar
    SDMasterFinal
    
    load mcar
    
    if mcar > 1
        load OutputFinal
    end
    
    
    wMC(mcar,:,:) = w;
    Z_MMC(mcar,:,:) = Z_M;
    Z_SMC(mcar,:,:) = Z_S;
    Z_M_MorMC(mcar,:,:) = Z_M_Mor;
    Z_S_MorMC(mcar,:,:) = Z_S_Mor;
    c_MMC(mcar,:,:) = c_M;
    c_SMC(mcar,:,:) = c_S;
    p_MMC(mcar,:,:) = p_M;
    p_SMC(mcar,:,:) = p_S;
    MMC(mcar,:,:) = M;
    SMC(mcar,:,:) = S;
    L_MMC(mcar,:,:) = L_M;
    L_SMC(mcar,:,:) = L_S;
    L_MNANMC(mcar,:,:) = L_MNAN;
    L_SNANMC(mcar,:,:) = L_SNAN;
    LMC(mcar,:,:) = L;
    R_MMC(mcar,:,:) = R_M;
    R_SMC(mcar,:,:) = R_S;
    phi_MMC(mcar,:,:) = phi_M;
    phi_SMC(mcar,:,:) = phi_S;
    thetaMC(mcar,:,:) = theta;
    Po_MMC(mcar,:,:) = Po_M;
    Po_SMC(mcar,:,:) = Po_S;
    taoMC(mcar,:,:) = tao;
    tao_SMC(mcar,:,:) = tao_S;
    tao_MMC(mcar,:,:) = tao_M;
    ES_MMC(mcar,:,:) = ES_M;
    UbarMC(mcar,:,:) = Ubar;
    RIMC(mcar,:,:) = RI;
    Z_MvecMC(mcar,:,:) = Z_Mvec;
    Z_SvecMC(mcar,:,:) = Z_Svec;
    
    save OutputFinal *MC niter
    
end

save OutputFinal

    