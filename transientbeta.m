function Tt=transientbeta(K,C,R,Tinitial,beta,ti,tf,dt)
Tt{1,1}=ti;
Tt{1,2}=Tinitial;
X=C/dt+beta*K;
XR=X^-1;
i=1;
for j=ti:dt:tf
    Y=(C/dt-(1-beta)*K)*Tt{i,2}+R;
    Tt{i+1,2}=XR*Y;
    for m=1:size(Tt{i+1,2})
        if Tt{i+1,2}(m,1)<0
            Tt{i+1,2}(m,1)=0;
        end
    end
    TT=i*dt+ti;
    i=i+1;
    Tt{i,1}(1,1)=TT;
end





end