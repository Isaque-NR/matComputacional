function lista4_ex_4 ()
  clc;
  x0 = [2.5 ; 2.5];
  maxItr = 1000;
  tol = 1e-3;
  aN= 1; %  0,0001 <= alpha <= 10
  aG = 0.01;

  [pontoOtimoN,iN] = metodoNewton(x0,aN,maxItr,tol)

  [pontoOtimoG,iG] = metodoGradiente(x0,aG,maxItr,tol)








function vetY = f(vetx)

  x = vetx(1);
  y = vetx(2);

  vetY = (x.^2 + y - 11)^2 + (x + y.^2 - 7)^2;


endfunction

function gradiente = gf(vetx) %gradiente de f(x)

  x = vetx(1);
  y = vetx(2);

  gradiente = nan(2,1);
  gradiente(1) = 4*x^3 + 2*y^2 + 4*x*y - 42*x - 14 ; %vetor coluna com as derivadas parciais
  gradiente(2) = 4*y^3 + 2*x^2 + 4*x*y - 26*y -22 ;


endfunction

function haussiana = H(vetx)

  x = vetx(1);
  y = vetx(2);

  haussiana = nan(2,2);

  haussiana(1,1) = 12*x^2 + 4*y - 42;
  haussiana(1,2) = 4*x + 4*y;
  haussiana(2,1) = 4*y + 4*x;
  haussiana(2,2) = 12*y^2 + 4*x -26;

endfunction

function [ pontoOtimoN, iN, todosXN, todosYN] = metodoNewton(x0,a,maxItr,tol)

  todosXN = nan(maxItr+1, length(x0));
  todosYN = nan(maxItr+1, 1);
  todosXN(1,:) = x0;
  todosYN(1) = f(x0);

  for iN = 1:maxItr
    x1 = x0 - a*(H(x0)\gf(x0));
    todosXN(iN+1, :) = x1;
    todosYN(iN+1) = f(x1);

    if max(abs(x1-x0)) <= tol
      x0 = x1;
      break
    endif
    x0 = x1;
  endfor

  todosXN = todosXN(1:iN+1, : ); %truncando o vetor
  todosYN = todosYN(1:iN+1);
  pontoOtimoN = x0;
 endfunction

function [ pontoOtimoG, iG, todosXG, todosYG] = metodoGradiente(x0,a,maxItr,tol)

  todosXG = nan(maxItr+1, length(x0));
  todosYG = nan(maxItr+1, 1);
  todosXG(1,:) = x0;
  todosYG(1) = f(x0);

  for iG = 1:maxItr
    x1 = x0 - a*gf(x0);
    todosXG(iG+1, :) = x1;
    todosYG(iG+1) = f(x1);

    if max(abs(x1-x0)) <= tol
      x0 = x1;
      break
    endif
    x0 = x1;
  endfor

  todosXG = todosXG(1:iG+1, : );
  todosYG = todosYG(1:iG+1);
  pontoOtimoG = x0;
 endfunction
















endfunction
