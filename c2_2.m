% Parámetros
w = linspace(-30, 30, 10000); % Rango de frecuencias con alta resolución
dw = w(2) - w(1); % Paso en frecuencia
A = 5; a = 2.5; w0 = 10; % Constantes de la transformada

% Definir F(w)
Fw = A * ( (sinc(a*(w - w0)/pi).^2 .* exp(-1j*2*(w - w0)) + ...
            sinc(a*(w + w0)/pi).^2 .* exp(-1j*2*(w + w0)) ) );

% Cálculo numérico (Riemann)
P_num = sum(abs(Fw).^2) * dw / (2*pi); % Potencia total
V_medio_num = sum(Fw) * dw / (2*pi); % Valor medio (debería ser ~0)

% Cálculo analítico (usando Parseval)
% Para Sa²(2.5(w±10)), la integral de |Sa(x)|^4 es conocida:
P_analitica = 2 * (A^2/(2*pi)) * (pi/(2*a)) * (2/3); % Factor 2 por simetría
V_medio_analitico = 0; % Por simetría impar de los términos

% Resultados
disp(['Potencia (numérica): ', num2str(P_num)]);
disp(['Potencia (analítica): ', num2str(P_analitica)]);
disp(['Valor medio (numérico): ', num2str(V_medio_num)]);
disp(['Valor medio (analítico): ', num2str(V_medio_analitico)]);

% Gráfica
figure;
subplot(2,1,1);
plot(w, abs(Fw), 'b', 'LineWidth', 1.5);
title('Espectro de Magnitud |F(\omega)|');
xlabel('\omega (rad/s)'); ylabel('|F(\omega)|'); grid on;

subplot(2,1,2);
plot(w, angle(Fw), 'r', 'LineWidth', 1.5);
title('Espectro de Fase \angle F(\omega)');
xlabel('\omega (rad/s)'); ylabel('Fase (rad)'); grid on;