clc
clear all
format short
%Matriz distancias
d=xlsread('d.xlsx');
K=zeros(34,34);
for i=1:34
    for j =1:34
  K(i,j)=(0.005*((1.5*(d(i,j)/170 )) - (0.005*((d(i,j)/170)^3))));
%   if d(i,j)>53 
%       K(i,j)=0;
%   end
    end
end
K1=K(1:17,1:17);
K2=K(18:34,1:17);
K3=K(1:17,18:34);
K4=K(18:34,18:34);
invK1=inv(K1);
invK2=inv(K2);
invK3=inv(K3);
invK4=inv(K4);
invK=[invK1 invK3;invK2 invK4];


% posiciones de datos conocidos en x y y

xi=[240 230	220	210	200	190	180	170	160	150	140	130	120	110	100	90	80 ... 
   140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 140 ];
yi=[160	160	160	160	160	160	160	160	160	160	160	160	160	160	160	160	160 ...
   260 250 240 230 220 210 200 190 180 170 160 150 140 130 120 110 100 ];
%densidades conocidas
rho_c=[1.324 1.304	1.224 1.094	1.101 1.119 ...
       1.175 0.169	1.131 1.122	1.317 1.126...
       1.258 1.0625 1.236 1.086 1.136 1.035 ...
       1.077 1.026	1.093 1.009	1.013 0.999...
       1.110 1.026 1.036 0.981 1.104 1.155...
       1.034 1.038 1.081 0.998 ];
 %cracion de la maya, nx y dx para que sea una matriz cuadrada
%cracion de la maya, nx y dx para que sea una matriz cuadrada
nx=100;
%dx=(240-80)/(nx-1);
%x=80:dx:240;
dx=400/(nx-1);
x=0:dx:400;
ny=nx;
dy=400/(nx-1);
y=0:dy:400;
%dy=(260-90)/(nx-1);
%y=90:dy:260;
%matriz de nx x ny para tener k en cada nodo 
k=zeros(nx,ny,34);
lambda=zeros(nx,ny,34);
kk=zeros(34,1);
rho=zeros(nx,ny);
for i=1:nx
    for j=1:ny
        for jj=1:34
            %distancia de cada punto a al punto incognita(pitagoras)
            h=sqrt((xi(jj)-x(i))^2+(yi(jj)-y(j))^2);
            %varianza modelo dado
            k(i,j,jj)=(0.005*((1.5*(h/170 )) - (0.005*((h/170)^3))));
            kk(jj)=k(i,j,jj);
        end
        lambda(i,j,:)=invK*kk;
    end
   
end
for i=1:nx
    for j=1:ny
        rho(i,j)=0;
        for jj=1:34
        rho(i,j)=((rho(i,j)+(lambda(i,j,jj)*rho_c(jj))));
        end
    end
end


%subplot(2,1,1);
%scatter(h,h,rho)

%subplot(2,1,2);
%contourf(x,y,rho)

contourf(x,y,rho)
  