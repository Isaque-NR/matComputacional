function ex_revisao()

  % h -> profundidade de submersao
  % f(h) = h^3 -0.2h^2 + 0.05h - 1.2 = 0
  % intervalo 1.0, 1.5
  % tolerancia 10^-5 e maximo de interacoes 1000
  %metodo Bissecao
  clc;
  hri = inf;
  tol = 1e-5;
  maxItr = 1000;
  hli = 1.0;
  hls = 1.5;
  todosHR = zeros(1,maxItr);
  todosY = zeros(1,maxItr);

  [raizEstimada,todosHR,todosY] = metodoBissecao(hri,hli,hls,tol,maxItr);
  plotaGraficoAnimado(todosHR,todosY,hli,hls);
  plotaGraficoX(todosHR);
  plotaGraficoY(todosY);



endfunction

function y = f(h)

  y = h.^3 -0.2 .*h.^2 + 0.05 .*h - 1.2;

endfunction
function [raizEstimada,todosHR,todosY] = metodoBissecao(hri,hli,hls,tol,maxItr)

  for i = 1:maxItr

    raizEstimada = (hli+hls)/2;
    %raizEstimada = hls - (f(hls)*(hli-hls))/(f(hli)-f(hls));
    todosHR(i) = raizEstimada;
    todosY(i) = f(raizEstimada);
    printf("Raiz estimada: %0.6f na interacao: %d \n",raizEstimada,i);

    if f(hli)*f(raizEstimada) < 0
      hls = raizEstimada;
    elseif f(hli)*f(raizEstimada) > 0
      hli = raizEstimada;
    endif

    if abs(hri-raizEstimada) <= tol
      break;
    endif
    hri = raizEstimada;
  endfor
   todosHR = todosHR(1:i)
   todosY = todosY(1:i);

endfunction

function plotaGraficoX(todosHR);

  figure(1);
  hold on;
  plot(todosHR,'linewidth',2,'color',[0 1 0]);
  set(gca,'fontsize',14);
  xlabel("Numero de Iteracoes");
  ylabel("Raizes estimadas para f(h)");
  title("Grafico de Convergencia das raizes estimadas");
  legend("raizes estimadas de f(h)");

endfunction

function plotaGraficoY(todosY)

  figure(2);
  hold on;
  plot(todosY,'linewidth',2,'color',[1 0 0]);
  xlabel("Numero de Iteracoes");
  ylabel("y = f(h) das raizes estimadas");
  title("Grafico de Convergencia de y = f(h)");
  legend("y = f(h)");
  set(gca,'fontsize',14);

endfunction

function plotaGraficoAnimado(todosHR,todosY,hli,hls)

  intervaloX = hli:0.01:hls;
  figure(3);
  for i = 1:length(todosHR)
    clf;
    g1 = plot(intervaloX,f(intervaloX),'linewidth',2);
    xlabel("intervalo de busca");
    ylabel("y = f(h) no intervalo");
    hold on;
    g2 = plot(todosHR(i),todosY(i),'marker','o','markersize',6,'markerfacecolor',[0 0 0]);
    set(gca,'fontsize',14);
    legend([g1,g2],"f(h)","raizes estimadas");
    title("Grafico Animado mostrando o encontro da raiz de f(h)");
    pause(0.4);

  endfor
endfunction



















