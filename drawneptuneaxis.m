function drawneptuneaxis(towards_sun, rotated)
radata = [0,0,-3;0,0,3];
mpdataN = [0,0,0;0,0,5];
mpdataS = [0,0,-5;0,0,0];
rotx = 28.32;
rotationaxis = plot3(radata(:,1),radata(:,2),radata(:,3));
set(rotationaxis,'Color',[1,0.5,0]);
set(rotationaxis,'LineWidth',3);
rotate(rotationaxis,[1,0,0],rotx,[0 0 0]);

magneticaxisN = plot3(mpdataN(:,1),mpdataN(:,2),mpdataN(:,3));
magneticaxisS = plot3(mpdataS(:,1),mpdataS(:,2),mpdataS(:,3));
set(magneticaxisN,'Color',[1,0,0]);
set(magneticaxisN,'LineWidth',2);
set(magneticaxisS,'Color',[0,0,1]);
set(magneticaxisS,'LineWidth',2);
rotx = 28.32-46.8;
rotz = 90-79.5;
rotate(magneticaxisN,[1,0,0],rotx,[0 0 0]);
rotate(magneticaxisN,[0,0,1],rotz,[0 0 0]);
rotate(magneticaxisS,[1,0,0],rotx,[0 0 0]);
rotate(magneticaxisS,[0,0,1],rotz,[0 0 0]);
magnet_x = get(magneticaxisN, 'XData');
magnet_y = get(magneticaxisN, 'YData');
magnet_z = get(magneticaxisN, 'ZData');
offset = [0.17; -0.46; -0.24];
rotxdeg = 28.32;
rotx = [1,0,0;0,cosd(rotxdeg),-sind(rotxdeg);0,sind(rotxdeg),cosd(rotxdeg)];
offset = rotx * offset;
set(magneticaxisN, 'XData', magnet_x+offset(1));
set(magneticaxisN, 'YData', magnet_y+offset(2));
set(magneticaxisN, 'ZData', magnet_z+offset(3));
magnet_x = get(magneticaxisS, 'XData');
magnet_y = get(magneticaxisS, 'YData');
magnet_z = get(magneticaxisS, 'ZData');
offset = [0.17; -0.46; -0.24];
rotxdeg = 28.32;
rotx = [1,0,0;0,cosd(rotxdeg),-sind(rotxdeg);0,sind(rotxdeg),cosd(rotxdeg)];
offset = rotx * offset;
set(magneticaxisS, 'XData', magnet_x+offset(1));
set(magneticaxisS, 'YData', magnet_y+offset(2));
set(magneticaxisS, 'ZData', magnet_z+offset(3));

if rotated == 2
    %NOW let's rotate it around the axis of rotation
    rotxdeg = 28.32;
    unitvector = [0;0;1]; % unit vector    
    rotx = [1,0,0;0,cosd(rotxdeg),-sind(rotxdeg);0,sind(rotxdeg),cosd(rotxdeg)];
    unitvector = rotx*unitvector;
    u = unitvector(1);
    v = unitvector(2);
    w = unitvector(3);
    rotate(magneticaxisN,[u,v,w],180,[0 0 0]);
    rotate(magneticaxisS,[u,v,w],180,[0 0 0]);
end

if towards_sun == 2
    rotzdeg = 180;
    rotate(rotationaxis,[0,0,1],rotzdeg,[0 0 0]);
    rotate(magneticaxisN,[0,0,1],rotzdeg,[0 0 0]);
    rotate(magneticaxisS,[0,0,1],rotzdeg,[0 0 0]);
end

end