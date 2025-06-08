%c1_3_1

function [F_omega, omega] = TFsumRieman(f_t, t0, delta_omega, K)
% FOURIER_TRANSFORM_RIEMANN Estima la Transformada de Fourier usando sumas de Riemann

% Parámetros de entrada:
%   f_t: vector con muestras de la función en el dominio del tiempo [f(0), f(nt0), f(n+1t0), ..., f((N-1)t0)]
%   t0: intervalo de muestreo
%   delta_omega: resolución en frecuencia 
%   K: número de intervalos de frecuencia positivos/negativos

% Parámetros de salida:
%   F_omega: vector con la estimación de la TF en las frecuencias ω
%   omega: vector de frecuencias

N = length(f_t);          % Número de muestras en el tiempo
n = 0:(N-1);              % Índices temporales [0, 1, 2, ..., N-1]

% Crear el vector de frecuencias ω
k_val = -K:K;
omega = k_val * delta_omega;

% Inicializar el vector para la Transformada de Fourier
F_omega = zeros(1, length(omega)) * 0i;  % Inicialización compleja

% Calcular la suma de Riemann para cada frecuencia
for idx = 1:length(k_val)
    k = k_val(idx);
    % Exponente complejo para la frecuencia actual
    exponent = -1i * k * delta_omega * n * t0;
    % Sumatoria de Riemann
    F_omega(idx) = sum(f_t .* exp(exponent)) * t0;
end

end

%Comentario Adicional:
% Este código calcula numéricamente la Transformada de Fourier (TF) de una señal 
% aproximando la integral continua mediante sumas de Riemann.
        
% FUNCIONAMIENTO:
%   1. Para cada frecuencia ω_k = kΔω (k = -K, ..., K):
%      a) Se evalúa la exponencial compleja e^(-jω_k t) en todos los tiempos t = nΔt.
%      b) Se multiplica cada muestra f(nΔt) por la exponencial y por Δt (ancho del rectángulo de Riemann).
%      c) Se suma el resultado para aproximar la integral F(ω_k) ≈ Σ f(t)e^(-jω_k t) Δt.

% Este método es conceptualmente equivalente a la FFT, pero permite elegir frecuencias 
% arbitrarias.
% La FFT es más eficiente, pero esta aproximación ofrece flexibilidad para
% ajustar Δω y K, lo cual en la practica es muy util cuando obtenemos solo
% parametros de las señales.
% Aunque menos eficiente computacionalmente que la FFT, ofrece mayor flexibilidad
% en el análisis espectral cuando solo se requieren ciertos puntos de frecuencia.

