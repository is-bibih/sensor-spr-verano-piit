function n = dispersionZnSe(lamb)
  % lambda dada en nm, se calcula en mum
  lamb = lamb/1000;
  n = sqrt( 4 + 1.9*lamb.^2 ./ (lamb.^2 - 0.113));
end
