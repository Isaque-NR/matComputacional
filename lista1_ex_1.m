function lista1_ex_1 ()

 xri = inf;
 maxItr = 1000;
 tol = 1e-5;
 xli = 0.0;
 xls = 1.0;

 [raizEstimada,todosXR,todosY] = metodoBissecao(xri,xli,xls,maxItr,tol);

 plotaGraficoAnimado(todosXR,todosY,xli,xls);
 plotaGraficoX(todosXR);
 plotaGraficoY(todosY);

endfunction

function y = f(x)

  y = x.^3 + 2 .*x.^2 -2 ;

endfunction

function [raizEstimada,todosXR,todosY] = metodoBissecao(xri,xli,xls,maxItr,tol)

  todosXR = zeros(1,maxItr);
  todosY = zeros(1,maxItr);
  for i = 1:maxItr

   raizEstimada = (xli+xls)/2;
   todosXR(i) = raizEstimada;
   todosY(i) = f(raizEstimada);
   printf("Raiz Estimada: %.6f\n",raizEstimada);

   if f(xli)*f(raizEstimada) < 0 %primeira metade
     xls = raizEstimada;

   elseif f(xli)*f(raizEstimada) > 0 %segunda metade
     xli = raizEstimada;
   endif

   if abs(xri-raizEstimada) <= tol
     break
   endif

   xri = raizEstimada;

 endfor
    todosXR = todosXR(1:i);
    todosY = todosY(1:i);
    printf("A raiz estimada é %.4f",raizEstimada);
endfunction

function plotaGraficoAnimado(todosXR,todosY,xli,xls)

  intervaloX = xli:0.01:xls;
  figure(3);
  for i = 1:length(todosXR)
     clf;
     g1 = plot(intervaloX,f(intervaloX));
     set(gca,'fontsize',14);
     title("Grafico de f(x)");
     xlabel("intervalo de X");
     ylabel("raizes de f(x) para cada intervalo");
     hold on;
     g2 = plot(todosXR(i),todosY(i),'linewidth',2,'color',[0 0 0], 'marker','o','markersize',4,'markerfacecolor',[1 0 0]);
     set(gca,'fontsize',14);
     legend([g1,g2],'f(x)','raizes estimadas');
     pause(0.4);
  endfor

endfunction

function plotaGraficoX(todosXR)

  figure(1);
  plot(todosXR,'linewidth',2,'color',[0 1 0]);
  set(gca,'fontsize',14);
  %legendar...

endfunction

function plotaGraficoY(todosY)

  figure(2);
  plot(todosY,'linewidth',2,'color',[0 0 1]);
  set(gca,'fontsize',14);
  %legendar...

endfunction


