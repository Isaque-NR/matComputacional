function lista5_ex_4 ()
clc;
x = 1:9; %criando vetor com os valores passaodos
x = x'; % traspondo para ficar vetor coluna
y = [1;
     1.15;
     2;
     3;
     4;
     5;
     8;
     10;
     13;];

 xEstimado = 2.5;
 graus = [ 1 , 2 ,11]; %graus dados

 grau = graus(2); % MUDE AQUI  para definir o grau da regressao polinomial

 printf("Regressão Polinomial de grau %d\n ", grau);

 coeficientes = regressaoPolinomial(x,y,grau); % chamando funcao do metodo numerico
 imprimirPolinomio(coeficientes);

 yEstimado = calcularPolinomio(coeficientes,xEstimado);
 printf("Valor estimado em x = %d: %0.6f\n",xEstimado,yEstimado);

[r2,r] = calcularR2(x,y,coeficientes);
printf("r^2 = %.6f\n",r2);
printf("r = %.6f\n",r);

plotarGrafico(x,y,coeficientes,grau,xEstimado,yEstimado);
endfunction

function coeficientes = regressaoPolinomial(x,y,grau)

  pontos = length(x);
  A = zeros(pontos,grau+1); % alocando matriz com zeros/ linnhas pontos e coluna coeficientes do polinomio

  for i = 1:pontos
    for j = 0:grau
      A(i,j+1) = x(i)^(grau-j);
    endfor
  endfor

  coeficientes =  (A'  * A) \ (A' * y) ; % resolvendo o sistema linear achando os coeficientes

endfunction

function  yEstimado = calcularPolinomio(coeficientes, xEstimado)

  grau = length(coeficientes) - 1;
  yEstimado = 0;

  for i = 1:length(coeficientes)
    expoente = grau - (i-1);
    yEstimado = yEstimado  + coeficientes(i) * xEstimado^expoente; % calculando o valor do polinomio no ponto, nos coeficientes achados
  endfor
endfunction

function [r2,r] = calcularR2(x,y,coeficientes)

  lx = length(x) ;
##  somay = 0;
##  for i = 1:lx
##    somay = somay + y(i); %fazendo a soma total
##  endfor
##  mediay = somay / lx; %calculando media de y
mediay = mean(y);

  yAjustado = zeros(lx,1);
  for i = 1:lx
    yAjustado(i) = calcularPolinomio(coeficientes,x(i));  %ajustando os valores
  endfor

##  St = 0;
##  for i = 1:lx
##    St = St + (y(i) - mediay)^2;
##  endfor
##
##  Sr = 0;
##  for i = 1:lx
##    Sr = Sr + (y(i) - yAjustado(i))^2;
##  endfor
  St = sum(y - mediay).^2;
  Sr = sum(y - yAjustado).^2;

  r2 = (St - Sr) / St;
  r = sqrt(r2);
endfunction

function imprimirPolinomio(coeficientes)

  l = length(coeficientes);
  printf('Polinômio ajustado:\nP(x) = ');

  for i = 1: l

    expoente = l - i;

    if expoente > 1
      fprintf('%.6fx^%d', coeficientes(i), expoente);
    elseif expoente == 1
      fprintf('%.6fx', coeficientes(i));
    else
      fprintf('%.6f', coeficientes(i));
    end

    if i < l
      fprintf(' + ');
    end

  end
  fprintf('\n');
endfunction

function plotarGrafico(x,y,coeficientes,grau,xEstimado,yEstimado)

  plotx = min(x) : 0.1 : max(x);
  ploty = zeros(length(plotx),1);

  for i = 1:length(plotx);
    ploty(i) = calcularPolinomio(coeficientes,plotx(i));
  endfor

  figure(1);
    plot(x, y, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
  hold on;
  plot(plotx, ploty, 'b-', 'LineWidth', 2);
  plot(xEstimado,yEstimado,'go', 'MarkerSize', 10,  'MarkerFaceColor', 'g');

  title(['Regressão Polinomial Grau ', num2str(grau)]);
  xlabel('x');
  ylabel('y');
  legend('Dados', 'Polinômio Ajustado','Ponto Estimdo');
  grid on;
  endfunction
