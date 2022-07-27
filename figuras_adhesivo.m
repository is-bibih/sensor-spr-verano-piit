clear

% agregar funciones de transferencia
addpath(genpath('funciones_transferencia'))

% agregar funciones de dispersion
addpath(genpath('dispersion'))
addpath(genpath('datos_n'))

% ----------
% parametros
% ----------

th0 = 30; thf = 75;         % limites angulo (grados)
N_th = 300;                 % puntos para angulo

% grosor de metal
d_metal = 50;

% grosores del adhesivo [nm]
d_todos = [1, 2, 3, 4, 5];

% longitud de onda en vacio [nm]
lamb_todos = [450, 540, 633, 700, 810];

% leyendas
lege = {'450 nm', '540 nm', '633 nm', '700 nm', '810 nm'};
nombres_elementos = {'Cr', 'Ti', 'Ni', 'Pd', 'Pt'};
colores = {'r', 'g', 'b', 'm', 'c'};

% ---------------------
% indices de refraccion
% ---------------------

% indice aire
nAire = 1;

% calcular indices para metales
nCr = nDeBaseDatos('Cr', lamb_todos);
nTi = nDeBaseDatos('Ti', lamb_todos);
nNi = nDeBaseDatos('Ni', lamb_todos);
nPd = nDeBaseDatos('Pd', lamb_todos);
nPt = nDeBaseDatos('Pt', lamb_todos);
nAu = nDeBaseDatos('Au', lamb_todos);

n_adhesivos = {nCr, nTi, nNi, nPd, nPt};

% calcular indices para dielectricos
nBK7 = dispersionBK7(lamb_todos);

% -----------------
% calcular R(theta)
% -----------------

% materiales y grosores
ni = nBK7;
nf = nAire;

th = linspace(th0, thf, N_th);

% ver efectos de usar cromo
demo_Cr = false;
if demo_Cr
  lamb = 633;
  d_todos = [0, d_todos];
  colores{length(colores)+1} = 'k';
  n_inter = {nCr(3), nAu(3)};
  leyenda = {'0 nm', '1 nm', '2 nm', '3 nm', '4 nm', '5 nm'};

  figure(1)
  hold on
  for i = 1:length(d_todos)
    d_inter = [d_todos(i), d_metal];
    [~, R] = hacerTransferencia(lamb, th, ni, n_inter, d_inter, nf);
    plot(th, R{1}, colores{i})
  end
  xlabel('$\theta_\mathrm{inc} [^\circ]$', 'interpreter', 'latex')
  ylabel('$R$', 'interpreter', 'latex')
  legend(leyenda)
  fontsize(gca, 15, 'points')
  shg
  saveas(gcf, 'comparacion_adhesivos2/grosor_cr_wl633.eps', 'epsc')
end

% ver efectos de cambiar longitud de onda
comp_lamb = false;
if comp_lamb
  n_inter = {nCr, nAu};
  d_inter = [1, d_metal];
  [~, R] = hacerTransferencia(lamb_todos, th, ni, n_inter, d_inter, nf);

  figure(1)
  hold on
  for i = 1:length(lamb_todos)
    plot(th, R{i}, colores{i})
  end
  xlabel('$\theta_\mathrm{inc} [^\circ]$', 'interpreter', 'latex')
  ylabel('$R$', 'interpreter', 'latex')
  legend(lege)
  fontsize(gca, 15, 'points')
  shg
  saveas(gcf, 'comparacion_adhesivos2/lamb_cr.eps', 'epsc')
end

% ver efectos de cambiar materiales
comp_materiales = true;
if comp_materiales
  lamb = 700;
  d_inter = [1, d_metal];

  figure(1)
  hold on
  for i = 1:length(n_adhesivos)-1
    n_inter = {n_adhesivos{i}(4), nAu(4)};
    [~, R] = hacerTransferencia(lamb, th, ni, n_inter, d_inter, nf);
    plot(th, R{1}, colores{i})
  end
  xlabel('$\theta_\mathrm{inc} [^\circ]$', 'interpreter', 'latex')
  ylabel('$R$', 'interpreter', 'latex')
  legend(nombres_elementos)
  fontsize(gca, 15, 'points')
  shg
  %saveas(gcf, 'comparacion_adhesivos2/materiales.eps', 'epsc')
  saveas(gcf, 'comparacion_adhesivos2/materiales_sin_pt.eps', 'epsc')
end

% ver efectos de cambiar grosor y materiales
iterar = false;
if iterar
fig_count = 1;
% iterar sobre elementos
for j = 1:length(n_adhesivos)
  n_inter = {n_adhesivos{j}, nAu};
  % iterar sobre grosores
  for i = 1:length(d_todos)
    d_inter = [d_todos(i), d_metal];
    titulo = append(nombres_elementos{j}, ', $d = ', string(d_todos(i)), '$ nm');

    % obtener reflectancia
    [~, R_todos] = hacerTransferencia(lamb_todos, th, ni, n_inter, d_inter, nf);

    figure(fig_count); fig_count = fig_count + 1;
    hold on
    for k = 1:length(lamb_todos)
      plot(th, R_todos{k}, colores{k})
    end
    title(titulo, 'interpreter', 'latex')
    xlabel('$\theta_\mathrm{inc} [^\circ]$', 'interpreter', 'latex')
    ylabel('$R$', 'interpreter', 'latex')
    ylim([0, 1.1])
    legend(lege)
    fontsize(gca, 15, 'points')
    hold off
    shg
    saveas(gcf, append('comparacion_adhesivos2/', nombres_elementos{j}, '_d', string(d_todos(i)) ,'.eps'), 'epsc')
  end

end
end

input('haz enter para cerrar las figuras')
close all

