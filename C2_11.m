% COMPLETCION DE TABLA
% ========================================================


% Parámetros
T = 10;
t0 = -3;
M = 10000;
N = 4; % Solo hasta armónico 4 (positivo)
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

% Calculo de F_n, |F_n|^2, ∠F_n y c_n
fprintf('  n       Fn (a+bi)           |Fn|^2       angle(Fn)       an           bn           cn\n');
fprintf('-------------------------------------------------------------------------\n');

% Para n = 0
Fn = a0 / 2;
fprintf('%3d   %10.5f+%10.5fi   %10.5f   %10.5f   %10.5f   %10.5f   %10.5f\n', ...
    0, real(Fn), imag(Fn), abs(Fn)^2, angle(Fn), a0, 0, a0/2);

% Para n = 1 hasta 4 (positivos)
for n = 1:N
    Fn = (an(n) - 1i * bn(n)) / 2;
    cn = Fn;
    fprintf('%3d   %10.5f+%10.5fi   %10.5f   %10.5f   %10.5f   %10.5f   %10.5f\n', ...
        n, real(Fn), imag(Fn), abs(Fn)^2, angle(Fn), an(n), bn(n), abs(cn));
end


