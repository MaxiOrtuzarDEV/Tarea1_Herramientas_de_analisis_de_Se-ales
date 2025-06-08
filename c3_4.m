% RUIDO, Y(T), AUTOCORRELACION
% ===============================

% Parámetros
fs = 30;                           % Frecuencia de muestreo
t = -3:1/fs:7-1/fs;                % Tiempo desde -3 a 7 segundos

% Señal f1p(t)
f1p = zeros(size(t));
idx1 = t >= -3 & t < 2;
idx2 = t >= 2 & t < 7;
f1p(idx1) = ((t(idx1)+3)/5) .* cos(10*t(idx1));
f1p(idx2) = ((7 - t(idx2))/5) .* cos(10*t(idx2));

% Generar UNA señal de ruido blanco con varianza 1
base_noise = randn(size(t));

% Mostrar solo una gráfica del ruido original
figure;
plot(t, base_noise, 'r')
title('Señal de ruido $n(t)$','Interpreter','latex')
xlabel('Tiempo [s]')
ylabel('Amplitud')
grid on

% Calcular potencia de f1p
P_signal = mean(f1p.^2);

% SNRs deseados
snr_values = [5, 10, 20];

for i = 1:length(snr_values)
    SNR_dB = snr_values(i);
    SNR_linear = 10^(SNR_dB/10);

    % Calcular potencia del ruido deseado y escalar
    P_noise = P_signal / SNR_linear;
    noise = base_noise * sqrt(P_noise);  % Escalar el ruido base

    % Señal ruidosa
    y = f1p + noise;

    % === Graficar y(t) ===
    figure;
    plot(t, y, 'b')
    title(['Señal $y(t) = f_{1p}(t) + n(t)$ con SNR = ', num2str(SNR_dB), ' dB'], 'Interpreter', 'latex')
    xlabel('Tiempo [s]')
    ylabel('Amplitud')
    grid on
    

    if SNR_dB == 5
    ruido_handle = @(tt) interp1(t, noise, tt, 'linear', 0);
    [Rnn, tau_r] = autocorrelacion(ruido_handle, t);
    figure;
    plot(tau_r, Rnn, 'g')
    title('Autocorrelación $R_{n,n}(\tau)$ del ruido (SNR = 5 dB)', 'Interpreter', 'latex')
    xlabel('Desplazamiento $\tau$ [s]', 'Interpreter', 'latex')
    ylabel('$R_{n,n}(\tau)$', 'Interpreter', 'latex')
    grid on
    end
end


