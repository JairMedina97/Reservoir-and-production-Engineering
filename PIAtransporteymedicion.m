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
% linear coefficient of thermal expansion for the orifice plate material
alpha1 = 0.00000925 ;
% linear coefficient of thermal expansion for the meter tube material
alpha2 = 0.00000925 ;
% reference orifice plate bore diameter at Tr
dr= input('Orifice plate bore diameter [in]: ');
%Orifice diameter calculated at flowing temperature (Tf)
d= dr*(1+alpha1*(Tf - Tr));
%Pipe internal diameter calculated at flowing temperature (Tf)
Dr= input('Pipe internal diameter [in]: ');
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
%Nc= input('Unit conversion constant: ');

%% Reynolds number
qm = 100;

%while (n>0.1) ;
%n = (rhotp*qm*D)/u;
%qm = qm - 100;
%error = abs((n1 - n /n))* 100 ;
%n = n1;
%ReD = qm*rhotp*D / u ;
%qm = qm - 10;
%end

ReD = qm*rhotp*D / u;

%%
R = -4:4;
CD = [0.65 0.65 0.65 0.638 0.616 0.601 0.594 .59 0.59];
cs = spline(R,[0 CD 0]);
xx = linspace(-4,4,101);
plot(R,CD,'o',xx,ppval(cs,xx),'-');
%%

if ReD > 4000
   Cd = 0.6;
else
   Cd = 0.5;
end  
% Orifice flow equation
qm = Cd*(pi/4)*Ev*Y*d^2*sqrt(2*rhotp*deltaP);


text1='Resolviendo la ecuacion de flujo resulta en [/s] : %2.3f \n';
fprintf(text1, qm);
%qmkg = qm * 2.2046;
%text1='Resolviendo la ecuacion de flujo resulta en [kg/s] : %2.3f \n';
%fprintf(text1, qmkg);


