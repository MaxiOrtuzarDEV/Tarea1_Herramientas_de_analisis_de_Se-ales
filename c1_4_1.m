% GRAFICAR ESPECTRO DE MAGNITUD
figure;
plot(omega, abs(F_omega).^2, 'b', 'LineWidth', 1.5);
xlabel('\omega (rad/s)');
ylabel('|F(\omega)|^2');
title('Espectro de Magnitud (|F(\omega)|^2)');
grid on;

% GRAFICAR ESPECTRO DE MAGNITUD EN dB
figure;
plot(omega, 10*log10(abs(F_omega).^2 + eps), 'r', 'LineWidth', 1.5);  % +eps para evitar log(0)
xlabel('\omega (rad/s)');
ylabel('|F(\omega)|^2 [dB]');
title('Espectro de Magnitud en Decibeles (|F(\omega)|^2)');
grid on;


% GRAFICAR ESPECTRO DE FASE
figure;
plot(omega, angle(F_omega), 'g', 'LineWidth', 1.5);
xlabel('\omega');
ylabel('\angleF(\omega) [rad]');
title('Espectro de Fase');
grid on;
