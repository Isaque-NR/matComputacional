  function lista1_ex_7()

    % Bisseccao
    xli = 0.0; # limite inferior
    xls = 5.0; #limite superior
    tolerancia = 1e-5;
    xri = inf;

    todosXR = zeros(1,1000); # alocando o vetor para todos os valores de xr
    todosY = zeros(1,1000); # alocando o vetor para todos os valores de Y

    [raizEstimada,todosXR,todosY] = metodoBisseccao(xri,xli,xls,tolerancia);
    plotaGraficoAnimado(todosXR,todosY);
    plotaConvergenciaY(todosY);
    plotaConvergenciaX(todosXR);
end
  function resultado = funcao(x)

   resultado = 16.*x.*sin(x/10) - (37/2);

  end
  function [raizEstimada,todosXR,todosY] = metodoBisseccao(x,xli,xls,tolerancia)


  for i = 1:1000

    xr = (xli+xls)/2

    if funcao(xli)*funcao(xr) < 0 # primeira metade
      xls = xr;
    elseif funcao(xli)*funcao(xr) > 0 # segunda metade
      xli = xr;

    endif

    if abs(x - xr) <= tolerancia
      todosXR(i) = xr;
      todosY(i) = funcao(xr);
      break;
    endif

    x = xr;
    todosY(i) = funcao(xr);
    todosXR(i) = xr; # salvando as raizes estimadas no vetor
    raizEstimada = xr;
  endfor
    todosY = todosY(1:i);
    todosXR = todosXR(1:i); # truncando o vetor pra quando achar a raiz
    fprintf("A raiz da funcão f(x) = 16*x*sin(x/10) - (37/2) foi encontrada em %d interacoes no qual : f(%.5f) = %.5f a ",i,raizEstimada,funcao(raizEstimada));


end
  function plotaGraficoAnimado(X,Y)

    intervaloX = 0:0.01:5;
    figure(3);

    for cont = 1:length(X)  # LEGENDAR A LINHA E BOLINHNA DO GRÁFICO
      clf;
      plot(intervaloX,funcao(intervaloX));
      title("Gráfico Animado encontrando a Raiz de f(x) = 16*x*sin(x/10) - (37/2)");
      xlabel("Intervalo x");
      ylabel("raizes de funcao(x)");
      hold on;
      plot(X(cont),Y(cont),'linewidth', 2, 'color', [0 0 0], 'marker',
      'o', 'markersize', 4, 'markerfacecolor', [0 0 1]);
      set(gca, 'fontsize', 14);
      pause(0.4);


    endfor

end

  function plotaConvergenciaY(Y)
    figure(1);
    hold on;
    plot(Y,'color',[1 1 0], 'linewidth', 2);
    set(gca, 'fontsize', 14);
    legend("y = funcao(x)");
    xlabel("Numero de interacoes");
    ylabel("Resultado da raiz estimada");
    title("Grafico de Convergencia de y = funcao(x)");
    grid on;

  end
  function plotaConvergenciaX(X)
    figure(2);
    hold on;
    plot(X,'color',[1 0 0], 'linewidth', 2);
    set(gca, 'fontsize', 14);
    legend("raiz estimada para funcao(x)");
    xlabel("Numero de interacoes");
    ylabel("Raiz estimada");
    title("Grafico de Convergencia da raiz estimada");
    grid on;

  end
