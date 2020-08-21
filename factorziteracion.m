%Dranchuk and Abou-Kassem equation of state 
%Calculating Gas Z factor
clc
clear all
z = 1; Ppc = 667.8624; Tpc = 358.5966;
P=input('Presion [psia]: ');
T=input('Temperatura [F]: ');
Pr = P / Ppc ;Tr = (T + 460) / Tpc ;
rhor = (0.27 * Pr) / (z * Tr);
A1 = 0.3265; A2 = -1.0700;
A3 = -0.5339; A4 = 0.01569;
A5 = -0.05165; A6 = 0.5475;
A7 = -0.7361; A8 = 0.1844;
A9 = 0.1056; A10 = 0.6134;
A11 = 0.721;
C1 = A1 + A2/Tr + A3/Tr^3 + A4/Tr^4 + A5/Tr^5;
C2 = A6 + A7/Tr + A8/Tr^2;
C3 = A9 * (A7/Tr + A8/Tr^2);
C4 = A10 * (1 + A11 * rhor ^2) * (rhor^2 / Tr^3) ...
    * exp(-A11 * rhor^2);
f = 1;
while (f>0.0001) ; 
f = z-(1 + C1*rhor + C2*rhor^2 - C3*rhor^5 + ...
    C4);
z = z - 0.0001;
end
f = z-(1 + C1*rhor + C2*rhor^2 - C3*rhor^5 + ...
    C4);    
text1='Presion reducida  : %2.3f [psia]\n';
fprintf(text1, Pr);
text2='Temperatura reducida  : %2.3f [psia]\n';
fprintf(text2, Tr);
text3='Función objetivo : %2.3f \n';
fprintf(text3, f);
text4='Resolviendo la EDE de Dranchouk y Abou - Kassem : %2.3f \n';
fprintf(text4, z);


