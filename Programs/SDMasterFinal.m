%This program solves the model in "Spatial Development"

clear all 

global t h_M h_S alfa gamma mu sigma l a ksi1 ksi2 Lbar kappa
global w Z_M Z_S Z_M_Mor Z_S_Mor c_M c_S p_M p_S M S L_M L_S L R_M R_S phi_M phi_S theta Po_M Po_S tao ES_M Ubar RI

%Parameter Values
beta = .9747;
h_M = 0.9;
h_S = 1.4;
alfa = -1.5;
mu = .6;
gamma = 1-mu; %(needs to be 1-mu);
sigma =.6;
l = 1:500;
a = 45; %Pareto coefficient
ksi1 = 1.142793;
ksi2 = 0.0082433;
delta = 7.5;
Lbar = 100;
kappa = 0.08;
T = 240;

%Allocate variables
w = zeros(length(l),T);
Z_M = zeros(length(l),T);
Z_S = zeros(length(l),T);
Z_M_Mor = zeros(length(l),T);
Z_S_Mor = zeros(length(l),T);
c_M = zeros(length(l),T);
c_S = zeros(length(l),T);
p_M = zeros(length(l),T);
p_S = zeros(length(l),T);
M = zeros(length(l),T);
S = zeros(length(l),T);
L_M = zeros(length(l),T);
L_S = zeros(length(l),T);
L_MNAN = zeros(length(l),T);
L_SNAN = zeros(length(l),T);
L = zeros(length(l),T);
R_M = zeros(length(l),T);
R_S = zeros(length(l),T);
phi_M = zeros(length(l),T);
phi_S = zeros(length(l),T);
theta = zeros(length(l),T);
Po_M = zeros(length(l),T);
Po_S = zeros(length(l),T);
tao = zeros(length(l),T);
tao_S = zeros(length(l),T);
tao_M = zeros(length(l),T);
ES_M = zeros(length(l),T);
Ubar = zeros(1,T);
RI = zeros(1,T);
Z_Mvec = zeros(length(l),length(l));
Z_Svec = zeros(length(l),length(l));

 


X0(1) = 0.0492; %Ubar(1) initial value for solver
X0(2) = 1.035; %p_M(1,1) initial value for solver
X0(3) = 0.054; %RI(1) initial value for solver

for t = 1:T
    
    %t
    
    %Initial Productivity
    if t == 1
        Z_M_Mor(:,1) = .8 + .4*l/length(l);
        Z_S_Mor(:,1) = 1*ones(length(l),1);
    end
        
    F=@(R)SDsysFinal(R);
    options=optimset('MaxFunEvals',10000000000,'TolFun',0.0001,'MaxIter',1000000,'Display','off');
    [X,Eval] = fsolve(F,X0,options);
    
    X0(1) = Ubar(t);
    X0(2) = p_M(1,t);
    X0(3) = RI(t);
    
    %Eval

    %Diffusion 
    for i = 1:length(l)
        for j = 1:length(l)
            Z_Mvec(i,j) = exp(-delta*abs(i-j)/length(l))*Z_M(j,t);
            Z_Svec(i,j) = exp(-delta*abs(i-j)/length(l))*Z_S(j,t);
        end
        Z_M(i,t+1) = max(Z_Mvec(i,:));
        Z_S(i,t+1) = max(Z_Svec(i,:));
        
        %Save Morning Productivity
        Z_M_Mor(:,t+1) = Z_M(:,t+1);
        Z_S_Mor(:,t+1) = Z_S(:,t+1);
    end
    
end

