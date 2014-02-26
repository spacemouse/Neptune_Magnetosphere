function magnetopause(Rm, towards_sun, rotated)
[magnet_x, magnet_y, magnet_z] = sphere(20);
magnet_x = magnet_x.*Rm;
magnet_y = magnet_y.*Rm;
magnet_z = magnet_z.*Rm./1.3;
magnetopause = surf(magnet_x, magnet_y, magnet_z);
rotx = 28.32-46.8;
rotz = 90-79.5;
rotate(magnetopause,[1 0 0],rotx,[0 0 0])
rotate(magnetopause,[0,0,1],rotz,[0 0 0]);
magnet_x = get(magnetopause, 'XData');
magnet_y = get(magnetopause, 'YData');
magnet_z = get(magnetopause, 'ZData');
offset = [0.17; -0.46; -0.24];
rotxdeg = 28.32;
rotx = [1,0,0;0,cosd(rotxdeg),-sind(rotxdeg);0,sind(rotxdeg),cosd(rotxdeg)];
offset = rotx * offset;
set(magnetopause, 'XData', magnet_x+offset(1));
set(magnetopause, 'YData', magnet_y+offset(2));
set(magnetopause, 'ZData', magnet_z+offset(3));
set(magnetopause, 'FaceColor', 'none');
set(magnetopause, 'EdgeColor', 'b');
set(magnetopause, 'LineStyle', ':');

%again, apply the neccessary rotations
if rotated == 2
    %NOW let's rotate it around the axis of rotation
    rotxdeg = 28.32;
    unitvector = [0;0;1]; % unit vector    
    rotx = [1,0,0;0,cosd(rotxdeg),-sind(rotxdeg);0,sind(rotxdeg),cosd(rotxdeg)];
    unitvector = rotx*unitvector;
    u = unitvector(1);
    v = unitvector(2);
    w = unitvector(3);
    rotate(magnetopause,[u,v,w],180,[0 0 0]);
end

if towards_sun == 2
    rotzdeg = 180;
    rotate(magnetopause,[0,0,1],rotzdeg,[0 0 0]);
end

end