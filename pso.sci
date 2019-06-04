/* FEDERAL UNIVERSITY OF RIO GRANDE DO NORTE
   STUDENT: ALEXANDRE HENRIQUE SOARES DIAS
   
   Particle-Swarm Optimization for the function
   w1 = r + z, 
   
   where:
   z = -x.*sin(sqrt(abs(x))) - y.*sin(sqrt(abs(y))), in -500:5:500 -> x,y
   r = 100*(y-x.^2).^2+(1-x).^2, in -2:0.02:2 -> x,y
*/

// Population size
pop_sz = 15;

// Function limits

upper_lim = 500;
lower_lim = -500;
vel_max = 100;
vel_min = 100;
dim = 2;

function [fit] = fitness(ind_pos_x, ind_pos_y)
    x = ind_pos_x;
    y = ind_pos_y;
    
    z = -x.*sin(sqrt(abs(x))) - y.*sin(sqrt(abs(y)))
    r = 100*(y-x.^2).^2+(1-x).^2
    
    fit =  r + z;
endfunction

// Generating initial population
for i = 1:pop_sz
    for j = 1:dim
        ind_pos(i,j) = (2*upper_lim)*rand(1,1,'uniform') + lower_lim;
        ind_vel(i,j) = vel_max*rand(1,1,'uniform');
    end
    ind_pbest(i) = fitness(ind_pos(i,1), ind_pos(i,2));
end
   

