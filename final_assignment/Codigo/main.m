%% Newton en una variable

disp(' --------------------------------')
disp('|Metodo de Newton en una variable|')
disp(' --------------------------------')
fplot(@ej1,[0 5])
line([0,5],[0,0], 'Color','black')
line([2.8456,2.8456],[-0.2,0.3], 'Color','black','LineStyle','--')
a = 1.5;

disp(['Resultados de buscar un cero de la funcion exp(-sqrt(x))*sin(x*log(1+x^2)) inicializando en x=', num2str(a)])

disp(' ')
disp(['Newton con derivada centrada -> Raiz: ', num2str(met_newton(a, @ej1))])
% Como corre muy rapido, para ver mejor la diferencia de tiempo lo corro
% 1000 veces con cada metodo
tStart1 = tic; 
for i=1:1000
    met_newton(a, @ej1);
end   
tEnd1 = toc(tStart1);
disp(['Elapsed time is ', num2str(tEnd1), ' seconds.'])  

disp(' ')
disp(['Newton con autodiff -> Raiz: ', num2str(met_newton_AD(a, @ej1_AD))])
tStart2 = tic; 
for i=1:1000
    met_newton_AD(a, @ej1_AD);
end
tEnd2 = toc(tStart2);
disp(['Elapsed time is ', num2str(tEnd2), ' seconds.'])  

disp(' ')
disp(['Con autodiff es unas ', num2str(round(tEnd1/tEnd2)), ' veces mas rapido'])

%% Newton para encontrar minimo en una variable

disp(' ----------------------------')
disp('|Newton para encontrar minimo|')
disp(' ----------------------------')

figure
fplot(@ej2,[-1 1])
line([0.70711,0.70711],[-0.25,0], 'Color','black','LineStyle','--')
legend({'f(x)= x^4 - x^2'},'Location','south')
figure
fplot(@ej2_AD,[-0.8 0.8])
line([-0.8,0.8],[0,0], 'Color','black')
line([0.70711,0.70711],[-2,6], 'Color','black','LineStyle','--')
legend({'f(x)= x^4 - x^2',"f'(x)","f''(x)"},'Location','north')
a = 3;
disp(['Resultados de buscar un cero de la funcion exp(-sqrt(x))*sin(x*log(1+x^2)) inicializando en x=', num2str(a)])

disp(' ')
disp(['Metodo de Newton con derivada centrada -> Minimo: ', num2str(met_newton_gral(a, @ej2))])
tStart1 = tic; 
for i=1:100
    met_newton_gral(a, @ej2);
end   
tEnd1 = toc(tStart1);
disp(['Elapsed time is ', num2str(tEnd1), ' seconds.'])  

disp(' ')
disp(['Metodo de Newton con autodiff -> Minimo: ', num2str(met_newton_gral_AD(a, @ej2_AD))])
tStart2 = tic; 
for i=1:100
    met_newton_gral_AD(a, @ej2_AD);
end
tEnd2 = toc(tStart2);
disp(['Elapsed time is ', num2str(tEnd2), ' seconds.'])  

disp(' ')
disp(['Con autodiff es unas ', num2str(round(tEnd1/tEnd2)), ' veces mas rapido'])


%% Gradiente

disp('---------------------------------------------------------------------')
disp('|Metodo del gradiente|')
disp(' -------------------')
rangox = -2.2:0.1:2.2;
rangoy = -1.4:0.1:1.4;
[X,Y] = meshgrid(rangox, rangoy);
n = size(X,1);
m = size(X,2);
Z = zeros(n,m);
for i=1:n
    for j=1:m
        Z(i,j) = ej4([X(i,j),Y(i,j)]);
    end
end
figure
surf(X,Y,Z)
a = [-0.5, 2.1];

disp(['Resultados de buscar un minimo de la funcion 2*x(1)^2 - 1.05*x(1)^4 + (x(1)^6)/6 + x(1)*x(2) + x(2)^2 inicializando en x=[', num2str(a(1)), ',', num2str(a(2)), ']'])
disp('Minimo global: x= [0,0]')

