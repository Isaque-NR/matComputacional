function lista3_ex_16()
  clc
  % Gauss Jordan
  % funcao(x,y) = { 0,780x + 0,563y = 0,217
  %               { 0,913x + 0,659y = 0,254

  % Resultado esperado pela expressao x = inv(A)*b ---> x = 1 e y = -1

  A = [ 0.780, 0.563;
        0.913,0.659] % Matriz Termos Denpedentes

  b = [ 0.217 ;
        0.254; ] % Vetor coluna dos Termos Idenpendentes

  Aa = [A b];  % Matriz aumentada

  printf("Para o sistema:\n\n");
   for i = 1:size(Aa,1)
    fprintf("{");
    for j = 1:size(Aa,1)
      if Aa(i,j) < 0
        sinal = '-';
      else
        sinal = '+';
      endif
      fprintf(' %c%5.6fx%d ', sinal, abs(Aa(i,j)), j); % termos dependentes
    endfor
    fprintf("= ");
    if Aa(i,end) < 0
        sinal = '-';
      else
        sinal = '+';
      endif
    fprintf("%c%5.6f",sinal,abs(Aa(i,end))); %termos idependentes
    printf("\n");
  endfor

  printf("\nResultado esperado pela inversao da Matriz: \n");
  Resperado= inv(A)*b % x(1) para a primeira equação e x(2) para a segunda etc...

  printf("Matriz Aumentada: \n");
  Aa

  printf("\nMatriz apos Pivotamento: \n");
  Aa = pivotamento(Aa)


  printf("Matriz apos Gauss Jordan: \n");
  Aa = gaussJordan(Aa)

  printf("solucao do sistema: \n");
  vetResultados = Aa(:, end);
  for k = 1:size(Aa,1)
    fprintf("x(%d) = %5.6f\n",k,vetResultados(k));
  endfor

end

function Mp = pivotamento(Mt)
  % colocar os maiores valores na diagonal principal

  for i = 1 : length(Mt)-1

      [v, pos] = max(abs(Mt(i:end,i))); % pos retorna a posicao que ta o maior valor da coluna, v(valor) ignoro
      pos = pos + i-1; % ajustando pra pegar o elemento abaixo da diagonal principal
      Mtemp = Mt(i,:); % salvando os valores da matriz base
      Mt(i,:) = Mt(pos,:); % trocando a linha com o maior valor
      Mt(pos,:) = Mtemp;

  endfor

  Mp = Mt;

end

function MtE = gaussJordan(Mt)

  %Eliminacao Progressiva zerar os elementos abaixo da diagonal principal com o fator
  for i = 1: size(Mt, 1)
    Mt(i,:) = Mt(i,:) / Mt(i,i); % normalizando toda a linha ou seja toda a linha dividida pelo pivo
   for j = i+1 : size(Mt, 1)
     fator = Mt(j,i)/Mt(i,i);
     Mt(j,:) = Mt(j,:) - (fator*Mt(i,:));
   endfor
  endfor

  %Eliminacao Regressiva % zerar os elementos acima da diagonal principal com o fator

  for i = size(Mt,1):-1 : 1
    for j = i-1:-1:1
     fator = Mt(j,i)/Mt(i,i);
     Mt(j,:) = Mt(j,:) - (fator*Mt(i,:));
    endfor
  endfor

 MtE = Mt;

end
