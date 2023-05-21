clearvars;
t1 = clock;
fun_name = 'Rastrigin';
time_run = 10;
% num_vari = 10;
for num_vari = [10,20,30]

    % design space
    [lower_bound,upper_bound] = Test_Function(fun_name,num_vari);
    max_evaluation = 800; % the max counting numbers
    num_initial = 200; % the quantity of initialized variables
    fmin_record = zeros(max_evaluation - num_initial,time_run);
    for run=1:time_run
        % the number of current generation
        iteration = 1;
        % the initial design set
        sample_x = rand(num_initial,num_vari).*(upper_bound-lower_bound) + lower_bound; % rand(num_initial,num_vari) is a matrix
        sample_y = feval(fun_name,sample_x);  % feval function is used to put variables in particular function
        evaluation =  size(sample_x,1); % size() is used to return the row number of matrix
        % print current best objective value
        fmin = min(sample_y); % min() is used to find the minimum value of an array
        fmin_record(iteration,run)=fmin;
        fprintf('BO on %s, run;%d, iteration: %d, evaluation: %d, best: %0.4g\n',fun_name,run,iteration,evaluation,fmin);
        GP_model = GP_Train(sample_x,sample_y,lower_bound,upper_bound,1,1E-6,1E2);
        % the BO iteration
        while evaluation < max_evaluation
            % finding a new point using the EI criterion ( EI is an acquisition function )
            best_x = Optimizer_GA(@(x)-Infill_EI(x,GP_model,fmin),num_vari,lower_bound,upper_bound,100,100);
            % finding a new point using the EI criterion ( EI is an acquisition function )
            %best_x = Optimizer_GA(@(x)-Infill_EI(x,model_new,fmin),num_vari,lower_bound,upper_bound,100,100);
            % evaluating the candidate with the real function
            best_y = feval(fun_name,best_x);
            % incremental learning
            GP_model = Kriging_Incremental_Update(GP_model,best_x,best_y);
            % add the new point to design set
            sample_x = [sample_x;best_x];
            sample_y = [sample_y;best_y];
            % update some parameters
            evaluation = size(sample_x,1);
            iteration = iteration + 1;
            fmin = min(sample_y);
            fmin_record(iteration,run)=fmin;
            % print current best objective value
            fprintf('BO on %s, run;%d, iteration: %d, evaluation: %d, best: %0.4g\n',fun_name,run,iteration,evaluation,fmin);
        end
    end
    t2 = clock;
    t=2 * etime(t2,t1);
    save(strcat('increment',fun_name,num2str(num_vari),'-',num2str(max_evaluation),'.mat'),'fmin_record');
    save(strcat('incremnt_time',fun_name,num2str(num_vari),'-',num2str(max_evaluation),'.mat'),'t');
end