disp(' ')
disp(['Metodo del gradiente con derivada centrada -> Minimo: ', num2str(met_gradiente(a, @ej4))])

tic
for i=1:100
    met_gradiente(a, @ej4); 
end
toc

disp(' ')
disp(['Metodo del gradiente con autodiff -> Minimo: ', num2str(met_gradiente_AD(a, @ej4_AD))])

tic
for i=1:100
    met_gradiente_AD(a, @ej4_AD);  
end
toc

% Random restart
disp(' ')
disp(' -------------------')
disp('Resultados de buscar un minimo inicializando en 1000 puntos aleatorios distintos y quedandose con el mejor resultado (random restart)')
disp('(puntos uniformemente distribuidos en [-10,10]x[-10,10])')
best = [10, 10];
rng(10)
for i=1:1000
    s = rand([1,2])*20-10;
    m = met_gradiente(s, @ej4);
    if ej4(m)<ej4(best)
        best = m;
    end
end
disp(' ')
disp(['Metodo del gradiente con derivada centrada -> Minimo: ', num2str(best)])

best = [10, 10];
rng(10)
for i=1:1000
    s = rand([1,2])*20-10;
    m = met_gradiente_AD(s, @ej4_AD);
    if ej4(m)<ej4(best)
        best = m;
    end
end
disp(' ')
disp(['Metodo del gradiente con autodiff -> Minimo: ', num2str(best)])
disp(' ')
disp(['Con autodiff el error es menor'])
%% Gradientes conjugados

disp('---------------------------------------------------------------------')
disp('|Metodo de gradientes conjugados|')
disp(' -------------------------------')
rangox = -2.2:0.1:2.2;
rangoy = -1.4:0.1:1.4;
[X,Y] = meshgrid(rangox, rangoy);
n = size(X,1);
m = size(X,2);
Z = zeros(n,m);
for i=1:n
    for j=1:m
        Z(i,j) = ej4([X(i,j),Y(i,j)]);
    end
end
surf(X,Y,Z)
a = [-0.5, 2.1];

disp(['Resultados de buscar un minimo de la funcion 2*x(1)^2 - 1.05*x(1)^4 + (x(1)^6)/6 + x(1)*x(2) + x(2)^2 inicializando en x=[', num2str(a(1)), ',', num2str(a(2)), ']'])
disp('Minimo global: x= [0,0]')

disp(' ')
disp(['Metodo de gradientes conjugados con derivada centrada -> Minimo: ', num2str(met_gradientes_conjugados(a, @ej4))])

tic
for i=1:100
    met_gradientes_conjugados(a, @ej4); 
end
toc

disp(' ')
disp(['Metodo de gradientes conjugados con autodiff -> Minimo: ', num2str(met_gradientes_conjugados_AD(a, @ej4_AD))])

tic
for i=1:100
    met_gradientes_conjugados_AD(a, @ej4_AD);  
end
toc

% Random restart
disp(' ')
disp(' -------------------------------')
disp('Resultados de buscar un minimo inicializando en 1000 puntos aleatorios distintos y quedandose con el mejor resultado (random restart)')
disp('(puntos uniformemente distribuidos en [-10,10]x[-10,10])')
best = [10, 10];
rng(10)
for i=1:1000
    s = rand([1,2])*20-10;
    m = met_gradientes_conjugados(s, @ej4);
    if ej4(m)<ej4(best)
        best = m;
    end
end
disp(' ')
disp(['Metodo de gradientes conjugados con derivada centrada -> Minimo: ', num2str(best)])

best = [10, 10];
rng(10)
for i=1:1000
    s = rand([1,2])*20-10;
    m = met_gradientes_conjugados_AD(s, @ej4_AD);
    if ej4(m)<ej4(best)
        best = m;
    end
end
disp(' ')
disp(['Metodo de gradientes conjugados con autodiff -> Minimo: ', num2str(best)])
disp(' ')
disp(['Con autodiff el error es menor'])