function n = dispersionPDMS(lamb)
  % lambda dada en nm, se calcula en mum
  lamb = lamb/1000;
  n = sqrt( 1 + 1.0057*lamb.^2 ./ (lamb.^2 - 0.013217));
end
