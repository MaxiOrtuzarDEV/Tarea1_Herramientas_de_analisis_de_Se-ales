% Cálculo de potencia media y comparación con teorema de Parseval

y = = zeros(size(t));
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

% Potencia en el dominio del tiempo (suma de Riemann)
Pt = (1/T) * sum(y.^2) * dt;

% Número máximo de armónicos para evaluar potencia
Np = 30;
Pp = zeros(1, Np);

% Cálculo de potencia por Parseval truncada
for N_iter = 1:Np
    Pp(N_iter) = (a0^2)/4 + 0.5 * sum(an(1:N_iter).^2 + bn(1:N_iter).^2);
end

% Potencia con 5 armónicos
Pp_5 = (a0^2)/4 + 0.5 * sum(an(1:5).^2 + bn(1:5).^2);

% Gráfica comparativa
figure;
plot(1:Np, Pp, 'b-', 'LineWidth', 2); hold on;
yline(Pt, 'r--', 'LineWidth', 2);
scatter(5, Pp_5, 100, 'ko', 'filled');
legend('Potencia Parseval vs N', 'Potencia dominio tiempo', 'Potencia N=5');
xlabel('Número de armónicos N');
ylabel('Potencia media');
title('Comparación de potencia media mediante Parseval y dominio tiempo');
grid on