function meshplot(x,y,element_info,n_element)
NODETINFO=['Number of nodes are =  ',num2str(size(x,1))];
disp(NODETINFO);
ELEMENTINFO=['Number of elements are =  ',num2str(n_element)];
disp(ELEMENTINFO);
close all
step=0.0005;
% Create figure
figure1=figure('Color',[1 1 1]);
% Creat axis
axes1=axes('Parent',figure1);
box(axes1,'on');
hold(axes1,'all');

for i=1:n_element
    XA=x(element_info(i,2),1);
    XB=x(element_info(i,3),1);
    XC=x(element_info(i,4),1);
    YA=y(element_info(i,2),1);
    YB=y(element_info(i,3),1);
    YC=y(element_info(i,4),1);
    E=XB-XA;
    if E>0
        X1=XA:step:XB;
        M=(YA-YB)/(XA-XB);
        Y1=M*(X1-XA)+YA;
    else E<0
        X1=XB:step:XA;
        M=(YA-YB)/(XA-XB);
        Y1=M*(X1-XA)+YA;
    end
    if XB<XC
        X2=XB:step:XC;
        M=(YB-YC)/(XB-XC);
        Y2=M*(X2-XB)+YB;
    else
        X2=XC:step:XB;
        M=(YB-YC)/(XB-XC);
        Y2=M*(X2-XB)+YB;
    end
    if XA<XC
        X3=XA:step:XC;
        M=(YA-YC)/(XA-XC);
        Y3=M*(X3-XA)+YA;
        
    else
        X3=XC:step:XA;
        M=(YA-YC)/(XA-XC);
        Y3=M*(X3-XA)+YA;
    end
    plot(X1,Y1,X2,Y2,X3,Y3);
    
    
    
    
    
    
    
    
end























end