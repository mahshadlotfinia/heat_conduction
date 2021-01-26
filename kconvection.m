function [Kh,F]=kconvection(h,L,t,edge,Te)
Kh=(h*L*t/6)*[2 1 0;1 2 0;0 0 0];
alpha=h*Te*L*t/2;
switch edge
    case 1
        F=alpha*[1 1 0];
    case 2
        F=alpha*[0 1 1];
    case 3
        F=alpha*[1 0 1];
end
end