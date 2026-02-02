function lista4_ex_4 ()
  clc;
  x0 = [2.5 ; 2.5];
  maxItr = 1000;
  tol = 1e-3;
  aN = 1; %  0,0001 <= alpha <= 10
  aG = 0.0001; % alphas diferentes pois o metodo do gradiente nao estava convergindo com alpha = 1, estava dando NaN

  [pontoOtimoN,iN,todosXN,todosYN] = metodoNewton(x0,aN,maxItr,tol);
  %prints...
  [pontoOtimoG,iG,todosXG,todosYG] = metodoGradiente(x0,aG,maxItr,tol); % notase que o metodo nao
   %prints...
   [todosZ,intervaloX,intervaloY] = superficie();
   plotagrafico3DNewton(todosXN,todosYN,todosZ,intervaloX,intervaloY,iN,aN);









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

function [todosZ,intervaloX,intervaloY] = superficie() %funcao para preencher a matriz Z que vai ser a superficie do grafico 3D
  intervaloX = linspace(-6,6,500); %intervalos para os espacamentos q estao na figura da lista
  intervaloY = linspace(-6,6,500);

  todosZ = nan(length(intervaloY),length(intervaloX));

  for i = 1:length(intervaloX) % matriz contendo os resultados de fa funcao para cada (x,y)
    for j = 1:length(intervaloY)
        todosZ(j,i) = f([intervaloX(i);intervaloY(j)]); %preenchimento da matriz Z com o valor da funcao para cada intervalo de x e y, (j,i) pq o octave preenche linha por coluna
    endfor
  endfor

endfunction

function plotagrafico3DNewton(todosXN,todosYN,todosZ,intervaloX,intervaloY,iN,aN)
  figure(1);
  clf;
  surf(intervaloX,intervaloY,todosZ); %plotando o grafico com a superficie
  hold on;
  grid on;
  xlabel('x');
  ylabel('y');
  zlabel('f(x,y)');
  title(sprintf('Grafico 3D animado da otimizacao da funcao Himmelblau \nutilizando o metodo de Newoton com alpha = %.6f',aN));
  colormap jet;


endfunction

##function plotagrafico3DGradiente(todosXG,todosYG,todosZ,intervaloX,intervaloY,iN)
##  figure(2);
##  clf;
##  surf(intervaloX,intervaloY,todosZ); %plotando o grafico com a superficie
##  hold on;
##  grid on;
##  xlabel('x');
##  ylabel('y');
##  zlabel('f(x,y)');
##  title('Grafico 3D animado da otimizacao da funcao Himmelblau utilizando o metodo do Gradiente ');
##  colormap jet;
##
## endfunction


















endfunction
