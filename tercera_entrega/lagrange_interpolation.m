function lagrange_interpolation()
    % OBJETIVO: Implementar la interpolación por el método de Lagrange.

    fprintf('\n--- ALGORITMO DE LAGRANGE ---\n');
    x = input('Ingrese vector x: ');
    y = input('Ingrese vector y: ');
    n = length(x);

    % Definición de la función de Lagrange
    L_eval = @(t) 0;
    for i = 1:n
        Li = @(t) 1;
        for j = 1:n
            if i ~= j
                old_Li = Li;
                Li = @(t) old_Li(t) .* (t - x(j)) / (x(i) - x(j));
            end
        end
        old_L = L_eval;
        L_eval = @(t) old_L(t) + y(i) * Li(t);
    end

    % --- Sección de Estimación ---
    x_min = min(x);
    x_max = max(x);
    fprintf('\nRango de x: [%.2f, %.2f]\n', x_min, x_max);

    while true
        val_est = input('Ingrese el valor a estimar: ');
        if val_est >= x_min && val_est <= x_max
            resultado = L_eval(val_est);
            fprintf('El valor estimado (Lagrange) en x = %.4f es y = %.6f\n', val_est, resultado);
            break;
        else
            fprintf('Error: El valor debe estar dentro del rango de los datos ingresados.\n');
        end
    end

    % Preparación de gráfica
    t_plot = linspace(x_min, x_max, 100);
    y_plot = arrayfun(L_eval, t_plot);

    figure;
    plot(x, y, 'ko', 'MarkerSize', 8, 'LineWidth', 2); hold on;
    plot(t_plot, y_plot, 'm-', 'LineWidth', 1.5);
    plot(val_est, resultado, 'bs', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
    title('Interpolación de Lagrange');
    xlabel('x'); ylabel('y');
    legend('Datos Originales', 'Polinomio Lagrange', 'Punto Estimado');
    grid on;
    hold off;
end
