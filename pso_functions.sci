/* Fitness value calculated from the objective function
   
   arguments:
   ind_pos -> individual particle position
*/
function [fitness] = fit(ind_pos)
    x = ind_pos(1,1);
    y = ind_pos(1,2);
    
    z = -x*sin(sqrt(abs(x))) - y*sin(sqrt(abs(y)));
    r = 100*(y-x^2)^2+(1-x)^2;
    
    fitness =  r + z;
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
function [new_vel] = update_vel(old_vel, ind_pos, w, c1, c2, ind_pbest, Gbest)
    r1 = rand(1,1,'uniform');
    r2 = rand(1,1,'uniform');
    new_vel = w.*old_vel + (c1*r1).*(ind_pbest - ind_pos) + (c2*r2).*(Gbest - ind_pos);
endfunction

/* Update the position of the particle

   arguments:
   old_pos -> old particle position
   new_vel -> new velocity of the particle
*/
function [new_pos] = update_pos(old_pos, new_vel)
    new_pos = old_pos + new_vel;
endfunction
