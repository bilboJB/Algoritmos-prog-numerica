% SCRIPT PARA PROBAR LA FUNCIÓN gauss_pivoteo
% Este script define un sistema de ecuaciones lineales, lo resuelve usando
% la función gauss_pivoteo y compara el resultado con la solución nativa
% de MATLAB/Octave (usando el operador '\').

clear; clc; close all;

disp('--- PRUEBA DEL MÉTODO DE GAUSS CON PIVOTEO ---');

% --- 1. Definir el sistema de ecuaciones Ax = b ---
% Este es un sistema de ejemplo con una solución conocida: x = [3; -2.5; 7]
A = [3, -0.1, -0.2;
     0.1, 7, -0.3;
     0.3, -0.2, 10];

b = [7.85; -19.3; 71.4];

% Definir una tolerancia pequeña para la detección de singularidad
tol = 1e-9;

fprintf('\nMatriz A:\n');
disp(A);
fprintf('Vector b:\n');
disp(b);

% --- 2. Llamar a la función gauss_pivoteo ---
disp('Resolviendo con gauss_pivoteo...');
[x_calculado, error_code] = gauss_pivoteo(A, b, tol);

% --- 3. Mostrar los resultados ---
if error_code == 0
    fprintf('\n--- RESULTADOS ---\n');
    fprintf('La solución calculada con gauss_pivoteo es:\n');
    disp(x_calculado);

    % --- 4. Comparación con la solución nativa de MATLAB/Octave ---
    disp('Calculando la solución con el operador nativo (A\b) para comparación...');
    x_nativo = A\b;
    fprintf('La solución nativa de MATLAB/Octave es:\n');
    disp(x_nativo);

    diferencia = norm(x_calculado - x_nativo);
    fprintf('\nLa diferencia (norma) entre las dos soluciones es: %e\n', diferencia);
else
    disp('El método reportó un error (matriz singular). No se pudo calcular la solución.');
end

