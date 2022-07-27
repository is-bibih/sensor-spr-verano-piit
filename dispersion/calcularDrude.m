function N = calcularDrude(omegap, gam, lamb)
  % omegap [s^-1]
  % lamb [nm]
  c = 2.99782458e8; % rapidez de luz en el vacio
  lamb = lamb * 1e-9; % pasar a m
  omega = 2*pi * c ./ lamb; 
  eps = 1 - omegap^2 ./ (omega .* (omega + 1i*gam));
  N = sqrt(eps);
end
