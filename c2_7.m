% ERROR CUADRATICO MEDIO DE LA SERIE DE FOURIER
% =============================================

clear; close all; clc;

T = 10;               % Periodo
t0 = -3;              % Inicio de la señal
M = 1000;             % Número de muestras
dt = T / M;
t = linspace(t0, t0+T, M); % Vector de tiempo
w0 = 2*pi/T;          % Frecuencia fundamental

% Señal original f1p(t)
y = zeros(size(t));
for k = 1:length(t)
    tk = mod(t(k) - t0, T) + t0;
    if tk >= -3 && tk < 2
        y(k) = ((tk + 3)/5) * cos(10 * tk);
    elseif tk >= 2 && tk < 7
        y(k) = ((7 - tk)/5) * cos(10 * tk);
    else
        y(k) = 0;
    end
end

% Error cuadrático medio para diferentes valores de N
Ns = [1 5 10 30];
errores = zeros(size(Ns));

for idx = 1:length(Ns)
    N = Ns(idx);

    % Calcular coeficientes de Fourier
    a0 = (1/T) * sum(y) * dt;
    an = zeros(1,N);
    bn = zeros(1,N);
    for n = 1:N
        an(n) = (2/T) * sum(y .* cos(n * w0 * t)) * dt;
        bn(n) = (2/T) * sum(y .* sin(n * w0 * t)) * dt;
    end

    % Aproximación de la señal con N armónicos
    y_aprox = a0 * ones(size(t));
    for n = 1:N
        y_aprox = y_aprox + an(n)*cos(n*w0*t) + bn(n)*sin(n*w0*t);
    end

    % Calcular el Error cuadrático medio
    errores(idx) = (1/M) * sum((y - y_aprox).^2);
end

% Graficar error en función de N
figure;
stem(Ns, errores, 'filled', 'LineWidth', 1.5);
xlabel('N (número de armónicos)');
ylabel('Error cuadrático medio');
title('Error de aproximación de la Serie de Fourier');
grid on;

% Guardar figura
saveas(gcf, 'error_cuadratico_medio.png');
