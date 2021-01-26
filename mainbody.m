clc
clear
tic
format long
%% Input 
input=xlsread('input.xlsx','SHEET1');
mesh=xlsread('mesh1.xlsx','SHEET1');

n_node=input(1,1);
n_element=input(1,2);
n_bc_conv=input(1,3);
n_bc_temp=input(1,4);
BC_conv=input(1:n_bc_conv,5:8);
BC_temp=input(1:n_bc_temp,9:10);
thickness=input(1,12);
kxx=input(1,14);
kyy=input(1,15);
rho=input(1,16);
Cheat=input(1,17);

x(:,1)=mesh(1:n_node,2);
y(:,1)=mesh(1:n_node,3);
element_info=mesh(1:n_element,7:10);
meshplot(x,y,element_info,n_element)

%% Shape function
K_global=zeros(n_node);
C_global=zeros(n_node);
for i=1:n_element
    jj=element_info(i,2);
    kk=element_info(i,3);
    ll=element_info(i,4);
    x_element(i,1:3)=[x(jj,1) x(kk,1) x(ll,1)];
    y_element(i,1:3)=[y(jj,1) y(kk,1) y(ll,1)];
    [a(i,:),b(i,:),c(i,:),Area(i,:),L(i,:)]=shapefunction(x_element(i,1:3),y_element(i,1:3));
    Kc{i,1}=kconductivity(kxx,kyy,b(i,:),c(i,:),Area(i,:),thickness);
    K_global(element_info(i,2:4),element_info(i,2:4))=K_global(element_info(i,2:4),element_info(i,2:4))+Kc{i,1};
    C{i,1}=Ctransient(rho,Cheat,Area(i,:),a(i,:),b(i,:),c(i,:),x_element(i,1:3),y_element(i,1:3),thickness);
    C_global(element_info(i,2:4),element_info(i,2:4))=C_global(element_info(i,2:4),element_info(i,2:4))+C{i,1};
end
%% Fh Kh
F_global=zeros(n_node,1);
for i=1:n_bc_conv
    element_conv=BC_conv(i,1);
    edge=BC_conv(i,2);
    LL=L(element_conv,edge);
    h=BC_conv(i,3);
    Te=BC_conv(i,4);
    [Kh{i,1},F{i,1}]=kconvection(h,LL,thickness,edge,Te);
    K_global(element_info(element_conv,2:4),element_info(element_conv,2:4))=K_global(element_info(element_conv,2:4),element_info(element_conv,2:4))+Kh{i,1};
    F_global(element_info(element_conv,2:4),1)=F_global(element_info(element_conv,2:4),1)+F{i,1}';
end
%% Constant Temperature
[KK_global,FF_global]=boundary(K_global,F_global,BC_temp);
%% Steady State Solution
disp('*****************************************************');
disp('* Steady State Nodal Temperatures are ...          *');
disp('*****************************************************');
T=(KK_global)\FF_global;
for i=1:n_node
    dd=[num2str(i),'=     ',num2str(T(i,1))];
    disp(dd)
end
%% Transient Solution
ti=input(6,1);
tf=input(6,2);
dt=input(6,3);
beta=input(6,4);
Tinitial(1:n_node,1)=input(8,2);
disp('*****************************************************');
disp('* Transient solution is doing  ...                  *');
disp('*****************************************************');
Tt=transientbeta(KK_global,C_global,FF_global,Tinitial,beta,ti,tf,dt);
AAA=[' The variable "Tt" has saved the transient responses from ', num2str(ti),'to', num2str(tf),'sec'];
disp(AAA);
time=[ti:dt:tf]';
n_X=input(10,2);
for jjj=1:n_X
    X=input(10+jjj,2);
    for iii=1:(tf-ti)/dt+1
        temp(iii,1)=Tt{iii,2}(X,1);
    end
    figure
    plot(time,temp)
    legend(num2str(X))
end











toc