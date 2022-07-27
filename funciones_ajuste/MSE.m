function mse = MSE(x, x0)
  mse = mean((x - x0).^2);
end
