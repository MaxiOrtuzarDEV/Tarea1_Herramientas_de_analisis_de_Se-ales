%% ===========================
%  APROXIMACIÓN DE SERIE DE FOURIER EN PUNTOS ESPECÍFICOS
% ============================

% Parámetros
T = 10;
t0 = -3;
M = 10000;
N = 1000;
dt = T / M;
t = linspace(t0, t0 + T, M);

% Función f1p(t)
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

% Cálculo de coeficientes a_n y b_n
a0 = (2/T) * sum(f1p) * dt;
an = zeros(1,N);
bn = zeros(1,N);
for n = 1:N
    an(n) = (2/T) * sum(f1p .* cos(2*pi*n*t/T)) * dt;
    bn(n) = (2/T) * sum(f1p .* sin(2*pi*n*t/T)) * dt;
end

% Aproximación de la señal para valores enteros de tiempo
t_eval = -T/2 : 1 : T/2;
f_aprox = zeros(size(t_eval));
for k = 1:length(t_eval)
    tk = t_eval(k);
    suma = a0 / 2;
    for n = 1:N
        suma = suma + an(n) * cos(2*pi*n*tk/T) + bn(n) * sin(2*pi*n*tk/T);
    end
    f_aprox(k) = suma;
end


for k = 1:length(t_eval)
    fprintf('%g & %.5f \\\\\n', t_eval(k), f_aprox(k));
end
