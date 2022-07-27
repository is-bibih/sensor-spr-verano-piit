function xbest = recoc(x0, f, fr, params_recocido)
  t0 = params_recocido.t0;
  a = params_recocido.a;
  L = params_recocido.L;
  tf = params_recocido.tf;

  xbest = x0;
  t = t0;
  while t >= tf
    for i = 1:L
      % encontrar vecino
      xv = random('Normal', 0, 1, size(x0)) + x0;
      % calcular costo
      d = f(xv) - f(x0);
      % ver si se escoge (si cumple con restriccion)
      p = rand;
      if ((p < exp(-d/t)) || d < 0) && fr(xv)
        % nuevo x actual
        x0 = xv;
        % ver si es mejor que mejor global
        if f(x0) < f(xbest)
          xbest = x0;
        end
      end
    end
    % enfriar T
    t = a*t;
  end
end
