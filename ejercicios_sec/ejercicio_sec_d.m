% EJERCICIO_SECANTE_D Resuelve (x - 2)^2 - ln(x) = 0 con el método de la secante
% Intervalos: [1, 2] y [e, 4]
clear; clc;

pkg load symbolic; % Comentar en MATLAB si tienes Symbolic Toolbox
syms x;

% Definición de la función simbólica (ln(x) = log(x))
f = sym('(x - 2)^2 - log(x)');

% Tolerancia
TOL = 1e-5;

disp('Resolver (x - 2)^2 - ln(x) = 0 con método de la secante');
disp('Esta ecuación se evalúa para x > 0 (por ln(x)).');
disp('  Intervalo 1: [1, 2]');
disp('  Intervalo 2: [e, 4]  ~ [2.718, 4]');
disp(' ');

% Selección de intervalo
intervalo = input('Seleccione el intervalo (1 o 2): ');

if intervalo == 1
    a = 1; b = 2;
    disp('Sugerencia de puntos iniciales en [1, 2]: por ejemplo 1.2 y 1.8');
elseif intervalo == 2
    a = exp(1); b = 4;
    disp('Sugerencia de puntos iniciales en [e, 4]: por ejemplo e y 3.5');
else
    disp('Opción no válida. Usando intervalo 1 por defecto.');
    a = 1; b = 2;
end

x0 = input('   x0 = ');
x1 = input('   x1 = ');

% Validaciones básicas (cerrados en [1,2] y [e,4])
if intervalo == 2
    while x0 == x1 || x0 < a || x0 > b || x1 < a || x1 > b
        fprintf('x0 y x1 deben ser distintos y estar en [%.3f, %.1f]. Intente nuevamente.\n', a, b);
        x0 = input('   x0 = ');
        x1 = input('   x1 = ');
    end
else
    while x0 == x1 || x0 < a || x0 > b || x1 < a || x1 > b
        fprintf('x0 y x1 deben ser distintos y estar en [%.1f, %.1f]. Intente nuevamente.\n', a, b);
        x0 = input('   x0 = ');
        x1 = input('   x1 = ');
    end
end

% Llamada al método de la secante pasando el intervalo [a, b]
[raiz, iteraciones, tiempo] = secante(f, TOL, x0, x1, a, b);

% Resultados
fprintf('\nResultado con TOL = %.0e\n', TOL);
fprintf('Raíz aproximada: %.10f\n', raiz);
fprintf('Iteraciones: %d\n', iteraciones);
fprintf('Tiempo (s): %.4f\n', tiempo);