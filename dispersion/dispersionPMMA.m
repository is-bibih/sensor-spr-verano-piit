function n = dispersionPMMA(lamb)
  % lambda dada en nm, se calcula en mum
  lamb = lamb/1000;
  n = sqrt( 1 + 1.1819*lamb.^2 ./ (lamb.^2 - 0.011313));
end
