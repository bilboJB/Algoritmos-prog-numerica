% EJERCICIO_SECANTE Resuelve e^x + 2^(-x) + 2*cos(x) - 6 = 0 con el método de la secante
clear; clc;

pkg load symbolic; % si usas Octave; en MATLAB coméntalo si tienes Symbolic Toolbox
syms x;

% Definición de la función simbólica
f = sym('exp(x) + 2^(-x) + 2*cos(x) - 6');

% Tolerancia solicitada
TOL = 1e-5;

% Pedir puntos iniciales al usuario
disp('Ingrese los puntos iniciales para el método de la secante (sugerido en [1, 2]):');
x0 = input('   x0 = ');
x1 = input('   x1 = ');

% Validación simple
while x0 == x1
    disp('x0 y x1 no deben ser iguales. Intente nuevamente.');
    x0 = input('   x0 = ');
    x1 = input('   x1 = ');
end

% Llamada al método de la secante (usa secante.m en la misma carpeta)
% Se añaden los límites del intervalo [1, 2]
[raiz, iteraciones, tiempo] = secante(f, TOL, x0, x1, 1, 2); % Se pasan los límites del intervalo

% Mostrar resultados
fprintf('\nResultado del ejercicio con TOL = %.0e\n', TOL);
fprintf('Raíz aproximada: %.10f\n', raiz);
fprintf('Iteraciones: %d\n', iteraciones);
fprintf('Tiempo (s): %.4f\n', tiempo);