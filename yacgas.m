%Stewart Method
clc
clear all
%Estimacion de las propiedades pseudocriticas con la composicion ...
%de gas definida
MW=input('Peso Molecular del gas [lb/mol]: ');
SG=input('Gravedad Especifica : ');
Ma=28.9625;

%N2=input('Fraccion mol N2 : ');
%CO2=input('Fraccion mol CO2 : ');
%H2S=input('Fraccion mol H2S : ');
%C1=input('Fraccion mol C1 : ');
%C2=input('Fraccion mol C2 : ');
%C3=input('Fraccion mol C3 : ');
%iC4=input('Fraccion mol iC4 : ');
%nC4=input('Fraccion mol nC4 : ');
%iC5=input('Fraccion mol iC5 : ');
%nC5=input('Fraccion mol nC5 : ');
%C6=input('Fraccion mol C6 : ');
%C7=input('Fraccion mol C7+ : ');

N2=0.0236;
CO2=0.0164;
H2S=0.1841;
C1=0.77;
C2=0.0042;
C3=0.00005;
iC4=0.0003;
nC4=0.0003;
iC5=0.0001;
nC5=0.0001;
C6=0.0001;
C7=0.0003;

%Estimar temperatura de ebullicion
Tb=(4.5579*(MW^0.1517)*(SG^0.15427))^3;  

%Calcular la presion pseudocritica de la fraccion C7 
PcC7 = exp(8.3634 - 0.0566/SG - (0.24244 + 2.2898/SG + 0.11857/SG^2) ...
  *Tb/1000 + (1.4685 + 3.648/SG + 0.47227/SG^2) * Tb^2/10^7 ...
   -(0.42019 + 1.6977/SG^2) * Tb^3/10^10);

%Estimacion de la temperatura pseudocritica de la fraccion C7+
TcC7 = (341.7 + 811*SG) + (0.4244+0.1174*SG) * Tb  ...
    + (0.4669 - 3.2623*SG)* 10^5/Tb ;

%Determinar los factores de correcion fj ej y ek
Fj = (1/3) * ((C7 * TcC7) / PcC7) + (2/3) * ((C7^2 * TcC7) / PcC7);

Ej = 0.6081*Fj + 1.1325*Fj^2 - 14.004*Fj*C7 + 64.434*Fj*C7^2;

Ek=(TcC7/sqrt(PcC7)) * (0.3129*C7 - 4.8156*C7^2 + 27.3751*C7^3);

%Obtenga las presiones y temperaturas criticas de los componentes
% Mole fraction yi

%Mi Molecular Weight
MiN2=28.013;
MiCO2=44.010;
MiH2S=34.080;
MiC1=16.043;
MiC2=30.070;
MiC3=44.097;
MiiC4=58.123;
MiiC5=72.150;
MiC6=86.177;
MiC7=MW;

yi=[N2 CO2 H2S C1 C2 C3 iC4 nC4 iC5 nC5 C6 C7];

Mi=[MiN2 MiCO2 MiH2S MiC1 MiC2 MiC3 MiiC4 MiiC4 MiiC5 MiiC5 ... 
    MiC6 MiC7];

Tci = [227.16 547.58 672.35 343 549.59 665.73 734.13 765.29 828.77 ...
    845.47 913.27 TcC7];

Pci = [493.1 1071 1306 666.4 706.5 616 527.9 550.6 490.4 488.6 ...
    436.9 PcC7];

M = sum(yi.*Mi);

a = sum((yi.*Tci)./Pci);

b = sum(yi.*sqrt((Tci./Pci)));

c = sum((yi.*Tci)./sqrt(Pci));

%Obtenga las presiones y temperaturas criticas de los componentes 
% Determinar la Tc y Pc del gas
%A) Calculo de los parametros J y K
J = (1/3)*a + (2/3)*b^2;
K = c ;

% B) Correcion de los parametros J y K
Ji=J-Ej;
Ki=K-Ek;

% C) Calcular presion y temperatura pseudocritica
Tpc=Ki^2/Ji;
Ppc=Tpc/Ji;

% Calcule el peso molecular y gravedad especifica
rg= M/Ma;

text1='Temperatura de ebullicion de la fraccion C7+ : %2.3f [R]\n';
fprintf(text1, Tb);

text2='Presion pseudocritica : %2.3f [psia]\n';
fprintf(text2, Ppc);

text3='Temperatura pseudocritica : %2.3f [R]\n';
fprintf(text3, Tpc);

text4='Peso Molecular : %2.3f [lb/lbmol]\n';
fprintf(text4, M);

text5='Gravedad Especifica : %2.3f \n';
fprintf(text5, rg);