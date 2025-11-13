function [raiz, iteraciones, tiempo_ejecucion] = biseccion(f, TOL, a, b)
% METODO_BISECCION Implementa el algoritmo de Bisección.
%
% ENTRADAS:
%   f   : Función simbólica (ej: sym('x^3 - 2*x - 5'))
%   TOL : Tolerancia para el criterio de parada.
%   a   : Límite inferior del intervalo de búsqueda.
%   b   : Límite superior del intervalo de búsqueda.
%
% SALIDAS:
%   raiz       : Valor de la raíz encontrado.
%   iteraciones: Número de iteraciones realizadas.
%   tiempo_ejecucion: Tiempo de ejecución del algoritmo.

    % Iniciar cronómetro
    tic;
    pkg load symbolic;
    % Declarar variable simbólica 'x' y convertir a función anónima
    syms x;
    f_num = matlabFunction(f, 'vars', {x});

    % --- Configuración de Parámetros ---
    MAX_ITER = 150;
    error_rel_aprox = Inf;
    iteraciones = 0;

    % Verificar condición inicial: f(a) y f(b) deben tener signos opuestos
    fa = f_num(a);
    fb = f_num(b);

    if fa * fb > 0
        error('La función no cambia de signo en el intervalo [a, b]. Escoja un nuevo intervalo.');
    end

    % Inicializar punto medio previo para el cálculo del error
    x_previa = a;

    % Mostrar encabezado de la tabla
    disp(' ');
    disp('--- MÉTODO DE BISECCIÓN ---');
    fprintf('%-8s | %-15s | %-15s | %-15s\n', 'Iteración', 'x_k', 'f(x_k)', 'Error Actual');
    disp(repmat('-', 1, 60));

    % --- Gráfica Inicial ---
    figure('Name', 'Evolución del Método de Bisección');
    fplot(f_num, [a b], 'b-'); % Gráfica inicial en el intervalo de búsqueda
    hold on;
    grid on;
    title('Evolución de la Bisección');
    xlabel('x');
    ylabel('f(x)');

    % --- Bucle de Iteración ---
    while iteraciones < MAX_ITER
        iteraciones = iteraciones + 1;

        % Calcular el punto medio actual
        x_actual = (a + b) / 2;
        fx_actual = f_num(x_actual);

        % Calcular error relativo aproximado
        if x_actual ~= 0
            error_rel_aprox = abs((x_actual - x_previa) / x_actual);
        end

        % Actualizar variables para la próxima iteración
        x_previa = x_actual;

        % Mostrar fila en la tabla
        fprintf('%-8d | %-15.8f | %-15.8f | %-15.8e\n', iteraciones, x_actual, fx_actual, error_rel_aprox);

        % Graficar el punto actual
        plot(x_actual, fx_actual, 'ro', 'MarkerFaceColor', 'r');

        % Criterio de Parada Combinado
        if error_rel_aprox <= TOL || abs(fx_actual) <= TOL
            break;
        end

        % Decidir el nuevo intervalo
        if fa * fx_actual < 0
            % La raíz está en [a, x_actual]
            b = x_actual;
            fb = fx_actual;
        else
            % La raíz está en [x_actual, b]
            a = x_actual;
            fa = fx_actual;
        end
    end

    % --- Finalización y Resultados ---
    raiz = x_actual;
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
