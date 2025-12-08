% === LEYENDA DE PARÁMETROS Y VARIABLES ===
%
% A       : Matriz de coeficientes ingresada por el usuario.
% b       : Vector de términos independientes ingresado por el usuario.
% x0      : Vector de la aproximación inicial (solo para métodos iterativos).
% tol     : Tolerancia (criterio de parada).
% maxIter : Número máximo de iteraciones permitidas (solo para métodos iterativos).
% eleccion: Opción seleccionada por el usuario en el menú.
% x       : Vector solución final.
% iter    : Número de iteraciones (Gauss-Seidel).
% error_final: Error final alcanzado (solo para métodos iterativos).
% er      : Código de error (solo para métodos directos).
%
% ========================================

% === SECCIÓN DE INICIALIZACIÓN DE ENTORNO ===
clc;        % Limpiar la consola
clear;      % Limpiar todas las variables del espacio de trabajo

% Definir las opciones del menú
opciones_menu = {'Algoritmo de Gauss-Seidel', 'Eliminación Gaussiana con Pivoteo Parcial Escalonado', 'Salir del Programa'};

% === SECCIÓN DE BUCLE DEL MENÚ PRINCIPAL ===
while true

    fprintf('*********************************************************\n');
    fprintf('* RESOLUCIÓN DE SISTEMAS DE ECUACIONES LINEALES         *\n');
    fprintf('*********************************************************\n\n');

    % Mostrar el menú y obtener la elección del usuario
    eleccion = menu('Seleccione el algoritmo a utilizar:', opciones_menu);

    % === SECCIÓN DE MANEJO DE OPCIONES ===
    switch eleccion

        case 1 % Opción: Algoritmo de Gauss-Seidel (Método Iterativo)

            fprintf('\n--- Algoritmo de Gauss-Seidel ---\n');

            % === SECCIÓN DE INGRESO DE DATOS ITERATIVOS ===
            try
                fprintf('\n--- INGRESO DE DATOS (Recuerde usar corchetes y punto y coma [;] para matrices y vectores columna) ---\n');

                % Lectura de A, b
                prompt_A = 'Ingrese la matriz de coeficientes A (e.g., [2 1; 1 2]): ';
                A = input(prompt_A);
                prompt_b = 'Ingrese el vector de términos independientes b (e.g., [3; 3]): ';
                b = input(prompt_b);

                % Lectura de x0, tol, maxIter
                prompt_x0 = 'Ingrese el vector de aproximación inicial x0 (e.g., [0; 0]): ';
                x0 = input(prompt_x0);
                prompt_tol = 'Ingrese la tolerancia (error relativo, e.g., 1e-4): ';
                tol = input(prompt_tol);
                prompt_maxIter = 'Ingrese el número máximo de iteraciones (e.g., 100): ';
                maxIter = input(prompt_maxIter);

                % Asegurar que b y x0 sean vectores columna
                if size(b, 1) < size(b, 2); b = b'; end
                if size(x0, 1) < size(x0, 2); x0 = x0'; end

            catch ME
                fprintf('\n*** ERROR DE ENTRADA: Asegúrese de ingresar los datos en el formato correcto.\n');
                fprintf('Detalles del error: %s\n', ME.message);
                continue; % Volver al inicio del bucle del menú
            end

            % === SECCIÓN DE EJECUCIÓN Y VISUALIZACIÓN GS ===
            fprintf('\n--- EJECUTANDO GAUSS-SEIDEL ---\n');
            try
                [x, iter, error_final] = gauss_seidel(A, b, x0, tol, maxIter);

                fprintf('\n--- RESULTADOS DEL ALGORITMO GAUSS-SEIDEL ---\n');
                disp('DATOS INICIALES:');
                disp(['Matriz A: ']); disp(A);
                disp(['Vector b: ']); disp(b);
                fprintf('Aproximación inicial x0: \n'); disp(x0);
                fprintf('Tolerancia (Error Relativo): %e\n', tol);
                fprintf('Máximo de Iteraciones: %d\n\n', maxIter);

                disp('==================================================');
                disp('La solución aproximada final (x) es:');
                disp(x);
                fprintf('Número de iteraciones realizadas: %d\n', iter);
                fprintf('Error final alcanzado (Relativo): %e\n', error_final);

                if error_final <= tol
                    fprintf('*** ESTADO: CONVERGENCIA EXITOSA. Se alcanzó la tolerancia requerida.\n');
                else
                    fprintf('*** ESTADO: NO CONVERGIÓ. Se alcanzó el máximo de iteraciones sin lograr la tolerancia.\n');
                end
                disp('==================================================');

            catch ME
                fprintf('\n*** ERROR EN LA EJECUCIÓN DE GAUSS-SEIDEL: %s\n', ME.message);
            end


        case 2 % Opción: Eliminación Gaussiana con Pivoteo Parcial Escalonado (Método Directo)

            fprintf('\n--- Eliminación Gaussiana con Pivoteo Parcial Escalonado ---\n');

            % === SECCIÓN DE INGRESO DE DATOS DIRECTOS ===
            try
                fprintf('\n--- INGRESO DE DATOS (Recuerde usar corchetes y punto y coma [;] para matrices y vectores columna) ---\n');

                % Lectura de A, b
                prompt_A = 'Ingrese la matriz de coeficientes A (e.g., [2 1; 1 2]): ';
                A = input(prompt_A);
                prompt_b = 'Ingrese el vector de términos independientes b (e.g., [3; 3]): ';
                b = input(prompt_b);

                % Lectura de la Tolerancia para singularidad
                prompt_tol = 'Ingrese la tolerancia para detectar singularidad (e.g., 1e-6): ';
                tol = input(prompt_tol);

                % Asegurar que b sea vector columna
                if size(b, 1) < size(b, 2); b = b'; end

            catch ME
                fprintf('\n*** ERROR DE ENTRADA: Asegúrese de ingresar los datos en el formato correcto.\n');
                fprintf('Detalles del error: %s\n', ME.message);
                continue; % Volver al inicio del bucle del menú
            end

            % === SECCIÓN DE EJECUCIÓN Y VISUALIZACIÓN GAUSS PIVOTEO ===
            fprintf('\n--- EJECUTANDO GAUSS PIVOTEO ---\n');
            try
                % La llamada ya no incluye 'etapas'
                [x, er] = gauss_pivoteo(A, b, tol);

                fprintf('\n--- RESULTADOS DEL ALGORITMO GAUSS CON PIVOTEO ---\n');
                disp('DATOS INICIALES:');
                disp(['Matriz A: ']); disp(A);
                disp(['Vector b: ']); disp(b);
                fprintf('Tolerancia de Singularidad: %e\n\n', tol);

                disp('==================================================');
                fprintf('Código de Error (0=Éxito, -1=Singular): %d\n', er);

                if er == 0
                    disp('La solución final (x) es:');
                    disp(x);
                    fprintf('*** ESTADO: ÉXITO. El sistema se resolvió sin problemas de singularidad.\n');
                else
                    fprintf('*** ESTADO: ERROR. La matriz es singular o cercana a singular.\n');
                    disp('La solución no pudo ser encontrada (x = NaN).');
                end
                disp('==================================================');

            catch ME
                fprintf('\n*** ERROR EN LA EJECUCIÓN DE GAUSS PIVOTEO: %s\n', ME.message);
            end

        case 3 % Opción: Salir

            % === SECCIÓN DE SALIDA ===
            fprintf('\nSaliendo del programa. ¡Hasta luego!\n');
            return; % Salir del script

        otherwise
            % Manejo de la opción 'Cerrar ventana' (eleccion = 0) o inesperada
            if eleccion == 0
                fprintf('\nVentana de menú cerrada. Saliendo del programa. ¡Hasta luego!\n');
                return;
            else
                 fprintf('\nOpción no válida. Intente de nuevo.\n');
            end

    end % Fin del switch

    % Pausar para que el usuario pueda ver los resultados antes de volver al menú
    if eleccion ~= 3 && eleccion ~= 0
        fprintf('\nPresione cualquier tecla para volver al menú principal...\n');
        pause;
        clc; % Limpiar antes de volver a mostrar el menú
    end

end % Fin del bucle while
