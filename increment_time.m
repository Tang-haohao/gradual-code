clearvars;
sfunction = 'Rosenbrock';
% all function name Ellipsoid Ackley Rastrigin Griewank Rosenbrock
time = zeros(1,6);
load(strcat('BO_time',sfunction,'10-800'));
time(1) = t;
load(strcat('BO_time',sfunction,'20-800'));
time(2) = t;
load(strcat('BO_time',sfunction,'30-800'));
time(3) = t;
load(strcat('incremnt_time',sfunction,'10-800'));
time(4) = t;
load(strcat('incremnt_time',sfunction,'20-800'));
time(5) = t;
load(strcat('incremnt_time',sfunction,'30-800'));
time(6) = t;

% subplot(2,1,1);
% y1 = time(1,1:3);
% x1 ={'10', '20', '30'};
% bar(y1,'m');
% set(gca,'XTickLabel',x1)
% title(append('BP  ',sfunction,'max evaluation=800'))
% xlabel('Vari dimension');
% ylabel('Time (Unit: s)');
% subplot(2,1,2);
% y2 = time(1,4:6);
% x2 ={'10', '20', '30'};
% bar(y2,'c');
% set(gca,'XTickLabel',x2)
% title(append('increment  ',sfunction,'max evaluation=800'))
% xlabel('Vari dimension');
% ylabel('Time (Unit: s)');

y1 = time(1,1:6);
x1 ={'BO 10','BO 20','BO 30','incre 10','incre 20','incre 30'};
bar(time,'m');
set(gca,'XTickLabel',x1)
title(append(sfunction))
xlabel('Type');
ylabel('Time (Unit: s)');



