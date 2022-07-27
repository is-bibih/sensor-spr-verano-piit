function costo = funcionCosto(x)
  global lamb; global th; global ni; global nf; global R_exp;
  % armar parametros
  n = x(1);
  k = x(2);
  d = x(3);
  n_inter = {n + 1i*k};
  d_inter = [d];
  % obtener reflectancia
  [~, R] = hacerTransferencia(lamb, th, ni, n_inter, d_inter, nf);
  % calcular error
  %costo = MSE(R{1}, R_exp);
  %costo = sum(abs(R{1} - R_exp));
  costo = mean(abs(R{1} - R_exp));
end

