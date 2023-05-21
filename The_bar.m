clearvars;
sfunction = 'Rosenbrock';
% all function name Ellipsoid Ackley Rastrigin Griewank Rosenbrock
sdimension = '30';
sevaluation = 2000;
time = zeros(1,2);
load(strcat('BO_time',sfunction,num2str(sdimension),'-',num2str(sevaluation)));
time(1) = t;
load(strcat('GA_time',sfunction,num2str(sdimension),'-',num2str(sevaluation)));
time(2) = t;                                        
y1 = time(1,1:2);
x1 ={'Bayesian Optimization ', ' Genetic Algorithm'};
bar(log2(time),'m');
set(gca,'XTickLabel',x1)
title(append(sfunction,'-',num2str(sevaluation),' ',' - vari dimension ',sdimension))
xlabel('ALgorithm  type');
ylabel('Time (Unit: 2^n s)');


% clearvars;
% sfunction = 'Rosenbrock';
% all function name Ellipsoid Ackley Rastrigin Griewank Rosenbrock
% sdimension = '30';
% time = zeros(1,6);
% load(strcat('BO_time',sfunction,num2str(sdimension),'-500'));
% time(1) = t;
% load(strcat('BO_time',sfunction,num2str(sdimension),'-800'));
% time(2) = t;
% load(strcat('BO_time',sfunction,num2str(sdimension),'-2000'));
% time(3) = t;
% load(strcat('GA_time',sfunction,num2str(sdimension),'-500'));
% time(4) = t;
% load(strcat('GA_time',sfunction,num2str(sdimension),'-800'));
% time(5) = t;
% load(strcat('GA_time',sfunction,num2str(sdimension),'-2000'));
% time(6) = t;
% 
% subplot(2,1,1);
% y1 = time(1,1:3);
% x1 ={'500', '800', '2000'};
% bar(y1,'m');
% set(gca,'XTickLabel',x1)
% title(append('BP  ',sfunction,' ',' - vari dimension ',sdimension))
% xlabel('Evaluation number (Unit: times)');
% ylabel('Time (Unit: s)');
% subplot(2,1,2);
% y2 = time(1,4:6);
% x2 ={'500', '800', '2000'};
% bar(y2,'c');
% set(gca,'XTickLabel',x2)
% title(append('GA  ',sfunction,' ',' - vari dimension ',sdimension))
% xlabel('Evaluation number (Unit: times)');
% ylabel('Time (Unit: s)');
