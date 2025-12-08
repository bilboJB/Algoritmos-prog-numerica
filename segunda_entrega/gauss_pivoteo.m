function [x, er] = gauss_pivoteo(A, b, tol)
% GAUSS_PIVOTEO Resuelve un sistema de ecuaciones lineales Ax = b usando
% eliminación Gaussiana con pivoteo parcial escalado.
%
% ENTRADAS:
%   A   : Matriz de coeficientes (n x n).
%   b   : Vector de términos independientes (n x 1).
%   tol : Tolerancia para detectar singularidad.
%
% SALIDAS:
%   x   : Vector de solución (n x 1).
%   er  : Código de error (0 si no hay error, -1 si la matriz es singular).
% VARIABLES INTERNAS:
%   n   : Dimensión de la matriz A.
%   s   : Vector de escala para el pivoteo parcial.
% ========================================

    [n, m] = size(A);
    if n ~= m
        error('La matriz A debe ser cuadrada.');
    end

    % Inicializar vector de solución y error
    x = zeros(n, 1);
    er = 0;

    % --- Calcular el vector de escala 's' ---
    s = zeros(n, 1);
    for i = 1:n
        s(i) = max(abs(A(i, :)));
    end

    % --- Fase de Eliminación ---
    [A, b, s, er] = eliminar(A, s, n, b, tol);

    % --- Fase de Sustitución ---
    if er ~= -1
        x = sustituir(A, n, b);
    else
        % Si hay error, la solución no es válida
        x = NaN(n, 1);
        disp('La matriz es singular. No se puede encontrar una solución única.');
    end
end

% -----------------------------------------------------------------
% SUBRUTINA PARA LA ELIMINACIÓN HACIA ADELANTE
% -----------------------------------------------------------------
function [A, b, s, er] = eliminar(A, s, n, b, tol)
    er = 0;

    % El proceso de eliminación se realiza desde la columna 1 hasta la n-1
    for k = 1:(n - 1)
        % --- Pivotear ---
        [A, b, s] = pivotear(A, b, s, n, k);

        % --- Comprobar singularidad ---
        if abs(A(k, k) / s(k)) < tol
            er = -1;
            return; % Salir de la función si es singular
        end

        % --- Eliminación ---
        for i = (k + 1):n
            factor = A(i, k) / A(k, k);
            % Actualizar la fila en la matriz A
            A(i, (k + 1):n) = A(i, (k + 1):n) - factor * A(k, (k + 1):n);
            % Actualizar el vector b
            b(i) = b(i) - factor * b(k);
        end
    end

    % --- Comprobar singularidad para el último elemento de la diagonal ---
    if abs(A(n, n) / s(n)) < tol
        er = -1;
    end
end

% -----------------------------------------------------------------
% SUBRUTINA PARA EL PIVOTEO PARCIAL ESCALADO
% -----------------------------------------------------------------
function [A, b, s] = pivotear(A, b, s, n, k)
    p = k;
    big = abs(A(k, k) / s(k));

    for ii = (k + 1):n
        dummy = abs(A(ii, k) / s(ii));
        if dummy > big
            big = dummy;
            p = ii;
        end
    end

    % Si la fila pivote óptima (p) no es la fila actual (k), se intercambian.
    if p ~= k
        % Intercambiar filas en A
        temp_row_A = A(p, :);
        A(p, :) = A(k, :);
        A(k, :) = temp_row_A;

        % Intercambiar elementos en b
        temp_b = b(p);
        b(p) = b(k);
        b(k) = temp_b;

        % Intercambiar elementos en s
        temp_s = s(p);
        s(p) = s(k);
        s(k) = temp_s;
    end
end

% -----------------------------------------------------------------
% SUBRUTINA PARA LA SUSTITUCIÓN HACIA ATRÁS
% -----------------------------------------------------------------
function x = sustituir(A, n, b)
    x = zeros(n, 1);

    % 1. Calcular x(n) (la última componente)
    x(n) = b(n) / A(n, n);

    % 2. Calcular x(n-1) hasta x(1)
    for i = (n - 1):-1:1
        sum = A(i, (i + 1):n) * x((i + 1):n);
        x(i) = (b(i) - sum) / A(i, i);
    end
end
