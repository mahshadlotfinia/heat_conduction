function C=Ctransient(rho,Cheat,Area,a,b,c,x,y,t)
alpha=(rho*Cheat*t);
x0y0=Area;
yB=(y(1,1)+y(1,2)+y(1,3))/3;
xB=(x(1,1)+x(1,2)+x(1,3))/3;
y1=Area*yB;
x1=Area*xB;
y2=Area*(y(1,1)^2+y(1,2)^2+y(1,3)^2+9*yB^2)/12;
x1y1=Area*(x(1,1)*y(1,1)+x(1,2)*y(1,2)+x(1,3)*y(1,3)+9*xB*yB)/12;
x2=Area*(x(1,1)^2+x(1,2)^2+x(1,3)^2+9*xB^2)/12;
for i=1:3
    for j=1:3
        N(i,j)=(a(1,i)*a(1,j)*x0y0+(a(1,i)*b(1,j)+(a(1,j)*b(1,i))*x1+(a(1,i)*c(1,j)+a(1,j)*c(1,i))*y1+...
            (b(1,i)*c(1,j)+b(1,j)*c(1,i))*x1y1+b(1,i)*b(1,j)*x2+c(1,i)*c(1,j)*y2))/(4*Area^2);
    end
end
C=alpha*N;
end
