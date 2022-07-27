function P = hacerPropagacion(n0, k0, n1, d1, th)
  N_th = length(th);
  % calcular fase
  phi1 = k0 .* n1 * d1 .* sqrt(1 - (n0/n1)^2 * sind(th).^2);
  % armar matriz
  P = zeros(2, 2, N_th);
  P(1,1,:) = exp(-1i * phi1);
  P(2,2,:) = exp(1i * phi1);
end

