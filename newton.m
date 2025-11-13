function [raiz, iteraciones, tiempo_ejecucion] = newton(f, TOL, x0)
% METODO_NEWTON Implementa el algoritmo de Newton-Raphson para encontrar raíces.
%
% ENTRADAS:
%   f   : Función simbólica (ej: sym('x^3 - 2*x - 5'))
%   TOL : Tolerancia para el criterio de parada.
%   x0  : Valor inicial para la iteración.
%
% SALIDAS:
%   raiz       : Valor de la raíz encontrado.
%   iteraciones: Número de iteraciones realizadas.
%   tiempo_ejecucion: Tiempo de ejecución del algoritmo.

    % Iniciar cronómetro
    tic;
    pkg load symbolic;
    % Declarar variable simbólica 'x'
    syms x;

    % Calcular la derivada de la función
    df = diff(f, x);

    % Convertir las funciones simbólicas a funciones anónimas para evaluación numérica rápida
    f_num = matlabFunction(f, 'vars', {x});
    df_num = matlabFunction(df, 'vars', {x});

    % --- Configuración de Parámetros ---
    MAX_ITER = 150;
    x_k = x0;
    error_rel_aprox = Inf;
    iteraciones = 0;

    % Almacenamiento para la evolución gráfica
    puntos_x = [x_k];
    puntos_y = [f_num(x_k)];

    % --- Gráfica Inicial y Dominio ---
    disp(' ');
    fprintf('Ingrese los límites del dominio [a, b] para graficar la función:\n');
    a = input('   Ingrese el límite inferior (a): ');
    b = input('   Ingrese el límite superior (b): ');

    % Mostrar encabezado de la tabla
    disp(' ');
    disp('--- MÉTODO DE NEWTON-RAPHSON ---');
    fprintf('%-8s | %-15s | %-15s | %-15s\n', 'Iteración', 'x_k', 'f(x_k)', 'Error Actual');
    disp(repmat('-', 1, 60));

    figure('Name', 'Evolución del Método de Newton-Raphson');
    fplot(f_num, [a b], 'b-');
    hold on;
    grid on;
    title('Evolución de Newton-Raphson');
    xlabel('x');
    ylabel('f(x)');
    plot(a, 0, 'r.'); % Asegurar que el eje x se vea
    plot(b, 0, 'r.');

    % --- Bucle de Iteración ---
    while iteraciones < MAX_ITER
        % Evaluar la función y su derivada en el punto actual
        fx_k = f_num(x_k);
        dfx_k = df_num(x_k);

        % Verificar si la derivada es cercana a cero (posible problema de convergencia)
        if abs(dfx_k) < eps('single')
            disp('¡ADVERTENCIA! Derivada muy cercana a cero. El método podría divergir.');
            raiz = x_k;
            tiempo_ejecucion = toc;
            return;
        end

        % Calcular el siguiente iterado (x_k+1)
        x_siguiente = x_k - (fx_k / dfx_k);

        % Calcular error relativo aproximado
        if x_siguiente ~= 0
            error_rel_aprox = abs((x_siguiente - x_k) / x_siguiente);
        end

        % Actualizar variables
        x_k = x_siguiente;
        iteraciones = iteraciones + 1;

        % Almacenar para la gráfica
        puntos_x = [puntos_x, x_k];
        puntos_y = [puntos_y, f_num(x_k)];

        % Mostrar fila en la tabla
        fprintf('%-8d | %-15.8f | %-15.8f | %-15.8e\n', iteraciones, x_k, f_num(x_k), error_rel_aprox);

        % Graficar el punto actual
        plot(x_k, f_num(x_k), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 5);

        % Criterio de Parada Combinado
        if error_rel_aprox <= TOL || abs(f_num(x_k)) <= TOL
            break;
        end
    end

    % --- Finalización y Resultados ---
    raiz = x_k;
    tiempo_ejecucion = toc;

    fx_final = f_num(raiz);

    disp(repmat('-', 1, 60));
    fprintf('Algoritmo finalizado en %.4f segundos.\n', tiempo_ejecucion);
    fprintf('Raíz obtenida: x = %.10f\n', raiz);
    fprintf('Evaluación de la función en la raíz: f(x) = %.10e\n', fx_final);

    if error_rel_aprox <= TOL || abs(fx_final) <= TOL
        disp('Criterio de parada: Convergió por alcanzar un error o residuo aceptable (<= TOL).');
    else
        disp('Criterio de parada: Alcanzó el máximo de 150 iteraciones.');
    end

    % Graficar la raíz final con una leyenda clara
    plot(raiz, fx_final, 'gx', 'MarkerSize', 10, 'LineWidth', 2);
    legend('Función f(x)', 'Iterados (x_k, f(x_k))', 'Raíz Obtenida', 'Location', 'SouthEast');
    hold off;

end
