clc;
clear;
close all;

R1 = 1e3;      % 1 kohm
R2 = 1e3;      % 1 kohm
R3 = 10e3;     % 10 kohm
R4 = 15e3;     % 15 kohm

C1 = 0.1e-6;   % 0.1 uF
C2 = 0.1e-6;   % 0.1 uF

K = 1 + R4/R3;

fprintf('Ganancia K = %.2f\n',K);

a2 = R1*R2*C1*C2;

a1 = R2*C1 + R1*C1 + R1*C2*(1-K);

a0 = 1;

b0 = K;

fprintf('a2 = %.4e\n',a2);
fprintf('a1 = %.4e\n',a1);
fprintf('a0 = %.4f\n',a0);
fprintf('b0 = %.4f\n',b0);

A = [0 1;
    -a0/a2 -a1/a2];

B = [0;
     b0/a2];

C = [1 0];

D = 0;

disp('Matriz A:')
disp(A)

disp('Matriz B:')
disp(B)


Vo0 = 1;
dVo0 = 0;

x0 = [Vo0;
      dVo0];


Vin = 1;

tspan = [0 0.005];


f = @(t,x) [ ...
    x(2); ...
    (-a0*x(1) - a1*x(2) + b0*Vin)/a2 ...
];


[t,x] = ode45(f,tspan,x0);


Vo = x(:,1);
dVo = x(:,2);


figure;

plot(t,Vo,'LineWidth',1.5);

grid on;

xlabel('Tiempo [s]');
ylabel('V_o [V]');
title('Voltaje de salida V_o(t)');

%% Graficar derivada del voltaje

figure;

plot(t,dVo,'LineWidth',1.5);

grid on;

xlabel('Tiempo [s]');
ylabel('dV_o/dt [V/s]');
title('Derivada del voltaje de salida');

%% Graficar ambos estados

figure;

plot(t,Vo,'LineWidth',1.5);
hold on;

plot(t,dVo,'LineWidth',1.5);

grid on;

xlabel('Tiempo [s]');
ylabel('Estados');
title('Respuesta del sistema');

legend('V_o(t)','dV_o/dt');