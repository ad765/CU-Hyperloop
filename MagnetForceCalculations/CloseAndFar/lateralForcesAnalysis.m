%the following script is used to analyze lateral forces and their effect on
%the 2017-2018 Cornell Hyperloop Pod

%i-beam constants
alumResistivity = 3.99e-006; %ohm-cm
alumResistivity = (100)*alumResistivity; %ohm-m
alumConducitivity = 1/alumResistivity; %S/m
iBeamThick = 0.313*(0.0254); %meters

podVelocity = 200*(0.44704); %meters per second

totalGap = iBeamThick + 6/1000; %total gap between perm magnets
closeGap = linspace(0.1,3) / 1000; %mm gap to meter gap

%the following are chosen as unity for testing purposes
windings = 1000;
current = 1;
crossSectArea = 1;

%relative permeability
mu = 4*pi*10^(-7)*200000; %needs to be checked

%calculate close and far magnet force using function in
%prelimCloseAndFarForces Module
[lateralForceClose, lateralForceFar] = prelimCloseAndFarForces(alumConducitivity, ...
mu, iBeamThick, podVelocity, totalGap, closeGap, windings, current, crossSectArea);

%assuming that still rectangle. Evenually need to change to actual moment
%of inertia extracted from inventor
totForce = lateralForceClose - lateralForceFar; 

%geometry
w = 24*(0.0254);  %inches to meters
l = 86.5*(0.0254);

moment = totForce*l;

figure
subplot(2,2,1)
plot(1000*closeGap,lateralForceClose)
xlabel('Close Gap (mm)')
ylabel('Close Magnet Force (N)')

subplot(2,2,2)
plot(1000*closeGap,lateralForceFar)
xlabel('Close Gap (mm)')
ylabel('Far Magnet Force (N)')

subplot(2,2,3)
plot(1000*closeGap,moment)
xlabel('Close Gap (mm)')
ylabel('Moment (N)')

%the following is used to calculate the forces and torques necessary to
%rotate the pod a certain amount of degress (variable called angle) in a
%certain of time (variable timeResponse)
angle = 1; %degrees
timeResponse = 0.1; %seconds
[force, torque, allAngles] = calcTorqueAndForce(angle,timeResponse);

subplot(2,2,4)
plot(allAngles,torque)
xlabel('Deviation Angle (rad)')
ylabel('Moment Necessary (N)')