function newton_interpolation()
    % OBJETIVO: Calcular y graficar el polinomio de Newton usando diferencias divididas.
    % También permite estimar un valor específico dentro del rango de datos.
    % PARÁMETROS:
    % x, y: Vectores de datos.
    % D: Matriz de diferencias divididas.

    fprintf('\n--- ALGORITMO DE NEWTON ---\n');
    x = input('Ingrese vector x: ');
    y = input('Ingrese vector y: ');
    n = length(x);
    D = zeros(n, n);
    D(:,1) = y';

    % Generación de la tabla de diferencias divididas
    for j = 2:n
        for i = 1:n-j+1
            D(i,j) = (D(i+1,j-1) - D(i,j-1)) / (x(i+j-1) - x(i));
        end
    end

    fprintf('Tabla de Diferencias Divididas calculada exitosamente.\n');

    % Construcción de la función del polinomio
    poly_newton = @(t) D(1,1);
    for i = 2:n
        term = @(t) D(1,i);
        for j = 1:i-1
            old_term = term;
            term = @(t) old_term(t) .* (t - x(j));
        end
        old_p = poly_newton;
        poly_newton = @(t) old_p(t) + term(t);
    end

    % --- Sección de Estimación ---
    x_min = min(x);
    x_max = max(x);
    fprintf('\nRango de x: [%.2f, %.2f]\n', x_min, x_max);

    while true
        val_est = input('Ingrese el valor a estimar: ');
        if val_est >= x_min && val_est <= x_max
            resultado = poly_newton(val_est);
            fprintf('El valor estimado en x = %.4f es y = %.6f\n', val_est, resultado);
            break;
        else
            fprintf('Error: El valor debe estar dentro del rango [%.2f, %.2f] para garantizar precisión.\n', x_min, x_max);
        end
    end

    % Preparación de gráfica
    t_plot = linspace(x_min, x_max, 100);
    y_plot = arrayfun(poly_newton, t_plot);

    figure;
    plot(x, y, 'ro', 'MarkerSize', 8, 'LineWidth', 2); hold on;
    plot(t_plot, y_plot, 'b-', 'LineWidth', 1.5);
    plot(val_est, resultado, 'gs', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
    title('Interpolación de Newton');
    xlabel('x'); ylabel('y');
    legend('Datos Originales', 'Polinomio', 'Punto Estimado');
    grid on;
    hold off;
end
