% Definir el rango de frecuencias omega
omega = linspace(-10, 10, 1000); % Vector de frecuencias

% Calcular F(w) término por término
term1 = exp(1j * omega*3) .* (2 - 3*pi*delta_approx + 3./(1j*omega));
term2 = exp(1j * omega*3) .* ( (9/2)*pi*delta_approx + 9./(2*1j*omega) - 6 );
term3 = exp(-1j * omega*2) .* ( (5/2)*pi*delta_approx + 5./(2*1j*omega) + 4 );
term4 = exp(-1j * omega*4) .* ( 4*pi*delta_approx + 4./(1j*omega) );

% Sumar todos los términos y multiplicar por jw
Fw = 1j * omega .* (term1 + term2 + term3 - term4);


% [...] (código anterior para calcular Fw)

figure;
plot(omega, abs(Fw), 'b', 'LineWidth', 2); % Parte real
grid on;
title('Parte Real e Imaginaria de F(\omega)');
xlabel('\omega');
ylabel('Amplitud');
legend('Real', 'Imaginaria');
xlim([-10, 10]);