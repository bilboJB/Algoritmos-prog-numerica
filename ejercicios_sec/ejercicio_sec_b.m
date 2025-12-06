% EJERCICIO_SECANTE_B Resuelve log(x-1) + cos(x-1) = 0 con el método de la secante
% Intervalo dado: 1.3 <= x <= 2 (recordar que x > 1 por log(x-1))
clear; clc;

pkg load symbolic; % Comentar en MATLAB si tienes Symbolic Toolbox
syms x;

% Definición de la función (log = ln)
f = sym('log(x - 1) + cos(x - 1)');

% Tolerancia
TOL = 1e-5;

% Intervalo para graficar y referencia
a = 1.3;
b = 2.0;

disp('Resolver log(x - 1) + cos(x - 1) = 0 con método de la secante');
disp('Sugerencia de puntos iniciales dentro de [1.3, 2]: por ejemplo 1.3 y 1.9');
x0 = input('   x0 = ');
x1 = input('   x1 = ');

% Validaciones básicas
while x0 == x1 || x0 < a || x0 > b || x1 < a || x1 > b
    fprintf('x0 y x1 deben ser distintos y estar en [%.1f, %.1f]. Intente nuevamente.\n', a, b);
    x0 = input('   x0 = ');
    x1 = input('   x1 = ');
end

% Llamada al método de la secante pasando el intervalo [a, b]
[raiz, iteraciones, tiempo] = secante(f, TOL, x0, x1, a, b);

% Resultados
fprintf('\nResultado con TOL = %.0e\n', TOL);
fprintf('Raíz aproximada: %.10f\n', raiz);
fprintf('Iteraciones: %d\n', iteraciones);
fprintf('Tiempo (s): %.4f\n', tiempo);