% CALCULO DE N PARA ALCANZAR EL 90% DE LA POTENCIA
% ================================================

% Reutiliza f1p, T, t, dt, etc. del código anterior

% Potencia directa clásica (ya calculada antes)
P_directa = (1 / T) * sum(f1p.^2) * dt;

% Calcular a0, an, bn (ya hecho antes)
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

% Encontrar el mínimo N para alcanzar el 90% de la potencia
porcentaje = P_parseval / P_directa;
N_90 = find(porcentaje >= 0.90, 1);

fprintf('Se necesitan al menos N = %d armónicos para alcanzar el 90%% de la potencia.\n', N_90);

% Gráfico de convergencia porcentual
figure;
plot(1:Nmax, porcentaje*100, 'm', 'LineWidth', 1.5); hold on;
yline(90, 'k--', 'LineWidth', 1.2);
xline(N_90, 'r--', 'LineWidth', 1.2);
xlabel('Número de armónicos N');
ylabel('Potencia acumulada (%)');
title('Convergencia de la potencia acumulada con N armónicos');
legend('Potencia acumulada', '90%', ['N = ', num2str(N_90)]);
grid on;

% Guardar figura para LaTeX
saveas(gcf, 'potencia_90.png');
