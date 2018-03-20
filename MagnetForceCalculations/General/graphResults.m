upperBound = 0.010;
lowerBound = 0.001

x = linspace(upperBound, lowerBound);
y = [];

%compute function output for each element in x
for n = 1:length(x)
    y(n) = computeLateralForce(x(n));
end

plot(x,y);
shg
