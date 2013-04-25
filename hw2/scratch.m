for jstep=1:maxstep
  xplot(jstep) = r(1);
  yplot(jstep) = r(2);
  t = (jstep-1)*tau;     % Current time
  
  %* Calculate the acceleration of the ball 
  varaccel = varair_const*norm(v)*v;   % Air resistance
  varaccel(2) = varaccel(2)-grav;      % Gravity
  
  %* Calculate the new position and velocity using Euler method
  r = r + tau*v;                 % Euler step
  v = v + tau*accel;  


if (norm(v) < 50)
  varcd = .5;
else varCd = intrpf(norm(v),vms, vCd);
end
