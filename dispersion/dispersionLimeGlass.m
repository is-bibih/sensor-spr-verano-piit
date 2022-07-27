function n = dispersionLimeGlass(lamb)
  % lambda dada en nm, se calcula en mum
  lamb = lamb/1000;
  n = 1.5130 - 0.003169 * lamb.^2 + 0.003962 * lamb.^(-2);
end

