function simpson_rules()
    % OBJETIVO: Aplicar Simpson 1/3, 3/8 y aplicaciones múltiples (pares/impares).

    fprintf('\n--- REGLAS DE SIMPSON ---\n');

    % Ingreso simplificado de la función (la variable debe ser x)
    f_input = input('Ingrese la expresión f(x) (ej. 1 - exp(-2*x)): ', 's');

    try
        % Conversión de texto a función anónima (Forma moderna recomendada)
        f_raw = str2func(['@(x) ' f_input]);
        % Se usa arrayfun para evitar errores si el usuario olvida los puntos (.)
        f = @(x) arrayfun(f_raw, x);
        % Verificación rápida
        f(0);
    catch
        fprintf('Error en la expresión. Asegúrese de usar x como variable.\n');
        return;
    end

    a = input('Límite inferior a: ');
    b = input('Límite superior b: ');
    n = input('Número de segmentos n: ');

    if n < 2
        fprintf('Error: Simpson requiere al menos 2 segmentos para 1/3 o 3 para 3/8.\n');
        return;
    end

    h = (b - a) / n;

    % --- Lógica de Selección de Método ---

    if n == 2 % 1/3 Simple
        I = (h/3) * (f(a) + 4*f(a+h) + f(b));
        metodo = 'Simpson 1/3 Simple';

    elseif n == 3 % 3/8 Simple
        I = (3*h/8) * (f(a) + 3*f(a+h) + 3*f(a+2*h) + f(b));
        metodo = 'Simpson 3/8 Simple';

    elseif mod(n, 2) == 0 % 1/3 Múltiple (n par)
        s_imp = 0; s_par = 0;
        for i = 1:2:n-1
            s_imp = s_imp + f(a + i*h);
        end
        for i = 2:2:n-2
            s_par = s_par + f(a + i*h);
        end
        I = (h/3) * (f(a) + 4*s_imp + 2*s_par + f(b));
        metodo = 'Simpson 1/3 Múltiple';

    else % n impar -> Aplicación Mixta (Simpson 1/3 + Simpson 3/8 final)
        % Se aplican reglas de Simpson 1/3 hasta los últimos 3 segmentos
        n_13 = n - 3;
        I_13 = 0;

        if n_13 > 0
            lim_mid = a + n_13*h;
            si = 0; sp = 0;
            for i = 1:2:n_13-1; si = si + f(a + i*h); end
            for i = 2:2:n_13-2; sp = sp + f(a + i*h); end
            I_13 = (h/3) * (f(a) + 4*si + 2*sp + f(lim_mid));
        end

        % Simpson 3/8 para los últimos 3 segmentos (indispensable para n impar)
        a_38 = a + n_13*h;
        I_38 = (3*h/8) * (f(a_38) + 3*f(a_38+h) + 3*f(a_38+2*h) + f(b));

        I = I_13 + I_38;
        metodo = 'Simpson Múltiple Combinada (1/3 + 3/8)';
    end

    fprintf('\n----------------------------------------\n');
    fprintf('Método utilizado: %s\n', metodo);
    fprintf('Resultado de la integral: %f\n', I);
    fprintf('----------------------------------------\n');
end
