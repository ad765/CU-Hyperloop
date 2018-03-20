function [lateralForceClose, lateralForceFar] = prelimCloseAndFarForces(metalCond, ... 
mu, beamThick, v, totGap, closeGap, windings, current, crossSectArea)

%Input Variables:
%conductivity of i-beam
%relative permeability of i-beam, 
%thickness of i-beam,
%pod velocity 
%total gap between the magnets (including i-beam thickness), 
%the distance of the close magnet to the i-beam
%number of solenoid windings 
%current supplied to the solenoid
%cross sectional area of the solenoid

%Vacuum Permeability
mu0 = 4*pi*10^(-7);

%Contributions to p from solenoid and the core
psolenoid = windings*current*crossSectArea;
pcore = windings*current*crossSectArea*(1-(mu0/mu));
p=psolenoid + pcore;

%mirror image velocity (w), material property
w = 2/(beamThick*mu*mu0*metalCond);

%relationship between close magnet and far magnet force

lateralForceClose= ( (3*mu0*p^2)./(32*pi*closeGap.^4) ).*(1- w/sqrt( v^2 + w^2) );
farGap = totGap - closeGap - beamThick;
lateralForceFar = ( (3*mu0*p^2)./(32*pi*farGap.^4) ).*(1- w/sqrt( v^2 + w^2) );

end