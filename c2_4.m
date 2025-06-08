% COMPARACION DE f1p(t) CON APROXIMACIONES DE FOURIER
% ===================================================

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

% Valores de N a analizar
Nvals = [1, 5, 10, 30];

for idx = 1:length(Nvals)
    N = Nvals(idx);

    % Coeficientes de Fourier
    a0 = (2/T) * sum(f1p) * dt;
    an = zeros(1,N);
    bn = zeros(1,N);
    for n = 1:N
        an(n) = (2/T) * sum(f1p .* cos(2*pi*n*t/T)) * dt;
        bn(n) = (2/T) * sum(f1p .* sin(2*pi*n*t/T)) * dt;
    end

    % Reconstrucción
    f_aprox = a0/2 * ones(size(t));
    for n = 1:N
        f_aprox = f_aprox + an(n) * cos(2*pi*n*t/T) + bn(n) * sin(2*pi*n*t/T);
    end

    % Graficar
    figure('Visible', 'off');
    plot(t, f1p, 'b', 'LineWidth', 1.5); hold on;
    plot(t, f_aprox, '--r', 'LineWidth', 1.5);
    title(['Aproximación de f_{1p}(t) con N = ', num2str(N)]);
    xlabel('t'); ylabel('Amplitud');
    legend('f_{1p}(t)', ['Aprox. N = ', num2str(N)], 'Location', 'southwest');
    grid on;

    % Guardar la figura como imagen PNG
    saveas(gcf, ['aproximacion_N', num2str(N), '.png']);
end
