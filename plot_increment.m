clearvars;
sfunction = 'Rosenbrock';
% all function name Ellipsoid Ackley Rastrigin Griewank Rosenbrock
sdimension = '30';
evaluation = 800;
sevaluation = string(evaluation);
file = append(sfunction,sdimension,'-',sevaluation);
%file = 'Rosenbrock10-800';
file_incre = append('increment',file);
load(file_incre);
h1 = plot(200:1:evaluation,mean(fmin_record,2),'blue');
hold on

f= plot([0,200],[mean(fmin_record(1,:),2),mean(fmin_record(1,:),2)],'--');
f.Color = 'blue';
hold on
title(append(file,' ',' - vari dimension ',sdimension))
xlabel('iteration number');
ylabel('result  value');
ylabel('result value');
file_BO = append('BO',file);
load(file_BO);
hold on
%plot(0:1:200,mean(fmin_record(1,:),2))
h2 = plot(200:1:evaluation,mean(fmin_record,2),'red');

p= plot([0,200],[mean(fmin_record(1,:),2),mean(fmin_record(1,:),2)],'--');
p.Color = 'red';
hold on
legend([h1,h2],'increment learning','Bayesian Optimization');
