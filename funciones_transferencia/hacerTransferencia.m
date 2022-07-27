function [M_todos, R_todos] = hacerTransferencia(lamb_todos, th, ni, n_inter, d_inter, nf)
% obtener matriz de transferencia

%{ 
parámetros:
  lamb_todos: vector de longitudes de onda
  th: vector de ángulo (grados) de incidencia
  ni: vector de índices de refracción de sustrato
  n_inter: arreglo de vectores de refracción de los materiales intermedios
  d_inter: arreglo de vectores de grosor de los materiales intermedios
  nf: vector de índices de refracción del material final
%}
    % largo de th
    N_th = length(th);

    % hacer arreglo para almacenar resultados
    M_todos = cell(length(lamb_todos), 1);
    R_todos = cell(length(lamb_todos), 1);

    % iterar sobre longitudes de onda
    for i = 1:length(lamb_todos)
      lamb = lamb_todos(i);

      % numero de onda
      k0 = 2*pi / lamb;
      kz = ni(i)*k0 * sind(th);
      
      n0 = ni(i);
      M = repmat(eye(2), [1,1,N_th]);
      
      for j = 1:length(n_inter)
        % parametros de capa actual
        n1 = n_inter{j}(i);
        d1 = d_inter(j);
        % obtener matrices de transferencia
        T = hacerTransmision(n0, n1, k0, th, kz);
        P = hacerPropagacion(ni(i), k0, n1, d1, th);
        % multiplicar a M
        M = pagemtimes(M, T);
        M = pagemtimes(M, P);
        % actualizar parametros de capa
        n0 = n1;
      end
      
      % capa final
      n1 = nf;
      T = hacerTransmision(n0, n1, k0, th, kz);
      M = pagemtimes(M, T);

      % calcular reflectancia
      r = M(2,1,:) ./ M(1,1,:);
      R = reshape(abs(r).^2, [N_th, 1]);

      % almacenar
      M_todos{i} = M;
      R_todos{i} = R;
    end
end
