clear
//
[x,y]=meshgrid(-500:5:500,-500:5:500);
//
z=-x.*sin(sqrt(abs(x)))-y.*sin(sqrt(abs(y)));
x=x/250;
y=y/250;
// r: Rosenbrock's function
r=100*(y-x.^2).^2+(1-x).^2;

//
w1=r+z;
x = x*250;
y = y*250;
//
surf(x,y,w1);

