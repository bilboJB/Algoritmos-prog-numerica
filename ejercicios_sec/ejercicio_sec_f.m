% EJERCICIO_SECANTE_F Resuelve sen(x) - e^(-x) = 0 con el método de la secante
% Tres intervalos: [0, 1], [3, 4] y [6, 7]
clear; clc;

pkg load symbolic; % Comentar en MATLAB si tienes Symbolic Toolbox
syms x;

% Definición de la función simbólica
f = sym('sin(x) - exp(-x)');

% Tolerancia
TOL = 1e-5;

disp('Resolver sen(x) - e^{-x} = 0 con método de la secante');
disp('Esta ecuación se evaluará en tres intervalos:');
disp('  Intervalo 1: [0, 1]');
disp('  Intervalo 2: [3, 4]');
disp('  Intervalo 3: [6, 7]');
disp(' ');

% Selección de intervalo
intervalo = input('Seleccione el intervalo (1, 2 o 3): ');

if intervalo == 1
    a = 0; b = 1;
    disp('Sugerencia de puntos iniciales en [0, 1]: por ejemplo 0.2 y 0.8');
elseif intervalo == 2
    a = 3; b = 4;
    disp('Sugerencia de puntos iniciales en [3, 4]: por ejemplo 3.2 y 3.8');
elseif intervalo == 3
    a = 6; b = 7;
    disp('Sugerencia de puntos iniciales en [6, 7]: por ejemplo 6.2 y 6.8');
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