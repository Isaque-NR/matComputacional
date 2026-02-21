




function vetY = f(vetX)

  x = vetX(1);
  y = vetX(2);

  vetY = %funcao
endfunction

function gradiente = gf(vetX)

  x = vetX(1);
  y = vetX(2);

  gradiente = nan(length(x),1);

  gradiente(1) = %
  gradiente(2) = %

endfunction



function haussiana = H(vetX)

   x = vetX(1);
   y = vetX(2);

   haussiana = nan(length(vetX),length(vetX));

   haussiana(1,1) =
   haussiana(1,2) =
   haussiana(2,1) =
   haussiana(2,2) =

endfunction

function [pontosOtimosN,todosXN,todosYN] = metodoNewton(x0,a,maxItr,tol)

  todosXN = nan(maxItr+1,length(x0));
  todosYN = nan(maxItr+1);
  c = 1;
  todosXN(c,:) = x0;
  todosYN(c) = f(xo);

  for i = 1:maxItr

    x1 = x0 - a*(H(x0)\gf(x0));   % x1 = x0 - a*gf(x0); metodo gradiente
    c = c+1;
    todosXN(c,:) = x1;
    todosYN(c) = f(x1);

    if max(abs(x0-x1)) <= tol
      x0 = x1;
      break;
    endif
    x0 = x1;
  endfor

  todosXN = todosXN(1:c,:);
  todosYN = todosYN(1:c);
  pontosOtimosN = x0;

endfunction

function plotaGrafico3d(todosX,todosY)

  %superficie 7
  intervaloX = linspace(-6,6,500);
  intervaloY = linspace(-6,6,500);
  [X,Y] = meshgrid(intervaloX,intervaloY);
  todosZ = nan(length(intervaloY),length(intervaloX));

  for i = 1:length(intervaloX)
    for j = 1:length(intervaloY)
      todosZ(j,i) = f([intervaloX(i),intervaloY(j)]);
    endfor
  endfor
  %plotagem 5

  fig(1); clf; hold on; grid on; colormao jet;
  surf(X,Y,todosZ);
  view(3);
  xlabel('x');ylabel('y');zlabel('f(x,y)');
  title(sprintf('...'));

  %animacao 6

  plot3(todosX(:,1),todosX(:,2),todosY,'--m','linewidth',3);
  ponto = plot3(todosX(1,1),todosX(1,2), todosY(1), 'wo','markerfacecolor','w','markersize',6);

  for k = 1:size(todosX,1);
    set(ponto,'XData',todosX(k,1),'YData',todosX(k,2),'ZData',todosY(k));
    drawnow;
    pause(2);
  endfor

  endfunction
