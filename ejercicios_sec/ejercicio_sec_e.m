% EJERCICIO_SECANTE_E Resuelve e^x - 3*x^2 = 0 con el método de la secante
% Dos intervalos: [0, 1] y [3, 5]
clear; clc;

pkg load symbolic; % Comentar en MATLAB si tienes Symbolic Toolbox
syms x;

% Definición de la función simbólica
f = sym('exp(x) - 3*x^2');

% Tolerancia
TOL = 1e-5;

disp('Resolver e^x - 3*x^2 = 0 con método de la secante');
disp('Esta ecuación se evaluará en dos intervalos:');
disp('  Intervalo 1: [0, 1]');
disp('  Intervalo 2: [3, 5]');
disp(' ');

% Pedir al usuario qué intervalo explorar
intervalo = input('Seleccione el intervalo (1 o 2): ');

if intervalo == 1
    a = 0; b = 1;
    disp('Sugerencia de puntos iniciales en [0, 1]: por ejemplo 0.2 y 0.8');
elseif intervalo == 2
    a = 3; b = 5;
    disp('Sugerencia de puntos iniciales en [3, 5]: por ejemplo 3.2 y 4.5');
else
    disp('Opción no válida. Usando intervalo 1 por defecto.');
    intervalo = 1;
    a = 0; b = 1;
end

x0 = input('   x0 = ');
x1 = input('   x1 = ');

% Validación simple (como en ejercicio_sec_c.m)
while x0 == x1
    disp('x0 y x1 no deben ser iguales. Intente nuevamente.');
    x0 = input('   x0 = ');
    x1 = input('   x1 = ');
end

% Llamada al método de la secante pasando los límites del intervalo
[raiz, iteraciones, tiempo] = secante(f, TOL, x0, x1, a, b);

% Resultados
fprintf('\nResultado con TOL = %.0e\n', TOL);
fprintf('Raíz aproximada: %.10f\n', raiz);
fprintf('Iteraciones: %d\n', iteraciones);
fprintf('Tiempo (s): %.4f\n', tiempo);