function N = nDeBaseDatos(str_elemento, lamb)

  % lambda dada en nm, pasar a mum
  lamb = lamb/1000;
  
  % nombres de archivos con datos a leer
  addpath(genpath('../datos_n'))
  archivo_n = strcat(str_elemento, '_n.csv');
  archivo_k = strcat(str_elemento, '_k.csv');

  % leer datos
  datos_n = readmatrix(archivo_n);
  datos_k = readmatrix(archivo_k);
  lamb_exp = datos_n(:, 1);
  n_exp = datos_n(:, 2);
  k_exp = datos_k(:, 2);

  % estimar N para cada valor
  
  N = zeros(1, length(lamb));

  for i = 1:length(lamb)

    % encontrar los dos valores más cercanos a la longitud de onda
    [~, idx] = mink(abs(lamb(i) - lamb_exp), 2);
    lamb_cercanos = lamb_exp(idx);

    % hacer interpolación lineal con valores más cercanos
    % para n
    pendiente_n = (n_exp(idx(2)) - n_exp(idx(1))) / ...
                  (lamb_cercanos(2) - lamb_cercanos(1));
    n = pendiente_n * (lamb(i) - lamb_cercanos(1)) + n_exp(idx(1));
    % para k
    pendiente_k = (k_exp(idx(2)) - k_exp(idx(1))) / ...
                  (lamb_cercanos(2) - lamb_cercanos(1));
    k = pendiente_k * (lamb(i) - lamb_cercanos(1)) + k_exp(idx(1));

    % guardar valor
    N(i) = n + 1i*k;
  end
end
