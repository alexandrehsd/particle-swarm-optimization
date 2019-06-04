/* FEDERAL UNIVERSITY OF RIO GRANDE DO NORTE
   STUDENT: ALEXANDRE HENRIQUE SOARES DIAS
   
   Particle-Swarm Optimization for the function
   w1 = r + z, 
   
   where:
   z = -x.*sin(sqrt(abs(x))) - y.*sin(sqrt(abs(y))), in -500:5:500 -> x,y
   r = 100*(y-x.^2).^2+(1-x).^2, in -2:0.02:2 -> x,y
*/

// Executing file with functions
exec('./pso_functions.sci',-1);

// Population size
pop_sz = 60;

// Function limits

upper_lim = 500;
lower_lim = -500;
vel_max = 50;
vel_min = -50;
dim = 2;

w = 0.7;
c1 = 0.5;
c2 = 0.5;

/* INITIALIZING THE PARTICLES AND RELEVANT FEATURES */

// Generating initial random population
for i = 1:pop_sz
    for j = 1:dim
        ind_pos(i,j) = (2*upper_lim)*rand(1,1,'uniform') + lower_lim;
        ind_vel(i,j) = vel_max*rand(1,1,'uniform');
    end
    ind_pbest(i,:) = ind_pos(i,:);
end

// Getting the minimum fitness value (first global best position)
for i = 1:pop_sz
    fitness_vec(i) = fit(ind_pbest(i,:));
end
[minimum, index] = min(fitness_vec);
Gbest = ind_pos(index,:);

/* MAIN LOOP OF THE ALGORITHM */
//exec('./func_graphics.sci')
epoch = 1;
s = linspace(1,30,60);
c = linspace(0,1,60);

while epoch < 240
    for i = 1:pop_sz
        ind_pos(i,:) = update_pos(ind_pos(i,:), ind_vel(i,:), upper_lim, lower_lim);
        ind_vel(i,:) = update_vel(ind_vel(i,:), ind_pos(i,:), w, c1, c2, ind_pbest(i,:), Gbest, vel_max, vel_min);
        
        ind_pbest(i,:) = update_pbest(ind_pbest(i,:), ind_pos(i,:));
    end
    Gbest = getGlobal_best(Gbest, ind_pbest(:,:), pop_sz);
    epoch = epoch + 1;
    
    a = ind_pos(:,1);
    b = ind_pos(:,2);
    
    if modulo(epoch, 20) == 0
        clf
    end
    scatter(a,b,s,c, "fill");
    sleep(200);
end






   

