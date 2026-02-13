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

 grau = graus(1); % MUDE AQUI  para definir o grau da regressao polinomial

 printf("Regressão Polinomial de grau %d\n ", grau);

 coeficientes = regressaoPolinomial(x,y,grau)% chamando funcao do metodo numerico
## imprimirPolinomio(coeficientes);
##
## yEstimado = avaliarPolinomimo(coeficiente,xEstimado);
## printf("Valor estimado em x = %d: %0.6f\n",xEstimado,yEstimado);
##
##[r2,r] = calcularR2(x,y,coeficientes);
##printf("r^2 = %.6f\n",r2);
##printf("r = %.6f\n",r);
##
##plotarGrafico(x,y,coeficientes,grau);
endfunction

function coeficientes = regressaoPolinomial(x,y,grau)

  pontos = length(x);
  A = zeros(pontos,grau+1); % alocando matriz com zeros/ linnhas pontos e coluna coeficientes do polinomio

  for i = 1:pontos
    for j = 0:grau
      A(i,j+1) = x(i)^(grau-j);
    endfor
  endfor

  coeficientes =  (A'  * A) \ (A' * y) ; % resolvendo o sistema linear

  endfunction



