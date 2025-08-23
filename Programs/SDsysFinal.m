function D = SDsysFinal(X)

global t h_M h_S alfa gamma mu sigma l a ksi1 ksi2 Lbar kappa 
global w Z_M Z_S Z_M_Mor Z_S_Mor c_M c_S p_M p_S M S L_M L_S L R_M R_S phi_M phi_S theta Po_M Po_S ES_M Ubar RI

p_S(:,t) = ones(length(l),1);

Ubar(t) = X(1);
p_M(1,t) = X(2);
RI(t) = X(3);

Z_M(:,t) = Z_M_Mor(:,t);
Z_S(:,t) = Z_S_Mor(:,t);

for i = 1:length(l)

    %Wages and consumption
    
    w(i,t) = Ubar(t)*((((p_M(i,t)./h_M)/(p_S(i,t)./h_S))^(1/(alfa-1)))*p_M(i,t) + p_S(i,t))...
        ./(h_M*(((p_M(i,t)./h_M)/(p_S(i,t)./h_S))^(alfa/(alfa-1))) + h_S).^(1/alfa) - RI(t);
        
    c_S(i,t) = (w(i,t) + RI(t))./(p_M(i,t).*(((p_M(i,t)./h_M)/(p_S(i,t)./h_S))^(1/(alfa-1)))+p_S(i,t));
    c_M(i,t) = c_S(i,t).*(((p_M(i,t)./h_M)/(p_S(i,t)./h_S))^(1/(alfa-1)));
    
    %Choose phi
    phi_M(i,t) = 1-((Z_M(i,t)*p_M(i,t)*gamma)/(ksi2*(a-1)*((w(i,t)/(mu*p_M(i,t)))^((1-gamma)/gamma))))^(-1/2);
    phi_S(i,t) = 1-((Z_S(i,t)*p_S(i,t)*gamma)/(ksi2*(a-1)*((w(i,t)/(sigma*p_S(i,t)))^((1-gamma)/gamma))))^(-1/2);
    
    if phi_M(i,t) < 0
        phi_M(i,t) = 0;
    end
    if phi_M(i,t) > 1;
        phi_M(i,t) = 1;
    end
    if phi_S(i,t) < 0
        phi_S(i,t) = 0;
    end
    if phi_S(i,t) > 1;
        phi_S(i,t) = 1;
    end

    %Production and labor choices
    L_M(i,t) = (w(i,t)./(mu*p_M(i,t).*((Z_M(i,t)*(phi_M(i,t)/(a-1)+1)).^gamma))).^(1/(mu-1));
    L_S(i,t) = (w(i,t)./(sigma*p_S(i,t).*((Z_S(i,t)*(phi_S(i,t)/(a-1)+1)).^gamma))).^(1/(sigma-1));
    
    if (ksi1 + ksi2*(1/(1-phi_M(i,t))))*w(i,t) > (((Z_M(i,t)).^gamma)*p_M(i,t).*(L_M(i,t).^mu)/((a-1)^gamma))...
            *(((phi_M(i,t)+a-1)^gamma - (a-1)^gamma));
        phi_M(i,t) = 0;
        L_M(i,t) = (w(i,t)./(mu*p_M(i,t).*(Z_M(i,t).^gamma))).^(1/(mu-1));
    end
    if (ksi1 + ksi2*(1/(1-phi_S(i,t))))*w(i,t) > (((Z_S(i,t)).^gamma)*p_S(i,t).*(L_S(i,t).^sigma)/((a-1)^gamma))...
            *(((phi_S(i,t)+a-1)^gamma - (a-1)^gamma));
        phi_S(i,t) = 0;
        L_S(i,t) = (w(i,t)./(sigma*p_S(i,t).*(Z_S(i,t).^gamma))).^(1/(sigma-1));
    end    
    
    %Land Use and Land Rents
    R_M(i,t) = p_M(i,t)*((Z_M(i,t)*(phi_M(i,t)/(a-1)+1)).^gamma).*(L_M(i,t).^mu)-w(i,t).*L_M(i,t)- w(i,t)*(ksi1+ksi2*(1/(1-phi_M(i,t))));
    R_S(i,t) = p_S(i,t)*((Z_S(i,t)*(phi_S(i,t)/(a-1)+1)).^gamma).*(L_S(i,t).^sigma)-w(i,t).*L_S(i,t)- w(i,t)*(ksi1+ksi2*(1/(1-phi_S(i,t))));
    
    
    if R_M(i,t) > R_S(i,t)
        theta(i,t) = 1; 
        phi_S(i,t) = 0;
    else
        theta(i,t) = 0;
        phi_M(i,t) = 0;
    end
    
    %Expected Outputs
    M(i,t) = ((Z_M(i,t)*(phi_M(i,t)/(a-1)+1)).^gamma).*L_M(i,t).^mu;
    S(i,t) = ((Z_S(i,t)*(phi_S(i,t)/(a-1)+1)).^gamma).*L_S(i,t).^sigma;
    
    %Aggregate Labor
    L(i,t) = theta(i,t).*L_M(i,t)+(1-theta(i,t)).*L_S(i,t);
    
    %Construct Excess Supply
    if i > 1
        if phi_M(i,t) > 0
            ES_M(i,t) =  ES_M(i-1,t) + (theta(i,t)*(M(i,t)- (w(i,t)/p_M(i,t))*(ksi1+ksi2*(1/(1-phi_M(i,t))))) - c_M(i,t).*L(i,t) - kappa*(abs(ES_M(i-1,t))))/length(l);
        else
            ES_M(i,t) =  ES_M(i-1,t) + (theta(i,t)*M(i,t) - c_M(i,t).*L(i,t) - kappa*(abs(ES_M(i-1,t))))/length(l);
        end    
    else
        if phi_M(i,t) > 0
            ES_M(i,t) =  (theta(i,t)*(M(i,t)- (w(i,t)/p_M(i,t))*(ksi1+ksi2*(1/(1-phi_M(i,t))))) - c_M(i,t).*L(i,t))/length(l);
        else
            ES_M(i,t) =  (theta(i,t)*M(i,t) - c_M(i,t).*L(i,t))/length(l);
        end
    end
    
    %Construct prices for i+1
    if ES_M(i,t) > 0
        if i < length(l)
            p_M(i+1,t) = p_M(i,t)*exp(kappa/length(l));
        end
    else
        if i < length(l)
            p_M(i+1,t) = p_M(i,t)*exp(-kappa/length(l));
        end    
    end
    
    %Generate Poisson draws
    Po_M(i,t) = rand;
    Po_S(i,t) = rand;
    
    %Generate Pareto and update productivity after innovation
    if Po_M(i,t) > phi_M(i,t);
        Z_M(i,t) = Z_M(i,t);
    else
        z = gprnd(1/a,1/a,1);
        Z_M(i,t) = z*Z_M(i,t); 
    end
    if Po_S(i,t) > phi_S(i,t);
        Z_S(i,t) = Z_S(i,t);
    else
        z = gprnd(1/a,1/a,1);
        Z_S(i,t) = z*Z_S(i,t); 
    end
        
    %Actual Outputs
    M(i,t) = theta(i,t).*(Z_M(i,t).^gamma).*L_M(i,t).^mu;
    S(i,t) = (1-theta(i,t)).*(Z_S(i,t).^gamma).*L_S(i,t).^sigma;
        
end

%Equilibrium in the goods market 
if (Ubar(t) > 0) %&& sum((1-theta(:,t)).*L_S(:,t))/length(l) < 100);
    d1 = ES_M(length(l),t);
else
    d1 = 1000000;
end    

%Equilibrium condition in labor market

if (p_M(1,t)> 0)% && p_M(1,t) < pp)
    d2 = sum(L(:,t))/length(l) - Lbar; 
else
    d2 = 1000000;
end 

%Calculate Rental Income (RI)

if (RI(t) > 0 && min(w(:,t)) > 0)
    d3 = RI(t) - (sum(theta(:,t).*R_M(:,t)) + sum((1-theta(:,t)).*R_S(:,t)))/(Lbar*length(l));  
else
    d3 = 1000000;
end

D = [d1,d2,d3];
        

