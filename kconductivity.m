function Kc=kconductivity(kxx,kyy,b,c,A,t)
B=[b(1,1) b(1,2) b(1,3);c(1,1) c(1,2) c(1,3)]/(2*A);
D=[kxx 0;0 kyy];
Kc=t*A*B'*D*B;
end