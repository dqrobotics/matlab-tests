% RUN_ALL_EXAMPLES - Runs all examples in DQ Robotics and report the ones that fail.
% 
% USAGE: run_all_examples() or run_all_examples(start,end)'

% (C) Copyright 2011-2020 DQ Robotics Developers
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
% DQ Robotics website: dqrobotics.github.io
%
% Contributors to this file:
%     Bruno Vihena Adorno - adorno@ufmg.br

function [fail_count, fail_log] = run_all_examples(varargin)
    file = {'ax18_kinematic_control',...
            'comau_kinematic_control',...
            'wam_kinematic_control',...
            'kuka_kinematic_control', ...
            'holonomic_base_control',...
            'cdts_broom_kuka',...
            'cdts_bucket_kuka',...
            'example_damped_numerical_filtered_controller',...
            'draw_lines_planes_using_dual_quaternions',...
            'matlab_general_operations',...
            'pose_jacobian_time_derivative',...
            'example_little_john(''novisual'')',...
            'robot_serialization(''novisual'')',...
            'whole_body_control_example(''novisual'')',...
            'two_legs_kinematic_control',...
            'kuka_line_control',...
            'kuka_plane_control',...
            'constrained_controller_example',...
            'kuka_plane_tracking_control',...
            'stanford_manipulator_modeling'
            };
        
        
    if nargin == 0
        % run all examples
        initial = 1;
        final = length(file)     ;
    elseif nargin ~= 2
        error('USAGE: run_all_examples() or run_all_examples(start,end)');
    else
        initial = varargin{1};
        final = varargin{2};
    end

    fail_log = sprintf('This is the list of failed tests: ');
    fail_count = 0;
    for i = initial:final       
        try
            close all;
            fprintf('\n%d of %d: Executing %s', i, length(file), file{i});
            eval(file{i});
        catch
            fail_log = [fail_log, file{i}, ', '];
            fprintf('\n');
            warning('Could not execute file %s', file{i});
            fail_count = fail_count + 1; 
        end
    end
    fprintf('\nNumber of fails: %d', fail_count);
    fprintf('\n%s', fail_log);
end
