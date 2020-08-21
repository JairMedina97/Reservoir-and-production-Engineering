%PIA Transporte y medicion de hidrocarburos
%Solution for mass or volume flow rate
clc 
clear all
% Variables
%%
%Differential Pressure (deltaP)
P1 = input('Inlet pressure [psi]: ');
P2 = input('Outlet pressure [psi]: ');
deltaP= P1 - P2;
% Density (rhotp)
rhotp = input('Density of the fluid at flowing conditions [lb/ft^3 ,0.044-0.056]: ');
% viscosity (cp)
u= input('Viscosity of fluid [cP, 0.01 - 0.03]: ');
% Note: alpha, Tf and Tr must be in consistent units.
% For the purpose of this standard, Tr is assumed to be 68 F (20 c)
Tr = 68;
Tf = input('Temperature of the fluid at flowing conditions [70 F]: ');

%%
%%Ev
% reference orifice plate bore diameter at Tr
dr= input('Orifice plate bore diameter [in]: ');
Dr= input('Pipe internal diameter [in]: ');
%orrifce plate bore diamater
% linear coefficient of thermal expansion for the orifice plate material
alpha1 = 0.00000925 ;
% linear coefficient of thermal expansion for the meter tube material
alpha2 = 0.00000925 ;

%Orifice diameter calculated at flowing temperature (Tf)
d= dr*(1+alpha1*(Tf - Tr));
%Pipe internal diameter calculated at flowing temperature (Tf)

%meter tube internal diameter calculated at flowing temperature (Tf)
D =Dr*(1+alpha2*(Tf - Tr));
%Diameter ratio (beta)
beta = d/D;
%Velocity of approach factor (Ev)
Ev= 1/sqrt(1-beta^4);


%%
% Expansion Factor (Y)
x1 = deltaP/((P1 + P2 / 2) + deltaP);
Y= 1 - (0.41 + 0.35*beta^4)*(x1/1);
% Unit conversion constant

%% Reynolds number
ReD =4000:1000:36000;
qm=zeros(length(ReD),1);
for i=1:length(ReD)
%%
%%Cd
C=(10^6 / ReD(i))^0.35;
A=((19000*beta)/(ReD(i)))^0.8;
L2=1/D;
L1=L2;
M2=(2*L2)/(1-beta);
M1=2.8-D;
B=(beta^4)/(1 - beta^4);
Dnstrm=-0.0116*(M2-(0.52*M2^1.3))*beta^1.1*(1-(0.14*A));
Upstrm=(0.0433 + 0.0712*exp(-8.5*L1)-0.1145*exp(-6*L1))*(1 - 0.23*A)*B;
TapTerm=Upstrm+Dnstrm;
Cict=0.5961 + (0.0291*(beta^2)) - (0.2290*beta^8) + 0.003*(1 - beta)*M1;
Cift=Cict+TapTerm;
Cd=Cift+(0.000511*((((10^6)*beta)/ReD(i))^0.7))+((0.0210 + 0.0049*A)*(beta^4)*C);
%%
 
% Orifice flow equation
qm(i) = Cd*(pi/4)*Ev*Y*d^2*sqrt(2*rhotp*deltaP);
%Velocity
v(i) = ((qm(i))/rhotp);
end

A=zeros(33,1);
producciondiaria=zeros(33,1);

for i=1:33
%A(i)=v(randperm(33,1));
A(i)=v(1,i);
producciondiaria(i)=A(i)*86400;
end
producciontotal=sum(producciondiaria);

Np=zeros(33,1);
j=0;

for n=1:33
j= j + producciondiaria(n,1);
Np(n,1)= j;
end


subplot(2,2,1);
plot(log(ReD),qm,'-.k*'),title...
 ('Comportamiento del flujo (Qm) con respecto al número de Reynolds(ReD)')...
 ,ylabel('qm [lb/sec]'),xlabel('ReD'),grid minor;

subplot(2,2,2);
plot(v,qm,'k','Linewidth',4),title('Comportamiento del flujo (qm) con respecto a la velocidad(v)')...
   ,ylabel('qm [lbm/sec]'),xlabel('v [ft^3/s]'),grid minor;

subplot(2,2,3);
scatter(1:33,producciondiaria,'filled'),title('Produccion diaria en el mes')...
   ,ylabel('qm [ft^3/d]'),xlabel('dia '),grid minor;
subplot(2,2,4);
nbins = 33;
bar(Np,log(1:33),'r'),title('Produccion acumulada en el mes')...
   ,ylabel('Np[ft^3/d]'),xlabel('dia '),grid minor;





