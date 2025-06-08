%SEÑAL PERIODICA

syms t  

% Tramo 1: Parte creciente de la función (-3 ≤ t < 2)
tramo1 = ((t+3)/5) * cos(10*t) * (heaviside(t+3) - heaviside(t-2));
% Tramo 2: Parte decreciente de la función (2 ≤ t < 7)
tramo2 = ((7-t)/5) * cos(10*t) * (heaviside(t-2) - heaviside(t-7));

% Combinamos ambos tramos y ajustamos la amplitud
ft = 2*(tramo1 + tramo2);

% Convertimos la expresión simbólica a una función que MATLAB puede evaluar
ft = matlabFunction(ft); 

% Esto hace que la señal se repita cada 10 unidades 
tp = mod(t + 3, 10) - 3;  % Mágica línea que hace la periodicidad

% Creamos la versión periódica evaluando la función base en tp
ftp = ft(tp);  

% Graficamos desde t=-3 hasta t=47 (3 períodos de 10 unidades)
fplot(ftp, [-3, 47], 'b', 'LineWidth', 2);
xlabel('Tiempo (t)'); 
ylabel('Amplitud f(t)');
title('Señal periódica tipo triangular con modulación cosenoidal');
grid on;


