/* Fitness value calculated from the objective function
   
   arguments:
   ind_pos -> individual particle position
*/
function [fitness] = fit(ind_pos)
    x1 = ind_pos(1,1);
    x2 = ind_pos(1,2);
    
    c = -x1*sin(sqrt(abs(x1))) - x2*sin(sqrt(abs(x2)));
    d = 100*(x2-x1^2)^2+(1-x1)^2;
    
    fitness = c + d;
endfunction

/* Update the best position of a particle
   
   arguments:
   current_Pbest -> current best position achieved by the particle, dim = (1,2)
   ind_pos -> current individual position of a particle, dim(1,2)
*/
function [new_Pbest] = update_pbest(current_Pbest, ind_pos)
    if fit(ind_pos) < fit(current_Pbest) then
        new_Pbest = ind_pos;
    else
        new_Pbest = current_Pbest;
    end
endfunction

/*  Update the global best position of all particles
    
    arguments: 
    old_Gbest -> old Global best position vector, dim = (1,2)
    p_bests_vec -> best positions vector of all particles, dim = (1,2)
    pop_sz -> population size
*/
function [new_Gbest] = getGlobal_best(old_Gbest, p_bests_vec, pop_sz)
    // Getting the fitness vector p_bests_vec
    for i = 1:pop_sz
        fitness_vec(i) = fit(p_bests_vec(i,:));
    end
    
    // Getting the minimum fitness value (best position)
    [minimum, index] = min(fitness_vec);
    
    // Updating (or not) the global best position
    if minimum < fit(old_Gbest) then
        new_Gbest = p_bests_vec(index,:);
    else
        new_Gbest = old_Gbest;
    end
endfunction

/* Update the velocity of the particle

   arguments:
   old_vel -> old velocity of the particle
   ind_pos -> current individual particle position
   w -> inertia coefficient
   c1 -> cognitive parameter
   c2 -> social parameter
   ind_pbest -> best individual position
   Gbest -> Global best position
*/
function [new_vel] = update_vel(old_vel, ind_pos, w, c1, c2, ind_pbest, Gbest, vel_max, vel_min)
    r1 = rand(1,1,'uniform');
    r2 = rand(1,1,'uniform');
    new_vel = w.*old_vel + (c1*r1).*(ind_pbest - ind_pos) + (c2*r2).*(Gbest - ind_pos);
    
    if new_vel(1,1) > vel_max then
        new_vel(1,1) = vel_max
    elseif new_vel(1,1) < vel_min then
        new_vel(1,1) = vel_min
    end
    
    if new_vel(1,2) > vel_max then
        new_vel(1,2) = vel_max
    elseif new_vel(1,2) < vel_min then
        new_vel(1,2) = vel_min
    end
endfunction

/* Update the position of the particle

   arguments:
   old_pos -> old particle position
   new_vel -> new velocity of the particle
*/
function [new_pos] = update_pos(old_pos, new_vel, upper_lim, lower_lim)
    new_pos = old_pos + new_vel;
    
    if new_pos(1,1) > upper_lim then
        new_pos(1,1) = upper_lim
    elseif new_pos(1,1) < lower_lim then
        new_pos(1,1) = lower_lim
    end
    
    if new_pos(1,2) > upper_lim then
        new_pos(1,2) = upper_lim
    elseif new_pos(1,2) < lower_lim then
        new_pos(1,2) = lower_lim
    end
endfunction
