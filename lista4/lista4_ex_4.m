function lista4_ex_4 ()
  clc;
  x0 = [2.5 ; 2.5];
  maxItr = 1000;
  tol = 1e-3;
  aN = 1; %  0,0001 <= alpha <= 10 (nao sei pq alpha maior que 3 quebra o grafico 3d
  aG = 0.01; % alphas diferentes pois o metodo do gradiente nao estava convergindo com alpha = 1, estava dando NaN

  %chamada dos metodos
  [pontoOtimoN,iN,todosXN,todosYN] = metodoNewton(x0,aN,maxItr,tol);
  printarInfo('Newthon',pontoOtimoN,todosXN,todosYN,iN,aN);
  [pontoOtimoG,iG,todosXG,todosYG] = metodoGradiente(x0,aG,maxItr,tol); % nota se que o metodo nao chegou ao ponto otimo previsto (3,2)
  printarInfo('Gradiente',pontoOtimoG,todosXG,todosYG,iG,aG);
   %chamadas para as funcoes de graficos
   plotagrafico3D(1,'Newthon',pontoOtimoN,todosXN,todosYN,iN,aN);
   pause(1); % pausa pra acabar a animacao do primiero grafico / ou um keyboard
   plotagrafico3D(2,'Gradiente',pontoOtimoG,todosXG,todosYG,iG,aG);
   pause(1);
   plotaconvergenciaX(3,'Newthon',todosXN);
   pause(1);
   plotaconvergenciaX(4,'Gradiente',todosXG); % nao chega em (3,2) mas esta convergindo bom sinal
   pause(1);
   plotaconvergenciaY(5,'Newthon',todosYN);
   pause(1);
   plotaconvergenciaY(6,'Gradiente',todosYG); %converngindo pra zero
   pause(1);


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
  c = 1; %contador seprado da iteração pra evitar iN+1
  todosXN(c,:) = x0;
  todosYN(c) = f(x0);

  for iN = 1:maxItr
    x1 = x0 - a*(H(x0)\gf(x0));
    c = c+1;
    todosXN(c, :) = x1;
    todosYN(c) = f(x1);

    if max(abs(x1-x0)) <= tol
      x0 = x1;
      break
    endif
    x0 = x1;
  endfor

  todosXN = todosXN(1:c, : ); %truncando o vetor
  todosYN = todosYN(1:c);
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

##function [todosZ,intervaloX,intervaloY] = superficie() %funcao para preencher a matriz Z que vai ser a superficie do grafico 3D
##  intervaloX = linspace(-6,6,500); %intervalos para os espacamentos q estao na figura da lista
##  intervaloY = linspace(-6,6,500);
##
##  todosZ = nan(length(intervaloY),length(intervaloX));
##
##  for i = 1:length(intervaloX) % matriz contendo os resultados de fa funcao para cada (x,y)
##    for j = 1:length(intervaloY)
##        todosZ(j,i) = f([intervaloX(i);intervaloY(j)]); %preenchimento da matriz Z com o valor da funcao para cada intervalo de x e y, (j,i) pq o octave preenche linha por coluna
##    endfor
##  endfor
##
##endfunction
##
##function plotagrafico3D(fig,metodo,pontoOtimo,todosX,todosY,todosZ,intervaloX,intervaloY,i,a)
##  figure(fig); % na chamada passa um valor pra criar a figura e nao sobrescrever os graficos entre si
##  n = size(todosX,1); %pegando a quantidade de dados
##  clf;
##  surf(intervaloX,intervaloY,todosZ); %plotando o grafico com a superficie
##  hold on;
##  grid on;
##  xlabel('x');
##  ylabel('y');
##  zlabel('f(x,y)');
##  title(sprintf('Grafico 3D animado da otimizacao da funcao Himmelblau \nutilizando o metodo de %s com alpha = %.6f\nNo ponto inicial (%.6f , %.6f)\n O ponto otimo encontrado foi: (%.6f, %.6f) em %d iteracoes',metodo,a,todosX(1,1),todosX(1,2),pontoOtimo(1),pontoOtimo(2),i));
##  colormap jet;
##  plot3(todosX(:,1),todosX(:,2),todosY,'--','linewidth',3,'color',[1 0 1]); % linha dos trajetos
##  ponto = plot3(todosX(1,1),todosX(1,2),todosY(1),'-o', 'markerfacecolor','w','markersize',6,'color','w');  % ? erro q acontece error: set: invalid handle (= -37.4789)
##  for k = 1:n
##    set(ponto,'XData',todosX(k,1),'YData',todosX(k,2),'ZData',todosY(k));
##    drawnow;
##    pause(2);
##  endfor
##endfunction

function plotagrafico3D(fig, metodo, pontoOtimo, todosX, todosY, iter, a)
  % --- 1. CRIACAO DA SUPERFICIE ---
  intervaloX = linspace(-6, 6, 500);
  intervaloY = linspace(-6, 6, 500);
  [X, Y] = meshgrid(intervaloX, intervaloY);

  todosZ = nan(length(intervaloY),length(intervaloX));

  for i = 1:length(intervaloX) % matriz contendo os resultados de fa funcao para cada (x,y)
    for j = 1:length(intervaloY)
        todosZ(j,i) = f([intervaloX(i);intervaloY(j)]); %preenchimento da matriz Z com o valor da funcao para cada intervalo de x e y, (j,i) pq o octave preenche linha por coluna
    endfor
  endfor

  % --- 2. CONFIGURACAO E PLOTAGEM ---
  figure(fig); clf; hold on; grid on; colormap jet;
  surf(intervaloX, intervaloY, todosZ);
  view(3);

  xlabel('x'); ylabel('y'); zlabel('f(x,y)');
  title(sprintf('Otimizacao Himmelblau | %s | alpha = %.6f\nInicio: (%.6f, %.6f) | Otimo: (%.6f, %.6f) em %d iteracoes', ...
        metodo, a, todosX(1,1), todosX(1,2), pontoOtimo(1), pontoOtimo(2), iter));

  % --- 3. TRAJETO E ANIMACAO ---
  plot3(todosX(:,1), todosX(:,2), todosY, '--m', 'linewidth', 3);
  ponto = plot3(todosX(1,1), todosX(1,2), todosY(1), 'wo', 'markerfacecolor', 'w', 'markersize', 6);

  for k = 1:size(todosX, 1)
    set(ponto, 'XData', todosX(k,1), 'YData', todosX(k,2), 'ZData', todosY(k));
    drawnow;
    pause(0.5);
  endfor
endfunction

 function plotaconvergenciaX(fig,metodo,todosX) % convergencia para X
    figure(fig);
    clf;
    plot(todosX,'-o','markersize',7,'linewidth',3,'markerfacecolor','g');
    title(sprintf('Grafico de convergencia de X para funcao Himmelblau com o metodo de %s ',metodo),'fontsize',13);
    xlabel('Iteracoes','fontsize',12);
    ylabel('f(x,y)','fontsize',12);
    legend('x','y','fontsize',12)
    grid on;
  endfunction

  function plotaconvergenciaY(fig,metodo,todosY)  % convergencia para todosY  = valores para  f(x,y)
    figure(fig);
    clf;
    plot(todosY,'-o','markersize',7,'linewidth',3,'markerfacecolor','g','color','y');
    title(sprintf('Grafico de convergencia de f(x,y) para funcao Himmelblau com o metodo de %s ',metodo),'fontsize',13);
    xlabel('Iteracoes','fontsize',12);
    ylabel('f(x,y)','fontsize',12);
    legend('Valor encontrado em f(x,y)','fontsize',12)
    grid on;
  endfunction

  function printarInfo(metodo,pontoOtimo,todosX,todosY,i,a)
    printf('Utilizando o metodo %s com alpha = %.6f, o ponto otimo encontrado foi: (%.6f , %.6f), em %d iteracoes\n',metodo,a,pontoOtimo(1),pontoOtimo(2),i);
    printf('Distancia do ponto encontrado em relacao ao ponto otimo dado (3,2): %.6f\n', norm( pontoOtimo - [3;2]));
    printf('Valor de f(x,y) no ponto (%.6f , %.6f) = %.6f\n\n\n',pontoOtimo(1),pontoOtimo(2),todosY(end)); % pegando o valor de f(x,y) da ultima iteracao
  endfunction
endfunction
