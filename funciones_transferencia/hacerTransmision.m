function T = hacerTransmision(n0, n1, k0, th, kz)
  N_th = length(th);
  % componentes sobre x
  kx0 = sqrt(n0^2 * k0.^2 - kz.^2);
  kx1 = sqrt(n1^2 * k0.^2 - kz.^2);
  % coeficientes
  r01 = (n0^2 * kx1 - n1^2 * kx0) ./ ...
    (n0^2 * kx1 + n1^2 * kx0);
  t01 = (n0/n1) * (1 + r01);
  % hacer matriz
  coef01 = reshape(1./t01, [1, 1, N_th]);
  T = ones(2, 2, N_th);
  T(2,1,:) = r01;
  T(1,2,:) = r01;
  T = coef01 .* T;
end

