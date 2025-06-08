% Definición de la función f(t) por tramos
f = @(t) (t > -5 & t <= -3) .* (2 - 3*t) + ...
         (t > -3 & t <= 2)  .* (1.5*t - 4) + ...
         (t > 2  & t <= 4)  .* (4*t);

% Intervalo de tiempo y evaluación
t_vals = linspace(-10, 10, 10);

% Cálculo de la autocorrelación
[R_tau, tau_vals] = autocorrelacion(f, t_vals);

% Gráfica del resultado
figure;
plot(tau_vals, R_tau, 'LineWidth', 2);
xlabel('\tau');
ylabel('R_f(\tau)');
title('Autocorrelación de f(t)');
grid on;