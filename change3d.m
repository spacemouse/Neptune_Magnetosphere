function change3d(hObj,event) %#ok<INUSD>
        % Called when user activates popup menu 
        val = get(hObj,'Value');
        if val == 1
            triton_orbit(1,1);
        elseif val == 2
            triton_orbit(1,2);
        elseif val == 3
            triton_orbit(2,1);
        elseif val == 4
            triton_orbit(2,2);
        end
    end