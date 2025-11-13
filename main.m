% EJECUTAR_ALGORITMOS Script principal para ejecutar métodos numéricos
% Este script pide al usuario la función, la tolerancia y el método a usar,
% y llama a la función correspondiente, mostrando la evolución gráfica,
% la tabla de iteraciones, el tiempo de ejecución y la verificación con fzero.

clear; clc; % Limpiar la consola y las variables
pkg load symbolic; % CARGAR EL PAQUETE SIMBÓLICO (NECESARIO EN OCTAVE)

% --- 1. Entrada de la Función y Tolerancia ---
disp('--- SCRIPT DE BÚSQUEDA DE RAÍCES ---');
disp('Recuerde usar ''x'' como la variable independiente (ej: exp(-x) - sin(x))');
funcion_str = input('Ingrese la función f(x): ', 's');

% Usar toolbox simbólico
syms x;
f = sym(funcion_str);

TOL = input('Ingrese la tolerancia deseada (ej: 1e-6): ');
disp(' ');

% --- 2. Menú de Selección de Algoritmo ---
opcion = menu('Seleccione el algoritmo a utilizar', ...
    'Método de Newton', ...
    'Método de Bisección', ...
    'Método de la Secante', ...
    'Salir');

if opcion == 4
    disp('Saliendo del script.');
    return;
end

% Convertir la función simbólica a handle para 'fzero'
f_handle = matlabFunction(f);

% --- 3. Obtener Datos Iniciales y Ejecutar ---

raiz_obtenida = NaN;
iteraciones_finales = NaN;
tiempo_ejecucion = NaN;
% Inicializar variables para control de fzero (defensa)
a = NaN;
b = NaN;
x0 = NaN; % x0 se usa para Newton y Secante, y se necesita para fzero

switch opcion
    case 1 % Newton
        disp('--- DATOS PARA MÉTODO DE NEWTON ---');
        x0 = input('Ingrese el punto inicial (x0): ');

        % Llamar al algoritmo de Newton
        [raiz_obtenida, iteraciones_finales, tiempo_ejecucion] = newton(f, TOL, x0);

    case 2 % Bisección
        disp('--- DATOS PARA MÉTODO DE BISECCIÓN ---');
        a = input('Ingrese el límite inferior del intervalo [a, b]: ');
        b = input('Ingrese el límite superior del intervalo [a, b]: ');

        % Llamar al algoritmo de Bisección
        [raiz_obtenida, iteraciones_finales, tiempo_ejecucion] = biseccion(f, TOL, a, b);

    case 3 % Secante
        disp('--- DATOS PARA MÉTODO DE LA SECANTE ---');
        x0 = input('Ingrese el primer punto inicial (x0): ');
        x1 = input('Ingrese el segundo punto inicial (x1): ');

        % Llamar al algoritmo de la Secante
        [raiz_obtenida, iteraciones_finales, tiempo_ejecucion] = secante(f, TOL, x0, x1);

end

% --- 4. Comparación con fzero (Control) ---
disp(' ');
disp('--- ANÁLISIS DE RESULTADOS ---');

if ~isnan(raiz_obtenida)
    try
        disp('Realizando control de verificación con la función fzero...');

        % fzero necesita un valor inicial (siempre) o un intervalo (solo Bisección)
        if opcion == 2 && ~isnan(a) && ~isnan(b) % Bisección usa el intervalo [a, b]
            raiz_fzero = fzero(f_handle, [a b]);
        elseif (opcion == 1 || opcion == 3) && ~isnan(x0) % Newton o Secante usan el punto de inicio
            raiz_fzero = fzero(f_handle, x0);
        else
            disp('No se pudieron obtener datos iniciales válidos para el control con fzero.');
            raiz_fzero = NaN;
        end

        % Mostrar comparación
        if ~isnan(raiz_fzero)
            fprintf('\n--- COMPARACIÓN --- \n');
            fprintf('%-25s | %-15s | %-10s\n', 'Método', 'Raíz Obtenida', 'Tiempo (s)');
            disp(repmat('-', 1, 52));
            fprintf('%-25s | %-15.10f | %-10.4f\n', 'Algoritmo Programado', raiz_obtenida, tiempo_ejecucion);
            fprintf('%-25s | %-15.10f | %-10s\n', 'Función de Control (fzero)', raiz_fzero, 'N/A');

            % Calcular la diferencia absoluta entre raíces
            diferencia = abs(raiz_obtenida - raiz_fzero);
            fprintf('\nDiferencia absoluta entre raíces: %.10e\n', diferencia);
        end

    catch ME
        disp('fzero no pudo encontrar una raíz en el intervalo/punto inicial dado.');
        disp(['Error de fzero: ', ME.message]);
    end
end

disp(' ');
disp('Fin de la ejecución.');
