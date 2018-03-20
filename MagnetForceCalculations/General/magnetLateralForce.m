function [lateralForce] = magnetLateralForce(metalConductivity, mu, beamThick, ...
podVelocity, airGap, windings, current, crossSectArea)
%Parameters:
%conductivity of i-beam
%relative permeability of i-beam
%thickness of i-beam
%pod velocity 
%distance between magnet and i-beam
%number of solenoid windings 
%current supplied to the solenoid
%cross sectional area of the solenoid

%Vacuum Permeability
mu0 = 4*pi*10^(-7);

%Contributions to p from solenoid and the core
psolenoid = windings*current*crossSectArea;
pcore = windings*current*crossSectArea*(1-(mu0/mu));
p=psolenoid + pcore;

%mirror image velocity (w). material property
w = 2/(beamThick*mu*mu0*metalConductivity);

%relationship between close magnet and far magnet force
lateralForce= ((3*mu0*p^2)./(32*pi*airGap.^4) ) * (1- w/sqrt(podVelocity^2 + w^2));
end


