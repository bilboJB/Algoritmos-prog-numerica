% === LEYENDA DE PARÁMETROS Y VARIABLES ===
%
% PARÁMETROS DE ENTRADA:
% A       : Matriz de coeficientes (debe ser cuadrada).
% b       : Vector de términos independientes.
% x0      : Vector de la aproximación inicial (punto de inicio).
% tol     : Tolerancia (criterio de parada).
% maxIter : Número máximo de iteraciones permitidas (criterio de parada).
%
% VARIABLES DE SALIDA:
% x           : Vector solución aproximada final.
% iter        : Número de iteraciones realizadas.
% error_final : Error relativo alcanzado en la última iteración.
%
% VARIABLES INTERNAS:
% n             : Dimensión de la matriz A (número de ecuaciones).
% x_old         : Vector de la aproximación de la iteración anterior.
% error_relativo: Error relativo actual (norma infinita de la diferencia de las aproximaciones dividido por la norma infinita de x).
% error_abs_num : Numerador del error relativo (Diferencia absoluta entre x y x_old).
% norma_x       : Denominador del error relativo (Norma infinita de x).
%
% ========================================

function [x, iter, error_final] = gauss_seidel(A, b, x0, tol, maxIter)

    % === SECCIÓN DE INICIALIZACIÓN Y VERIFICACIÓN ===

    % Obtener las dimensiones de la matriz A
    [n, m] = size(A);

    % Verificar que A sea una matriz cuadrada
    if n ~= m
        error('La matriz de coeficientes A debe ser cuadrada.');
    end

    % Verificar que los vectores b y x0 tengan la dimensión correcta
    if length(b) ~= n || length(x0) ~= n
        error('Los vectores b y x0 deben tener la misma dimensión que la matriz A.');
    end

    % Inicialización de variables de control
    x = x0;         % La solución actual se inicializa con el punto de inicio
    iter = 0;       % Contador de iteraciones
    error_relativo = Inf; % Inicializar el error con un valor grande para entrar al bucle

    % === SECCIÓN DE BUCLE ITERATIVO ===

    while error_relativo > tol && iter < maxIter

        iter = iter + 1;
        x_old = x; % Guardar la aproximación anterior para el cálculo del error

        % === SECCIÓN DE CÁLCULO DE LA NUEVA APROXIMACIÓN (FÓRMULA GS) ===
        % Iterar sobre cada componente (i) del vector solución
        for i = 1:n

            sum_val = 0;

            % Calcular la suma de los términos que ya usan las nuevas aproximaciones (j < i)
            for j = 1:i-1
                sum_val = sum_val + A(i, j) * x(j);
            end

            % Calcular la suma de los términos que usan las aproximaciones anteriores (j > i)
            for j = i+1:n
                sum_val = sum_val + A(i, j) * x_old(j);
            end

            % Verificar si el elemento diagonal es cero
            if A(i, i) == 0
                error('Elemento diagonal A(%d, %d) es cero. El método fallará por división por cero.', i, i);
            end

            % Aplicar la fórmula de actualización de Gauss-Seidel
            x(i) = (b(i) - sum_val) / A(i, i);

        end % Fin del bucle for para las componentes

        % === SECCIÓN DE CÁLCULO DEL ERROR ===
        % Cálculo del error relativo como la norma infinita de la diferencia dividida por la norma infinita de x

        error_abs_num = norm(x - x_old, inf); % Numerador: Diferencia absoluta
        norma_x = norm(x, inf);             % Denominador: Norma infinita de la solución actual

        % Si la norma de la solución actual es cero, se utiliza el error absoluto
        % para evitar la división por cero o un error inflado.
        if norma_x == 0
            error_relativo = error_abs_num;
        else
            error_relativo = error_abs_num / norma_x;
        end

    end % Fin del bucle while

    % === SECCIÓN DE RESULTADOS FINALES ===

    error_final = error_relativo;

    % Generar advertencia si no se alcanzó la tolerancia
    if iter == maxIter && error_final > tol
        warning('El método de Gauss-Seidel no convergió después de %d iteraciones. Error final (Relativo): %e (Tolerancia: %e)', maxIter, error_final, tol);
    end

end % Fin de la función
