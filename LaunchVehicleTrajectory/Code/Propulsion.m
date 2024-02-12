%% ÍÆÁ¦º¯Êý
function P_0 = Propulsion(t)

if t > 0 && t < 61.6
    P_0 = 912000;
else
    if t > 61.6 && t < 126.8
        P_0 = 270000;
    else
        if t > 126.8 && t < 186.4
            P_0 = 155000;
        else
            P_0 = 0;
        end
    end
end
end

