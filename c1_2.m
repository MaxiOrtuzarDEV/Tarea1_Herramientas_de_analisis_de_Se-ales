syms t 

% Función por tramos definida en el intervalo [-5, 4]

tramo1 = 2 - 3*t;
tramo2 = (3*t/2) - 4;
tramo3 = 4*t;

ft = tramo1 * (heaviside(t+5) - heaviside(t + 3)) + ...
     tramo2 * (heaviside(t+3) - heaviside(t -2)) + ...
     tramo3 * (heaviside(t-2) - heaviside(t -4));

f_num = matlabFunction(ft); % Para poder trabajar con nuestra funcion como queremos 
%la transformamos a una MatlabFunction. 

t0 = 0.01; % Paso de muestreo
nt0_vec = -5:t0:4; % Vector que contiene los pasos. 
%Este vector lo definimos donde este definida nuestra funcion 
% con pasos de tamaño t0.
% Esto genera un total de N-1 = (4 - (-5))/0.01 = 900 muestras.

t_vals = f_num(nt0_vec); % Un vector con los pasos evaluados en la funcion

Eaprox = sum(abs(t_vals).^2 * t0);  
% Aproximación de la energía mediante sumas de Riemann
% Se calcula sumando el cuadrado del valor absoluto de cada muestra,
% multiplicado por el tamaño del paso t0.


Eint = 9995/12;  % Valor exacto de la energía calculado mediante integración


% Comparación de resultados
fprintf('Energía aproximada mediante sumas de Rieman %.4f\n', Eaprox);
fprintf('Error relativo: %.4f%%\n', abs(Eint - Eaprox)/Eaprox * 100);

% Comentario adicional:
% El resultado de la aproximación con pasos de t0 = 0.01 es Eaprox = 832.6651,
% comparado con el resultado analítico Eint = 832.9167.
% El error relativo es de aproximadamente 0.0302%, lo que indica que 
% la aproximación es bastante precisa. 
% Reduciendo el valor de t0, la estimación se acerca aún más al valor exacto:

% t0 = 0.1       -> Energía aprox: 807.8625   Error relativo: 3.1013%
% t0 = 0.01      -> Energía aprox: 832.6651   Error relativo: 0.0302%
% t0 = 0.00001   -> Energía aprox: 832.9168   Error relativo: 0.00001336%
% t0 = 0.0000001 -> Energía aprox: 832.9166   Error relativo: 0.00000302%