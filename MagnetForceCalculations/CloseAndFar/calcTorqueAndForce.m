function [force, torque, maxAngles] = calcTorqueAndForce(angle, timeResponse)
%computes forces and torques necessary to bring the pod back to zero yaw
%depending on given parameters

%Parameters:
%angle: [degrees] yaw offset of the pod from i-beam axis
%timeResponse: [seconds] required time for pod to return to zero yaw

%Outputs force and torque vectors. The max force and torque are the
%last entries in the vectors, i.e. force(end) and torque(end)

%degrees to rad conversion
maxAngles = linspace(0.01,angle)*(pi/180); 

%geometry
podWidth = 24*(0.0254);  %inches to meters
podLength = 86.5*(0.0254);
%mass properties
mass = 323*(0.453592);  %lbs to kg

I = (1/12)*mass*(podWidth^2 + podLength^2);
alpha = 2*maxAngles./timeResponse^2;
torque = I*alpha;

%assuming equal distance from COM
distFromCOM = 0.60325; %meters
force = torque./distFromCOM;

end