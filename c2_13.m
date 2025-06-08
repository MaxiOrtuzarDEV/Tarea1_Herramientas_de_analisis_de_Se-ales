% Espectro de magnitud de la transformada de Fourier de f1p(t)

% Parámetros
T0 = 10;                 % Periodo fundamental
T = 6 * T0;              % Ventana temporal T = 6T0
w0 = 2 * pi / T0;        % Frecuencia fundamental
w = linspace(-50, 50, 2000); % Rango de frecuencias

% Coeficientes Fn para n = 0 a 4 (datos de la tabla)
Fn = [ ...
    0.00001 + 0.00000i;
    0.00019 - 0.00028i;
   -0.00000 - 0.00001i;
   -0.00046 - 0.00003i;
   -0.00000 + 0.00001i];

N = length(Fn) - 1;  % Máximo armónico n = 4

% Inicialización de F_T(w)
FT = zeros(size(w));

% Cálculo de F_T(w) según la fórmula dada
for n = 0:N
    wn = n * w0;
    Sa_arg = (w - wn) * T / 2;
    
    % Sinc o Sa(x) = sin(x)/x, evitando división por cero
    Sa_val = sin(Sa_arg) ./ (Sa_arg);
    Sa_val(Sa_arg == 0) = 1;

    % Sumar cada término de la serie
    FT = FT + Fn(n+1) .* Sa_val;
end

% Multiplicar por T al final
FT = T * FT;

% Graficar la magnitud
figure;
plot(w, abs(FT), 'LineWidth', 1.5);
xlabel('\omega (rad/s)');
ylabel('|F(\omega)|');
title('Espectro de Magnitud de F(\omega) para f_{1p}(t)');
grid on;
