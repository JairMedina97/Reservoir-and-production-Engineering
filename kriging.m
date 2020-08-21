clc
fprintf('Metodo de Krigging POROSIDAD \n');
%Matriz K c(h)}
K=[ 0.78 0.28 0.06 0.17 0.40 0.43;...
    0.28 0.78 0.43 0.39 0.27 0.20;... 
    0.06 0.43 0.78 0.37 0.11 0.06;...
    0.17 0.39 0.37 0.78 0.37 0.27;...
    0.40 0.27 0.11 0.37 0.78 0.65;...
    0.43 0.20 0.06 0.27 0.65 0.78];
Kinv=inv(K);
%posiciones de datos conocidos en x y y
xi=[900 2700 3700 2300 800 500];
yi=[3700 4300 5000 5700 5100 4900];
%porosidades conocidas
phi_c=[0.1384;0.1215;0.1287;0.1268;0.1441;0.1459];
%cracion de la maya, nx y dx para que sea una matriz cuadrada
nx=100;
dx=4000/(nx-1);
x=0:dx:4000;
ny=nx;
dy=(5700-3200)/(nx-1);
y=3200:dy:5700;
%matriz de nx x ny para tener k en cada nodo 
k=zeros(nx,ny,6);
lambda=zeros(nx,ny,6);
kk=zeros(6,1);
phi=zeros(nx,ny);
for i=1:nx
    for j=1:ny
        for jj=1:6
            %distancia de cada punto a al punto incognita(pitagoras)
            h=sqrt((xi(jj)-x(i))^2+(yi(jj)-y(j))^2);
            %varianza modelo dado
            k(i,j,jj)=0.78*(1 - (1.5*h/4141) + (0.5*(h/4141)^3));
            kk(jj)=k(i,j,jj);
        end
        lambda(i,j,:)=K\kk;
    end
   
end


for i=1:nx
    for j=1:ny
        phi(i,j)=0;
        for jj=1:6
        phi(i,j)=phi(i,j)+lambda(i,j,jj)*phi_c(jj);
        end
    end
end
surfc(x,y,phi)