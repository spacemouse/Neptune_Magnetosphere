function outvar = neptunelshell(lshell, total, towards_sun, rotated)
% NEPTUNELSHELL returns a matrix of coordinates in x,y,z

latitudes = linspace(0, 90, 100);
lshell3r = lshell .* (cosd(latitudes(:)).^2);
lshellvar1 = lshell3r(:) .* cosd(latitudes(:));
lshellvar2 = lshell3r(:) .* sind(latitudes(:));
zerovars = zeros(length(lshellvar1),1);

lshellx = [zerovars; zerovars];
lshelly = [flipud(lshellvar1); lshellvar1];
lshellz = [flipud(lshellvar2); -1.*lshellvar2];

onerot = [lshellx,lshelly,lshellz];
onerot = onerot';

outvar = onerot;

angle = 360/(total-1);
% this part rotates based on the number of l-shell loops you want to draw
for x = 1:total-1
    rotmatrix = [cosd(x*angle), -sind(x*angle), 0; sind(x*angle), cosd(x*angle),0; 0,0,1];
    outvar = [outvar, rotmatrix*onerot];
end

% From "Magnetic Fields at Neptune" by Ness, 1989
% okay now we need to tilt neptune's field
% tilt = 46.8 degrees toward 79.5 W
% FROM the 28.32 degrees tilt
% rotating around the X positive is away from sun
% rotating around Z is clockwise as well (west)

rotxdeg = 28.32-46.8;
rotzdeg = 90-79.5;

rotx = [1,0,0;0,cosd(rotxdeg),-sind(rotxdeg);0,sind(rotxdeg),cosd(rotxdeg)];
rotz = [ cosd(rotzdeg), -sind(rotzdeg), 0; sind(rotzdeg), cosd(rotzdeg), 0; 0, 0, 1 ];

outvar = rotx*outvar;
outvar = rotz*outvar;


% From "Magnetic Fields at Neptune" by Ness, 1989
% The OTD center is displaced (offset) from the planet's center by the 
% surprisingly large value of 0.55 RN (0.17, 0.46, and -0.24 RN in a 
% right-handed coordinate system in which the positive z axis is aligned 
% with the rotation axis and the x axis passes through the zero meridian)
% this however assumes +y is away from the sun, so we make it negative...
offset = [0.17; -0.46; -0.24];
% need to rotate it by the 28.32 tilt to get it in this coordinate system
rotxdeg = 28.32;
rotx = [1,0,0;0,cosd(rotxdeg),-sind(rotxdeg);0,sind(rotxdeg),cosd(rotxdeg)];
offset = rotx * offset;
xadd = offset(1);
yadd = offset(2);
zadd = offset(3);

outvar(1,:) = outvar(1,:) + xadd;
outvar(2,:) = outvar(2,:) + yadd;
outvar(3,:) = outvar(3,:) + zadd;

if rotated == 2
    %NOW let's rotate it around the axis of rotation
    rotxdeg = 28.32;
    unitvector = [0;0;1]; % unit vector    
    rotx = [1,0,0;0,cosd(rotxdeg),-sind(rotxdeg);0,sind(rotxdeg),cosd(rotxdeg)];
    unitvector = rotx*unitvector;

    u = unitvector(1);
    v = unitvector(2);
    w = unitvector(3);

    rotaround = [u^2 + (1-u^2)*cosd(180), u*v*(1-cosd(180))-w*sind(180), u*w*(1-cosd(180))+v*sind(180); ...
        u*v*(1-cosd(180))+w*sind(180), v^2+(1-v^2)*cosd(180), v*w*(1-cosd(180))-u*sind(180); ...
        u*w*(1-cosd(180))-v*sind(180), v*w*(1-cosd(180))+u*sind(180), w^2+(1-w^2)*cosd(180)];

    outvar = rotaround*outvar;
end

if towards_sun == 2
    rotzdeg = 180;
    rotz = [ cosd(rotzdeg), -sind(rotzdeg), 0; sind(rotzdeg), cosd(rotzdeg), 0; 0, 0, 1 ];
    outvar = rotz*outvar;
end
end

