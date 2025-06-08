% DEFINICION DE f1p(t)
f1p = @(t) ((t >= -3) & (t < 2)) .* ((t + 3)/5 .* cos(10*t)) + ...
           ((t >= 2)  & (t < 7)) .* ((7 - t)/5 .* cos(10*t));

% PARAMETROS
T = 10;
M = 100;
t_vals = linspace(-T/2, T/2, M);

% LLAMADA A LA RUTINA DE AUTOCORRELACION
[R_tau, tau_vals] = autocorrelacion(f1p, t_vals);

% GRAFICAR RESULTADO
figure;
plot(tau_vals, R_tau, 'LineWidth', 1.5);
xlabel('\tau');
ylabel('R_{f1p}(\tau)');
title('Autocorrelación de f_{1p}(t)');
grid on;
