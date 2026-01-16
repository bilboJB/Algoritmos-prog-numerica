function trapezoidal_rule()
    % OBJETIVO: Integración numérica mediante la Regla del Trapecio (Simple y Múltiple).

    fprintf('\n--- REGLA DEL TRAPECIO ---\n');

    f_input = input('Ingrese la expresión f(x) (use x como variable): ', 's');

    try
        % Se crea la función anónima a partir del texto ingresado
        f = str2func(['@(x) ' f_input]);
        % Verificación rápida de la función en el punto 0
        f(0);
    catch
        fprintf('Error en la expresión. Asegúrese de usar x como variable y operaciones válidas.\n');
        return;
    end

    a = input('Límite inferior a: ');
    b = input('Límite superior b: ');
    n = input('Número de segmentos (n=1 para Simple): ');

    if n < 1
        fprintf('Error: n debe ser mayor o igual a 1.\n');
        return;
    end

    % Algoritmo de cálculo
    h = (b - a) / n;
    % Generamos los puntos del intervalo
    x_puntos = linspace(a, b, n + 1);
    % Evaluamos cada punto usando arrayfun para mayor robustez
    y_puntos = arrayfun(f, x_puntos);

    % Aplicación de la regla del trapecio
    % Fórmula: (h/2) * (f(a) + 2 * sumatoria_intermedios + f(b))
    if n == 1
        I = (h / 2) * (y_puntos(1) + y_puntos(2));
    else
        I = (h / 2) * (y_puntos(1) + 2 * sum(y_puntos(2:end-1)) + y_puntos(end));
    end

    fprintf('\n----------------------------------------\n');
    fprintf('Resultado de la integral: %f\n', I);
    fprintf('----------------------------------------\n');
end
