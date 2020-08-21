%Estimacion de las propiedades pseudocriticas de un gas dulce 
%Mediante as correlaciones de Sutton

%rg=0.6992;
%N2=0.0236;
%CO2=0.0164;
%H2S=0.1841;
%H2O=0;

rg=input('Gravedad Especifica : ');
N2=input('Fraccion mol N2 : ');
CO2=input('Fraccion mol CO2 : ');
H2S=input('Fraccion mol H2S : ');
H2O=input('Fraccion mol H2O : ');

%1. Determine la gravedad especifica de los componentes del 
%hidrocarburo de la mezcla con la Ec

rh=(rg - 1.1767*H2S - 1.5196*CO2 - 0.9672*N2 -0.6220 * H2O)/ ...
    (1 - H2O - CO2 - N2 - H2S) ;

Ppch= 756.8 - 131.0 * rh - 3.6 * rh^2 ;
Tpch= 169.2 + 349.5 * rh - 74.0 * rh^2;

Ppc=(1 - H2S - CO2 - N2 - H2O) * Ppch + 1306 * H2S + 1071 * CO2 ...
    + 493.1 * N2 + 3200 * H2O;
Tpc=(1 - H2S - CO2 - N2 - H2O) * Tpch + 672.35 * H2S + 547.58 * CO2 ...
    + 227.16 * N2 + 1164.9 * H2O;

%Error con respecto a metodo de Stewart 
errorP= Ppc * (100 / 770.3768 ) -100 ;
errorT= Tpc * (100 / 397.3008 ) -100;

%Correcciones pseudocriticas por contaminacion de H2S y CO2.
%Para la muestra de gas agrio, corregir Ppc y Tpc por H2S y CO2
%Correlacion de Wicher y Azis. Debido a la composicion conocida
% A partir de Stewart...

Ppctarea1 = 770.3768 ;
Tpctarea1 = 397.3008;

% 2. Correcciones de Wichert y Azis por H2S y CO2
A = H2S + CO2 ;
B = H2S ;

E = 120 * (A^0.9 - A^1.6) + 15 * (B^0.5 - B^4);

%La temperatura pseudocritica corregida por contaminantes
Tpc1 = Tpctarea1 - E ;
Ppc1 = (Ppctarea1 * Tpc1)/(Tpctarea1 + B*(1 - B)*E);


text1='Gravedad especifica de los componentes de la mezcla : %2.3f \n';
fprintf(text1, rh);
text2='Presion pseudocritica H  : %2.3f [psia]\n';
fprintf(text2, Ppch);
text3='Presion pseudocritica H  : %2.3f [R]\n';
fprintf(text3, Tpch);
text4='Presion pseudocritica de la mezcla : %2.3f [psia]\n';
fprintf(text4, Ppc);
text5='Temperatura pseudocritica de la mezcla : %2.3f [R]\n';
fprintf(text5, Tpc);

text6='Temperatura pseudocritica corregida : %2.3f [R]\n';
fprintf(text6, Tpc1);
text7='Presion pseudocritica corregida : %2.3f [psia]\n';
fprintf(text7, Ppc1);



