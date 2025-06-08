clc;
clear;

% Tiempo
t = -6:0.01:5;
f = zeros(size(t));  % Inicializar f(t)

% Definir f(t) por tramos
f1 = (t > -5) & (t <= -3);
f2 = (t > -3) & (t <= 2);
f3 = (t > 2) & (t <= 4);

f(f1) = 2 - 3*t(f1);
f(f2) = (3/2)*t(f2) - 4;
f(f3) = 4*t(f3);

% Derivada por tramos
df = zeros(size(t));
df(f1) = -3;
df(f2) = 3/2;
df(f3) = 4;

% Crear figura
figure; hold on;

% Graficar f(t) en azul
plot(t, f, 'b', 'LineWidth', 2);

% Graficar f'(t) en negro punteado
plot(t, df, 'k--', 'LineWidth', 2);

% Impulsos (Dirac) representados con flechas verdes
% Posiciones y sentidos
impulse_pos = [-5, -3, 2, 4];
impulse_dir = [1, -1, 1, -1];
arrow_length = 3;

% Dibujar impulsos como flechas verdes (usando quiver)
for i = 1:length(impulse_pos)
    x = impulse_pos(i);
    y = 0;
    dy = impulse_dir(i) * arrow_length;
    
    % Dibujar flecha vertical en (x,0) con dirección dy
    quiver(x, y, 0, dy, 0, 'Color', 'g', 'LineWidth', 2, 'MaxHeadSize', 0.8)
end


% Estética
xlabel('t');
ylabel('Amplitud');
title('f(t) y su derivada f''(t) con impulsos Dirac en puntos clave');
legend('f(t)', 'f''(t)', 'Impulsos Dirac', 'Location', 'northwest');
grid on;
ylim([-10 18]);
xlim([-6 5]);
