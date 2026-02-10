  function lista1_ex_7()

    % Metodo Bisseccao
    xli = 0.0; # limite inferior
    xls = 5.0; #limite superior
    tolerancia = 1e-5;
    xri = inf;

    todosXR = zeros(1,1000); # alocando o vetor para todos os valores de xr raizes estimadas
    todosY = zeros(1,1000); # alocando o vetor para todos os valores de Y resultado de y = f(x) para cada raiz estimada

    [raizEstimada,todosXR,todosY] = metodoBisseccao(xri,xli,xls,tolerancia);
    plotaGraficoAnimado(todosXR,todosY);
    plotaConvergenciaY(todosY);
    plotaConvergenciaX(todosXR);
end

  function resultado = funcao(x)

   resultado = 16.*x.*sin(x./10) - (37/2);

end

function [xr,todosXR,todosY] = metodoBisseccao(xri,xli,xls,tolerancia)


  for i = 1:1000

    xr = (xli+xls)/2;
    printf("Raiz estimada: %.6f\n",xr);
    %xr = xls - (funcao(xls) * (xli - xls)) / (funcao(xli) - funcao(xls)) %metodo falsa posição

    if funcao(xli)*funcao(xr) < 0 # primeira metade
      xls = xr;
    elseif funcao(xli)*funcao(xr) > 0 # segunda metade
      xli = xr;
    endif

    if abs(xri - xr) <= tolerancia
      todosXR(i) = xr;
      todosY(i) = funcao(xr);
      break;
    endif

    xri = xr;
    todosY(i) = funcao(xr);
    todosXR(i) = xr; # salvando as raizes estimadas no vetor
  endfor
    todosY = todosY(1:i);
    todosXR = todosXR(1:i); # truncando o vetor pra quando achar a raiz
    printf("A raiz da funcão f(x) = 16*x*sin(x/10) - (37/2) foi encontrada em %d interacoes no qual : f(%.6f) = %.6f a ",i,xr,funcao(xr));


end

  function plotaGraficoAnimado(X,Y)

    intervaloX = 0:0.01:5; % da pra generalizar isso aq
    figure(3);

    for cont = 1:length(X)  # LEGENDAR A LINHA E BOLINHNA DO GRÁFICO
      clf;
      g1 = plot(intervaloX,funcao(intervaloX));
      title("Gráfico Animado encontrando a Raiz de f(x) = 16*x*sin(x/10) - (37/2)");
      xlabel("Intervalo x");
      ylabel("raizes de funcao(x)");
      hold on;
      g2 = plot(X(cont),Y(cont),'linewidth', 2, 'color', [0 0 0], 'marker',
      'o', 'markersize', 3, 'markerfacecolor', [0 0 1]);
      set(gca, 'fontsize', 14);
      legend([g1,g2],'f(x) = 16x sin(x/10) - 37/2','Aproximacao da raiz');
      grid on;
      pause(0.4);

    endfor

end

  function plotaConvergenciaY(Y)
    figure(1);
    %hold on;
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
    %hold on;
    plot(X,'color',[1 0 0], 'linewidth', 2);
    set(gca, 'fontsize', 14);
    legend("raiz estimada para funcao(x)");
    xlabel("Numero de interacoes");
    ylabel("Raiz estimada");
    title("Grafico de Convergencia da raiz estimada");
    grid on;

  end
