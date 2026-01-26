function lista4_ex_4 ()

  x0 = [2,5 ; 2,5];
  itr = 1000;
  tol = 1e-3
  H = %Haussiana de f(x)









function vetY = f(x)

  x = x(1);
  y = x(2);

  vetY = (x.^2 + y - 11)^2 + (x + y.^2 - 7)^2;


endfunction

function gradiente = gf(x) %gradiente de f(x)

  x = x(1);
  y = x(2);

  gradiente = [      ;     ] %vetor coluna com as derivadas parciais


endfunction

function haussiana = H(x)

  x = x(1);
  y = x(2);

  haussiana = nan(2,2);

  haussiana(1,1) =
  haussiana(1,2) =
  haussiana(2,1) =
  haussiana(2,2) =



endfunction
