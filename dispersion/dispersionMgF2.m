function n = dispersionMgF2(lamb)
  % lambda dada en nm, se calcula en mum
  lamb = lamb/1000;
  n = sqrt( 1 ...
    + 0.48755108 * lamb.^2 ./ (lamb.^2 - 0.04338408^2) ...
    + 0.39875031 * lamb.^2 ./ (lamb.^2 - 0.09461442^2) ...
    + 2.3120353 * lamb.^2 ./ (lamb.^2 - 23.793604^2) ...
  );
end


