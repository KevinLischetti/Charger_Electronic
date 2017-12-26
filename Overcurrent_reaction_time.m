close all
%from simulink mutual inductor data extract
H=100*[0 20 40 60 80 100 ];
B=[ 0 0.1410 0.2867 0.4112 0.5146 0.6006 ];

S=360e-6;                 %cross sectionnal area in m²
l=144e-3;                 % Effective length in meter
N1=17;                    %Number of turn

%since B=uH, we will perform a linear regression of B and H
u=[ones(length(H),1) H']\B'
B1=[ones(length(H),1) H']*u;
%We plot the result to check the good correlation and good calculation of u
%by comparing B=f(u,H) from data extract, and B1=uH from linear regression
hold on
plot(H,B); % The extracted data
plot(H,B1'); title('B=uH, the magnetic parmeability extracted with linear regression')%the linear regression
xlabel('Magnetic field strength H (A/m)');ylabel('Magnetic field B (T)')
hold off

%Then L1 can be calculated
L1=N1*N1*u(2)*S/l;

%We define the reste of the circuit:
Ve=374;
R1=0.01266;
L1f=((0.292*17^1.065*360)/144)*1e-6;
M=L1-L1f;
k=M/L1;
Imax=30;
I0=18;

%then
t=-L1/R1*log((30-Ve/R1)/(18-Ve/R1));