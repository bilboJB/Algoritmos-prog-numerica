% EJERCICIO_SECANTE_C Resuelve 2*x*cos(2*x) - (x - 2)^2 = 0 con el método de la secante
% Dos intervalos: [2, 3] y [3, 4]
clear; clc;

pkg load symbolic; % Comentar en MATLAB si tienes Symbolic Toolbox
syms x;

% Definición de la función simbólica
f = sym('2*x*cos(2*x) - (x - 2)^2');

% Tolerancia
TOL = 1e-5;

disp('Resolver 2*x*cos(2*x) - (x - 2)^2 = 0 con método de la secante');
disp('Esta ecuación tiene raíces en dos intervalos:');
disp('  Intervalo 1: [2, 3]');
disp('  Intervalo 2: [3, 4]');
disp(' ');

% Pedir al usuario qué intervalo explorar
intervalo = input('Seleccione el intervalo (1 o 2): ');

if intervalo == 1
    a = 2;
    b = 3;
    disp('Sugerencia de puntos iniciales en [2, 3]: por ejemplo 2.0 y 2.5');
elseif intervalo == 2
    a = 3;
    b = 4;
    disp('Sugerencia de puntos iniciales en [3, 4]: por ejemplo 3.0 y 3.5');
else
    disp('Opción no válida. Usando intervalo 1 por defecto.');
    intervalo = 1;
    a = 2;
    b = 3;
end

x0 = input('   x0 = ');
x1 = input('   x1 = ');

% Validación simple
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