function [R_tau, tau_vals] = autocorrelacion(f_handle, t_vals)
% AUTOCORRELACION_RIEMANN Calcula la autocorrelación mediante sumas de Riemann
%
% Entradas:
%   f_handle : handle a la función f(t), por ejemplo: @(t) ...
%   t_vals   : vector de tiempo sobre el cual evaluar f(t)
%
% Salidas:
%   R_tau    : vector de autocorrelación Rf(tau)
%   tau_vals : valores de desplazamiento tau

    dt = t_vals(2) - t_vals(1);         % Paso de tiempo
    tau_vals = -max(t_vals):dt:max(t_vals);  % Rango de tau
    R_tau = zeros(size(tau_vals));     % Inicialización

    for i = 1:length(tau_vals)
        tau = tau_vals(i);
        t_shifted = t_vals + tau;
        f_t = f_handle(t_vals);
        f_tau = f_handle(t_shifted);
        R_tau(i) = sum(f_t .* f_tau) * dt;  % Suma de Riemann
    end
end
