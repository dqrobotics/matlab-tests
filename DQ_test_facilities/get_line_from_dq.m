% (C) Copyright 2019 DQ Robotics Developers
% 
% This file is part of DQ Robotics.
% 
%     DQ Robotics is free software: you can redistribute it and/or modify
%     it under the terms of the GNU Lesser General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     DQ Robotics is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU Lesser General Public License for more details.
% 
%     You should have received a copy of the GNU Lesser General Public License
%     along with DQ Robotics.  If not, see <http://www.gnu.org/licenses/>.
% 
% Contributors:             
% - Juan Jose Quiroz Omana (juanjqo@g.ecc.u-tokyo.ac.jp)

function [ret] = get_line_from_dq(dq, primitive)
% GET_LINE_FROM_DQ(DQ, PRIMITIVE) returns the Plücker line that is
% collinear to the PRIMITIVE axis of a frame represented by the dual
% quaternion dq.
    dq = normalize(dq);
    ret = Ad(rotation(dq), primitive) + DQ.E * cross(translation(dq), Ad(rotation(dq), primitive));
end

