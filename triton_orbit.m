function triton_orbit(towards_sun, reversed)
hold off;
plot3(0,0,0);
hold on;
campos([-20,0,0]);
axis([-30 30 -30 30 -30 30]);
% this triton orbit data from HORIZONS
% http://ssd.jpl.nasa.gov/horizons.cgi
triton_data = importdata('triton_orbit.csv');
triton_x = triton_data.data(:,1);
triton_y = triton_data.data(:,2);
triton_z = triton_data.data(:,3);
%convert from km to neptune radii
Rn = 24764;
triton_x = triton_x ./ Rn;
triton_y = triton_y ./ Rn;
triton_z = triton_z ./ Rn;
hold on;
grid on;
triton = plot3(triton_x,triton_y,triton_z);
% need to rotate around Z because HORIZONS has a -Y axis
rotate(triton,[0,0,1],180,[0 0 0]);
set (triton, 'Color', [0,0.9,0.1]);
set (triton, 'LineWidth', 1.5);
% this voyager 2 orbit data from HORIZONS
% http://ssd.jpl.nasa.gov/horizons.cgi
voy2_data = importdata('voyager2.csv');
voy_x = voy2_data.data(:,1);
voy_y = voy2_data.data(:,2);
voy_z = voy2_data.data(:,3);
%convert from km to neptune radii
Rn = 24764;
voy_x = voy_x ./ Rn;
voy_y = voy_y ./ Rn;
voy_z = voy_z ./ Rn;
hold on;
grid on;
voyager2 = plot3(voy_x,voy_y,voy_z,'r');
% need to rotate around Z because HORIZONS has a -Y axis
rotate(voyager2,[0,0,1],180,[0 0 0]);

%drawing neptune
[neptune_x,neptune_y,neptune_z] = sphere(20);
hsurf1 = surf(neptune_x(:, 1:11),neptune_y(:, 1:11),neptune_z(:, 1:11));
hsurf2 = surf(neptune_x(:, 11:21),neptune_y(:, 11:21),neptune_z(:, 11:21));
shading flat;
set(hsurf1, 'FaceColor',[0,0,0.4]);
set(hsurf2, 'FaceColor',[1,1,0.4]);
% From "Magnetic Fields at Neptune" by Ness, 1989,
% The Magnetopause is at Radius = 26.5 Rn.
% but we can hand-calc it:
% from Neptune and Triton (Cruikshank),
% dipole moment = 0.133 Gauss-Rn^3 (page 258)
% density of the solar wind is about 1E-3 cm-3 (page 289)
% 1 Gauss = 1E-4 Tesla
% now since B0 = - (mu0 * M) / (4 * pi * radius^3)
% the only way the units work out here is if they've already multiplied
% by mu0 (since we need teslas as the final unit)
% so i'm assuming :
M = 0.133E-4; %Tesla-Rn^3;
B0 = M ; % this should be in Teslas, since we want Rn = 1
mu0 = 1.2566E-6; %mu0
%B = B0 * (1 / lshell)^3 * (1+3*sind(0)^2)^(0.5);
% radius of magnetopause = ((2B0^2)/(mu0*density*velocity^2))^(1/6)
% where density and velocity are of the solar wind
Vs = 420; %km/s
Vs = Vs * 1000; %m/s
RHOs = 0.005; %1/cm-3
Mp = 1.67262178E-24; % g, mass of a proton
RHOs = RHOs * Mp; %g/cm-3
RHOs = RHOs * 1E3; %kg/m-3
Rm = ((2*(B0^2))/(mu0*RHOs*(Vs^2)))^(1/6); % already dimensionless
%Rm calculates out to about 24, which is reasonable.
magnetopause(Rm,towards_sun,reversed);
axis equal;
drawneptuneaxis(towards_sun,reversed);
lshell15 = neptunelshell(15,27,towards_sun,reversed);
plot3(lshell15(1,:), lshell15(2,:), lshell15(3,:),'k');
lshell24 = neptunelshell(24,18,towards_sun,reversed);
plot3(lshell24(1,:), lshell24(2,:), lshell24(3,:),'c');
%lshell30 = neptunelshell(30,18,towards_sun,reversed);
%plot3(lshell30(1,:), lshell30(2,:), lshell30(3,:),'c');
fclose('all');
end
