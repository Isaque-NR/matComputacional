% Jacobiano
% vetor que recebe vetor com o sistema
% jacobiano que recebe o vetor com o sistema
function lista2_ex_2()
  clc;
  x0 = [1;1];
  tol = 1e-5;
  maxItr = 1000;
  resultados = newtonRaphson(x0,tol,maxItr)

endfunction

function vetY = sistema(vetX)

  x = vetX(1);
  y = vetX(2);

  vetY = zeros(2,1);  % 2 por ser duas funcoes
  vetY(1) = 2 .*x.^2 - 4 .*x.*y - y.^2;   % u(x,y)
  vetY(2) = 2 .*y.^2 + 10 .*x - x.^2 - 4 .*x.*y -5; %v(x,y)

endfunction

function J = jacobiano(vetX)

    x = vetX(1);
    y = vetX(2);

    J = zeros(2,2); % 2 equacoes por 2 variaveis
    J(1,1) = 4 .*x -4 .*y;
    J(1,2) = -4 .*x -2 .*y;
    J(2,1) = 10 - 2 .*x -4.*y;
    J(2,2) = 4.*y -4 .*x;

endfunction

function resultados = newtonRaphson(x0,tol,maxItr)

    for i = 1:maxItr

      J = jacobiano(x0);
      f = sistema(x0);
      x1 = x0 - inv(J)*f;

      if max(abs(x1-x0)) <= tol
        x0 = x1;
        break;
      endif
      x0 = x1;
    endfor
    resultados = x0;
    i
endfunction
