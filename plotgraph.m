clearvars;
sfunction = 'Rosenbrock';
% all function name Ellipsoid Ackley Rastrigin Griewank Rosenbrock
sdimension = '30';
evaluation = 2000;
sevaluation = string(evaluation);
file = append(sfunction,sdimension,'-',sevaluation);
%file = 'Rosenbrock10-800';
file_GA = append('GA',file);
load(file_GA);
plot(50:50:evaluation,mean(fmin_record,2),'blue');
hold on
title(append(file,' ',' - vari dimension ',sdimension))
xlabel('iteration number');
ylabel('result  value');
ylabel('result value');
file_BO = append('BO',file);
load(file_BO);
hold on
%plot(0:1:200,mean(fmin_record(1,:),2))
plot(200:1:evaluation,mean(fmin_record,2),'red')

p= plot([0,200],[mean(fmin_record(1,:),2),mean(fmin_record(1,:),2)],'--');
p.Color = 'red';
hold on
legend('Genetic algorithm','Bayesian Optimization');
