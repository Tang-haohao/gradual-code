clearvars;
t1 = clock;
fun_name = 'Rastrigin';
for num_vari = [10,20,30]
    [lower_bound,upper_bound] = Test_Function(fun_name,num_vari);
    max_evaluation = 800;
    pop_size = 50;
    time_run = 20;
    fmin_record = zeros(max_evaluation/pop_size,5);
    
    for run=1:time_run
        % the number of current generation
        generation = 1;
        % the initial generation
        pop_vari = rand(pop_size,num_vari).*(upper_bound-lower_bound) + lower_bound;
        % calculate the objective values
        pop_fitness = feval(fun_name,pop_vari); % calculate the value of fitness
        evaluation = pop_size; % pop_size calculations every time
        fmin_record(generation,run) = min(pop_fitness);
        fprintf('GA on %d-D %s, run;%d,generation: %d, evaluation: %d, fmin: %0.4g\n',num_vari,fun_name,run,generation,evaluation,min(pop_fitness));
        % the evolution of the generation
        while evaluation < max_evaluation
            % parent selection using k-tournament (default k=2) selection
            k = 2;
            temp = randi(pop_size,pop_size,k);
            [~,index] = min(pop_fitness(temp),[],2);
            pop_parent = pop_vari(sum(temp.*(index == 1:k),2),:);
            % crossover (simulated binary crossover)
            % dic_c is the distribution index of crossover
            dis_c = 10;
            mu  = rand(pop_size/2,num_vari);
            parent1 = pop_parent(1:2:pop_size,:);
            parent2 = pop_parent(2:2:pop_size,:);
            beta = 1 + 2*min(min(parent1,parent2)-lower_bound,upper_bound-max(parent1,parent2))./max(abs(parent2-parent1),1E-6);
            alpha = 2 - beta.^(-dis_c-1);
            betaq = (alpha.*mu).^(1/(dis_c+1)).*(mu <= 1./alpha) + (1./(2-alpha.*mu)).^(1/(dis_c+1)).*(mu > 1./alpha);
            % the crossover is performed randomly on each variable
            betaq = betaq.*(-1).^randi([0,1],pop_size/2,num_vari);
            betaq(rand(pop_size/2,num_vari)>0.5) = 1;
            offspring1 = 0.5*((1+betaq).*parent1 + (1-betaq).*parent2);
            offspring2 = 0.5*((1-betaq).*parent1 + (1+betaq).*parent2);
            pop_crossover = [offspring1;offspring2];
            % mutation (ploynomial mutation)
            % dis_m is the distribution index of polynomial mutation
            dis_m = 20;
            pro_m = 1/num_vari;
            rand_var = rand(pop_size,num_vari);
            mu  = rand(pop_size,num_vari);
            deta = min(pop_crossover-lower_bound, upper_bound-pop_crossover)./(upper_bound-lower_bound);
            detaq = zeros(pop_size,num_vari);
            position1 = rand_var<=pro_m & mu<=0.5;
            position2 = rand_var<=pro_m & mu>0.5;
            detaq(position1) = ((2*mu(position1) + (1-2*mu(position1)).*(1-deta(position1)).^(dis_m+1)).^(1/(dis_m+1))-1);
            detaq(position2) = (1 - (2*(1-mu(position2))+2*(mu(position2)-0.5).*(1-deta(position2)).^(dis_m+1)).^(1/(dis_m+1)));
            pop_mutation = pop_crossover + detaq.*(upper_bound-lower_bound);
            pop_mutation  = max(min(pop_mutation,upper_bound),lower_bound);
            % fitness calculation
            pop_mutation_fitness = feval(fun_name, pop_mutation);
            % environment selection
            pop_vari_iter = [pop_vari;pop_mutation];
            pop_fitness_iter = [pop_fitness;pop_mutation_fitness];
            [~,win_num] = sort(pop_fitness_iter);
            pop_vari = pop_vari_iter(win_num(1:pop_size),:);
            pop_fitness = pop_fitness_iter(win_num(1:pop_size),:);
            % update the evaluation number and generation number
            generation = generation + 1;
            evaluation = evaluation + pop_size;
            fmin_record(generation,run) = min(pop_fitness);
            fprintf('GA on %d-D %s, run:%d,generation: %d, evaluation: %d, fmin: %0.4g\n',num_vari,fun_name,run,generation,evaluation,min(pop_fitness)) 
        end
    end
    t2 = clock;
    t=etime(t2,t1);
    save(strcat('GA',fun_name,num2str(num_vari),'-',num2str(max_evaluation),'.mat'),'fmin_record');
    save(strcat('GA_time',fun_name,num2str(num_vari),'-',num2str(max_evaluation),'.mat'),'t');
end