% Reemplazo de la función por tramos sin usar syms

% Definir función f(t) de forma numérica con función anónima
ft_num = @(t) (2 - 3*t) .* (t >= -5 & t < -3) + ...
              ((3*t/2) - 4) .* (t >= -3 & t < 2) + ...
              (4*t) .* (t >= 2 & t <= 4);

% Definir parámetros de muestreo
t0 = 0.01;            % paso temporal
delta_w = 0.1;        % paso en frecuencia
k = 100;              % límite de frecuencia

% Vector temporal en el intervalo de definición
t_vec = -5:t0:4;

% Evaluar función en ese intervalo
tvalues_vec = ft_num(t_vec);

% Llamar función para estimar la Transformada de Fourier
[F_omega, omega] = TFsumRieman(tvalues_vec, t0, delta_w, k);

% Estimar energía total usando Parseval (versión numérica)
energia_total = sum(abs(F_omega).^2) * delta_w / (2*pi);
energia_acumulada = cumsum(abs(F_omega).^2) * delta_w / (2*pi);
fraccion_energia = energia_acumulada / energia_total;

% Buscar índices para 50% y 90%
idx_50 = find(fraccion_energia >= 0.5, 1, 'first');
idx_90 = find(fraccion_energia >= 0.9, 1, 'first');

% Rangos asociados
rango_50 = [-omega(idx_50), omega(idx_50)];
rango_90 = [-omega(idx_90), omega(idx_90)];

% Mostrar tabla
fprintf('\nRangos de frecuencia donde se acumula la energía:\n');
fprintf('--------------------------------------------------\n');
fprintf('| Porcentaje |     ω_min     |     ω_max     |\n');
fprintf('--------------------------------------------------\n');
fprintf('|    50%%     |  %10.4f |  %10.4f |\n', rango_50(1), rango_50(2));
fprintf('|    90%%     |  %10.4f |  %10.4f |\n', rango_90(1), rango_90(2));
fprintf('--------------------------------------------------\n');

% Gráfico
figure;
plot(omega, fraccion_energia, 'LineWidth', 1.5);
xlabel('\omega');
ylabel('Fracción de energía acumulada');
title('Energía acumulada vs frecuencia');
grid on;
