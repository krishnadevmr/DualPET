function [ InterceptionPoint ] = GetIntercectionWIthPlane(plane,crystal1,crystal2)
a=plane(1);
b=plane(2);
c=plane(3);
d=plane(4);

x1 =crystal1(1);
y1 =crystal1(2);
z1 =crystal1(3);

x2 =crystal2(1);
y2 =crystal2(2);
z2 =crystal2(3);


t=(d-a*x1-b*y1-c*z1)/(a*(x1-x2)+b*(y1-y2)+c*(z1-z2));
x=x1+t*(x1-x2);
y=y1+t*(y1-y2);
z=z1+t*(z1-z2);

% digits(5)
 x=round(x,4);
 y=round(y,4);
 z=round(z,4);

InterceptionPoint=[x y z];
end

