% Ejemplo de estimacion numeria de la TF de nuestra funcion f(t)

syms t 

% Función por tramos definida en el intervalo [-5, 4]

tramo1 = 2 - 3*t;
tramo2 = (3*t/2) - 4;
tramo3 = 4*t;

ft = tramo1 * (heaviside(t+5) - heaviside(t + 3)) + ...
     tramo2 * (heaviside(t+3) - heaviside(t -2)) + ...
     tramo3 * (heaviside(t-2) - heaviside(t -4));

% Convertir la función simbólica a función numérica
ft_num = matlabFunction(ft);

% definimos
t0 = 0.00001;
delta_w = 1;
k = 1000;

% Ahora necesitamos un vector t que es igual a n*t hasta N-1
% Como esta definida nuestra funcion de -5 a 4 entonces
t_vec = -5:t0:4;

% ahora evaluamos t_vec en f(t) y obtenemos el vector con los valores
% evaluados
tvalues_vec = ft_num(t_vec);

% Ahora usamos nuestra funcion antes definida, que devuelve
% F_omega: vector con la estimación de la TF en las frecuencias ω
% omega: vector de frecuencias
[F_omega, omega] = TFsumRieman(tvalues_vec, t0, delta_w, k);

% Podemos ver los primeros 10 valores del arreglo
disp('Primeros 10 valores de F_omega (módulo y fase):');
for i = 1:10
    fprintf('ω = %.2f -> |F(ω)| = %.4f, ∠F(ω) = %.4f rad\n', ...
        omega(i), abs(F_omega(i)), angle(F_omega(i)));
end

% teniendo esto podemos graficar nuestra Transformada 
% Graficar la Transformada de Fourier (espectro de magnitud)
figure;
plot(omega, abs(F_omega), 'b', 'LineWidth', 1.5);
xlabel('\omega');
ylabel('|F(\omega)|');
title('Transformada de Fourier estimada');
grid on;
