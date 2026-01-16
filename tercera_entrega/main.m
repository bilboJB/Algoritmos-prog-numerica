%% PROGRAMA INTEGRAL DE MÉTODOS NUMÉRICOS

clear; clc; close all;

while true
    fprintf('\n========================================\n');
    fprintf('   SISTEMA DE MÉTODOS NUMÉRICOS\n');
    fprintf('========================================\n');
    fprintf('1. Interpolación de Newton\n');
    fprintf('2. Interpolación de Lagrange\n');
    fprintf('3. Regla del Trapecio (Simple/Múltiple)\n');
    fprintf('4. Reglas de Simpson (1/3, 3/8, Mixta)\n');
    fprintf('5. Salir\n');
    fprintf('========================================\n');

    op = input('Seleccione una opción: ');

    switch op
        case 1
            newton_interpolation();
        case 2
            lagrange_interpolation();
        case 3
            trapezoidal_rule();
        case 4
            simpson_rules();
        case 5
            fprintf('Saliendo del programa...\n');
            break;
        otherwise
            fprintf('Opción no válida.\n');
    end
end

% Función auxiliar para graficar común a los métodos de interpolación
function graficar_datos(x, y, func, titulo)
    t_plot = linspace(min(x), max(x), 100);
    y_plot = arrayfun(func, t_plot);

    figure('Name', titulo);
    plot(x, y, 'ro', 'MarkerSize', 8, 'LineWidth', 2); hold on;
    plot(t_plot, y_plot, 'b-', 'LineWidth', 1.5);
    grid on;
    title(['Interpolación Polinomial: ', titulo]);
    xlabel('Eje X'); ylabel('Eje Y');
    legend('Puntos (Datos)', 'Polinomio Resultante');
    hold off;
end
