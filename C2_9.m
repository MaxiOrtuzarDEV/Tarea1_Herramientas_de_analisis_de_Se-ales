% POTENCIA MEDIA DE f1p(t) POR MÉTODO DIRECTO VS PARSEVAL
% ========================================================

% 1. Parámetros
T = 10;
t0 = -3;
M = 10000; % muestras
dt = T / M;
t = linspace(t0, t0 + T, M);

% 2. Definición de la función f1p(t)
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

% 3. Potencia media directa (integral clásica por sumas de Riemann)
P_directa = (1 / T) * sum(f1p.^2) * dt;

% 4. Cálculo de Parseval para varios valores de N
Nmax = 100;
a0 = (2/T) * sum(f1p) * dt;

an = zeros(1, Nmax);
bn = zeros(1, Nmax);
P_parseval = zeros(1, Nmax);

for n = 1:Nmax
    an(n) = (2/T) * sum(f1p .* cos(2*pi*n*t/T)) * dt;
    bn(n) = (2/T) * sum(f1p .* sin(2*pi*n*t/T)) * dt;
    
    if n == 1
        P_parseval(n) = a0^2/4 + 0.5*(an(n)^2 + bn(n)^2);
    else
        P_parseval(n) = P_parseval(n-1) + 0.5*(an(n)^2 + bn(n)^2);
    end
end

% 5. Gráfico de comparación
figure;
plot(1:Nmax, P_parseval, 'r', 'LineWidth', 1.5); hold on;
yline(P_directa, 'b--', 'LineWidth', 1.5);
legend('Parseval (estimado)', 'Potencia directa (clásica)', 'Location', 'southeast');
xlabel('Número de armónicos N');
ylabel('Potencia media estimada');
title('Comparación de potencia media: método directo vs Parseval');
grid on;

% Guardar figura para LaTeX
saveas(gcf, 'potencia_vs_N.png');
