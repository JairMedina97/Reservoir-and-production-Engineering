clc, clear all,close all
mu = 10; %cP
B = 1.2; 
co = 1e-3; %1/psi
cphi = 1e-5; %1/psi
phi = 0.2;
P0 = 5000; %psi
kx = 10; %mD
tf = 10; %day
dt = 2; %day
nt = tf/dt +1; %número de pasos en el tiempo
L = 100; %ft
betac = 0.001127;
alphac = 5.614583;
Ax = 50*50; %ft2
nx = 25;
dx = 50; %ft
Vb = dx*Ax; %ft3

T= betac*Ax*kx/(mu*B*dx);
 aa = 2*Vb*phi*(co + cphi)/(alphac*B*dt);
 
A=zeros(nx,nx);
for i =1:4;
    for j=6:9;
       for m=11:14;
          for n=16:19;
               for k=20:nx-1;
    A(i,i) = -3*T-aa;
    A(i+5,i)=T;
    A(i,i+5)=T;
    A(5,5)=-2*T-aa;
    A(j,j) = -4*T-aa;
    A(25,25)=-2*T-aa;
     A(m,m)=-4*T-aa;
    A(n,n)=-4*T-aa;
    A(k,k)=-3*T-aa;
    A(10,10)=-3*T-aa;
    A(15,15)=-3*T-aa;
               end
          end
       end
    end
end
for i=1:nx-1
    for k=5:5:nx-1
        for j=5:nx-5
     A(i+1,i)=T;
    A(i,i+1)=T;
    A(j+5,j)=T;
    A(j,j+5)=T;
    A(k+1,k)=0;
    A(k,k+1)=0;
        end
    end
end

bb= 2*Vb*phi*(co + cphi)/(alphac*B*dt);
 
 BB =zeros(nx,nx);
 for i =1:4;
    for j=6:9;
       for m=11:14;
          for n=16:19;
               for k=20:nx-1;
    BB(i,i) = 3*T-bb;
    BB(i+5,i)=-T;
    BB(i,i+5)=-T;
    BB(5,5)=2*T-bb;
    BB(j,j) =4*T-bb;
    BB(25,25)=2*T-bb;
    BB(m,m)=4*T-bb;
    BB(n,n)=4*T-bb;
    BB(k,k)=3*T-aa;
    BB(10,10)=3*T-bb;
    BB(15,15)=3*T-bb;
               end
          end
       end
    end
end
for i=1:nx-1
    for k=5:5:nx-1
        for j=5:nx-5
     BB(i+1,i)=-T;
    BB(i,i+1)=-T;
    BB(j+5,j)=-T;
    BB(j,j+5)=-T;
    BB(k+1,k)=0;
    BB(k,k+1)=0;
        end
    end
end

   

p = zeros(nx,nt);
p(:,1)= P0;

qsc = zeros(nx,1);
qsc(13) = -100; %STB/day


figure('name','Cambio de presiones en el yacimiento 1D','NumberTitle', 'off')
plot(p(:,1))
xlabel('Número de bloque'),ylabel('Presión(psi)'),grid on , grid minor, ylim([3400 5000]);
hold on
for n = 1:nt-1
    hold on
    t = 0+dt*(n - 1);
    if t >= 5
        qsc(13) = 0;
    end
    
    p(:,n+1)=A\(BB*p(:,n)-2*qsc);
    plot(p(:,n+1))
    mesh(p)
end
figure(2)
plot(p(13,:));
xlabel('Número de bloque'),ylabel('Presión(psi)'),grid on, grid minor;
figure(8)
p1=p(:,1);
yac1=reshape(p1,[5,5]);
yacimiento1=rot90(yac1);
 x1=1:5;
 y=1:5;
 [X,Y]=meshgrid(x1,y,1);
 surf(X,Y,yacimiento1);
shading interp

figure(3)
p2=p(:,2);
yac2=reshape(p2,[5,5]);
yacimiento2=rot90(yac2);
 x1=1:5;
 y=1:5;
 [X,Y]=meshgrid(x1,y,1);
 surf(X,Y,yacimiento2);
shading interp

figure(4)
p3=p(:,3);
yac3=reshape(p3,[5,5]);
yacimiento3=rot90(yac3);
 x1=1:5;
 y=1:5;
 [X,Y]=meshgrid(x1,y,1);
 surf(X,Y,yacimiento3);
shading interp;

figure(5)
p4=p(:,4);
yac4=reshape(p4,[5,5]);
yacimiento4=rot90(yac4);
 x1=1:5;
 y=1:5;
 [X,Y]=meshgrid(x1,y,1);
 surf(X,Y,yacimiento4);
shading interp;

figure(6)
p5=p(:,5);
yac5=reshape(p5,[5,5]);
yacimiento5=rot90(yac5);
 x1=1:5;
 y=1:5;
 [X,Y]=meshgrid(x1,y,1);
 surf(X,Y,yacimiento5);
shading interp;

figure('name','Cambio de presiones en el yacimiento 2D','NumberTitle', 'off')
p6=p(:,6);
yac6=reshape(p6,[5,5]);
yacimiento6=rot90(yac6);
 xx=1:5;
 yy=1:5;
 [X,Y]=meshgrid(xx,yy,1);
 surf(X,Y,yacimiento6);
 xlabel('Número de bloque'),ylabel('Número de bloque'),zlabel('Presión(psi)');
shading interp;