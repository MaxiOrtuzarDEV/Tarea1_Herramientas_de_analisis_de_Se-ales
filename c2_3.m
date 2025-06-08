% ESTIMACION DE SERIE DE FOURIER TRIGONOMETRICA PARA f1p(t)
% ========================================================

% 1. Parametros de la señal
T = 10;              % Periodo
t0 = -3;             % Límite inferior del intervalo
M = 10000;            % Numero de muestras (Riemann)
N = 1000;              % Numero de armonicos

% 2. Discretizacion del intervalo
dt = T / M;
t = linspace(t0, t0+T, M);

% 3. Definicion de la funcion f1p(t)
f1p = zeros(size(t));
for k = 1:length(t)
    tk = mod(t(k) - t0, T) + t0; % Lleva tk a [-3,7)
    if tk >= -3 && tk < 2
        f1p(k) = ((tk + 3)/5) * cos(10 * tk);
    elseif tk >= 2 && tk < 7
        f1p(k) = ((7 - tk)/5) * cos(10 * tk);
    else
        f1p(k) = 0;
    end
end

% 4. Calculo de coeficientes de Fourier
a0 = (2/T) * sum(f1p) * dt;

an = zeros(1,N);
bn = zeros(1,N);
for n = 1:N
    an(n) = (2/T) * sum(f1p .* cos(2*pi*n*t/T)) * dt;
    bn(n) = (2/T) * sum(f1p .* sin(2*pi*n*t/T)) * dt;
end

% 5. Reconstruccion de la señal con N armonicos
f_aprox = a0/2 * ones(size(t));
for n = 1:N
    f_aprox = f_aprox + an(n) * cos(2*pi*n*t/T) + bn(n) * sin(2*pi*n*t/T);
end

% 6. Visualizacion
figure;
plot(t, f1p, 'b', 'DisplayName', 'f_{1p}(t)');
hold on;
plot(t, f_aprox, 'r--', 'DisplayName', ['Aprox. con N = ', num2str(N)]);
legend;
xlabel('t'); ylabel('Amplitud');
title('Serie de Fourier Trigonométrica de f_{1p}(t)');
grid on;