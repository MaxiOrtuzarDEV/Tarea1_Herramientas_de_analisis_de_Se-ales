% ESPECTRO DE FASE DE LA SERIE DE FOURIER
% =======================================

clear; close all; clc;

T = 10;               % Periodo
t0 = -3;              % Límite inferior del intervalo
M = 1000;             % Puntos para Riemann
dt = T / M;
t = linspace(t0, t0+T, M); % Tiempo

% Funcion f1p(t)
f1p = zeros(size(t));
for k = 1:length(t)
    tk = mod(t(k) - t0, T) + t0;
    if tk >= -3 && tk < 2
        f1p(k) = ((tk + 3)/5) * cos(10 * tk);
    elseif tk >= 2 && tk < 7
        f1p(k) = ((7 - tk)/5) * cos(10 * tk);
    else
        f1p(k) = 0;
    end
end

% Calculo de coeficientes para N = 10
N = 10;
an = zeros(1,N);
bn = zeros(1,N);
fase = zeros(1,N);

for n = 1:N
    an(n) = (2/T) * sum(f1p .* cos(2*pi*n*t/T)) * dt;
    bn(n) = (2/T) * sum(f1p .* sin(2*pi*n*t/T)) * dt;
    fase(n) = atan2(-bn(n), an(n)); % Fase en radianes
end

% Graficar espectro de fase
n = 1:N;
figure;
stem(n, fase, 'filled', 'LineWidth', 1.5);
xlabel('n');
ylabel('Fase [rad]');
title('Espectro de fase de la Serie de Fourier de f_{1p}(t), N = 10');
grid on;

% Guardar imagen para incluir en LaTeX
saveas(gcf, 'espectro_fase_N10.png');
