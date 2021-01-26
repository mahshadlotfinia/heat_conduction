function [K_T,F_T]=boundary(K,F,BC)
Kb=max(diag(K))*(1e6);
d=BC(:,2);
F_T=F;
K_T=K;
for i=1:size(BC,1)
    m=BC(i,1);
    K_T(m,m)=K(m,m)+Kb;
    F_T(m,1)=Kb*d(i,1);
end
end