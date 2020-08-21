clc
format long
n=input('Ingrese el numero de datos a evaluar:');
for i=1:n
    Y(1,i)=input ('Al2O3:');
    i=i+1;
end
for i=1:n
    X(1,i)=input ('Fe2O3:');
    i=i+1;
end
for i=1:n
    Z(1,i)=input ('SiO2:');
    i=i+1;
end
Al2O3=Y';
Fe2O3=X';
SiO3=Z';
rango={'1','2','3','4','5'};
tabla=table(Al2O3,SiO3,Fe2O3,'RowNames',rango);
Ysuma=0;
Zsuma=0;
Xsuma=0;
Z2suma=0;
X2suma=0;
ZporX=0;
ZporY=0;
XporY=0;
for l=1:n
    Ysuma=Y(1,l)+Ysuma;
    Zsuma=Z(1,l)+Zsuma;
    Xsuma=X(1,l)+Xsuma;
    Z2suma=Z(1,l).^2+Z2suma;
    X2suma=X(1,l).^2+X2suma;
    ZporX=Z(1,l).*X(1,l)+ZporX;
    ZporY=Y(1,l)*Z(1,l)+ZporY;
    XporY=Y(1,l)*X(1,l)+XporY;
end
SUMAVariableyydep=Ysuma;SUMAVariablexind=Xsuma;SUMAVariablezDind=Zsuma;SUMAxcud=X2suma;
SUMAxdcud=Z2suma;SUMAxporxD=ZporX;SUMAxpory=XporY;SUMAxDpory=ZporY;
rango={'1'};
tabladeSuma=table(SUMAVariableyydep,SUMAVariablexind,SUMAVariablezDind,SUMAxcud,SUMAxdcud,SUMAxporxD,SUMAxpory,SUMAxDpory,'RowNames',rango);

y=Ysuma;
x2=Zsuma;
x1=Xsuma;
xcud=X2suma;
xdcud=Z2suma;
xunoporxdos=ZporX;
sumayporx1=XporY;
sumayporx2=ZporY;

Matrizcoefic=[n,x1,x2;x1,xcud,xunoporxdos;x2,xunoporxdos,xdcud];
terminosindepen=[y;sumayporx1;sumayporx2];
invMatrizcoefic=inv(Matrizcoefic);
valoread=(invMatrizcoefic*terminosindepen);
a2=valoread(3,1);
a0=valoread(1,1);
a1=valoread(2,1);
rango={'1'};
tabladetercoeficientes= table(a0,a1,a2,'RowNames',rango);