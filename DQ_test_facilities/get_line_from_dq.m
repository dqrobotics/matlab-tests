function [ret] = get_line_from_dq(dq)
    dq = normalize(dq);
    ret = Ad(rotation(dq), primitive) + DQ.E * cross(translation(dq), Ad(rotation(dq), primitive));
end

