% CONVOLUCION NUMERICA ENTRE f(t) Y f_{3-(2)}(t)
% ===============================================

% 1. Definicion del dominio temporal
t = linspace(-10, 20, 30);
dt = t(2) - t(1);
tau = -max(t):dt:max(t);

% 2. Definicion de f(t)
f = zeros(size(t));
f(t > -5 & t <= -3) = 2 - 3*t(t > -5 & t <= -3);
f(t > -3 & t <= 2)  = 1.5*t(t > -3 & t <= 2) - 4;
f(t > 2  & t <= 4)  = 4*t(t > 2  & t <= 4);

% 3. Definicion de f_{3-(2)}(t)
f32 = zeros(size(t));
f32(t > 0.5  & t <= 5.5) = t(t > 0.5 & t <= 5.5)/5 + 29/10;
f32(t > 5.5  & t <= 7.5) = -t(t > 5.5 & t <= 7.5)/2 + 27/4;
f32(t > 7.5  & t <= 9)   = -4*t(t > 7.5 & t <= 9)/3 + 10;
f32(t > 9    & t <= 9.5) = 4*t(t > 9   & t <= 9.5) - 38;

% 4. Calculo de la convolucion via sumas de Riemann
conv_result = zeros(size(tau));
for k = 1:length(tau)
    shifted_f32 = interp1(t, f32, t - tau(k), 'linear', 0); % f_{3-(2)}(t - tau)
    conv_result(k) = sum(f .* shifted_f32) * dt;
end

% 5. Graficar resultado
figure;
plot(tau, conv_result, 'LineWidth', 1.5);
xlabel('\tau');
ylabel('(f * f_{3-(2)})(\tau)');
title('Convolución de f(t) y f_{3-(2)}(t) usando sumas de Riemann');
grid on;
