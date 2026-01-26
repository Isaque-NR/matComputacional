function anotacoes()

Otimizacao

metodo de newton muda uma linha ao de newton raphosn
x1 = x0 - inv(H(x0))*f(x0)
metodo gradiente
x1 = x0 - a*gf(x0)
f(x,y)

Gradiente de f(x)  = |@f/@x|
                     |@f/@y|



Haussiana = |@²f(x,y)/@x@x , @²f(x,y)/@x@y| %obs derivar emcima do gradiente que já a primeira derivada
            |@²f(x,y)/@y@x , @²f(x,y)/@y@y|



Para saber se chegou num ponto critico, faz o gradiente do ponto encontrado
gradiente mostra a direcao do ponto critico, é uma funcao tangente a funcao,
se for 0 a tangente esta reta ou seja, encontrou o ponto critico

Como sabe se é minimo ou maximo? calcula a Haussiana no ponto encontrado
- todos alto valores positivos - Haussiana definida-positiva, é um ponto minimo
- todos alto valores negativos - Haussiana definida-negativa, é um ponto maximo
alto valores = 0 - Ponto Cela




Graficos 3d:

-preecher matriz z com os valores da funcao para o intervalo de x e y

grafico animado:












endfunction


