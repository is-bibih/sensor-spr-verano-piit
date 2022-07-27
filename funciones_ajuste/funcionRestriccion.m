function valido = funcionRestriccion(x)
  n = x(1);
  k = x(2);
  d = x(3);
  valido = (0 < n) && (n < 3) && ...
           (0 < k) && (k < 10) && ...
           (0 < d) && (d < 100);
end

