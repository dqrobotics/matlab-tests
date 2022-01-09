% CLASS DQKinematicsTestCase performs unit tests of the DQ_Kinematics class. 
%
% How to run the unit tests:
%         >> runtests("DQKinematicsTestCase")
%
%
% DQTestCase Properties:
%         mat - mat file that containts the results of some random operations using DQ.
%         tolerance = 1e-15 - Tolerance used to compare two quantities.
%         almost_equal_tolerance = 1e-11 - Tolerance used to consider equal two quantities.
%         serial_manipulator_robot
%         whole_body_robot
%
% DQKinematicsTestCase Methods:
%             DQKinematicsTestCase() - Constructor
%
% DQKinematicsTestCase Methods (Test):
%             test_serial_manipulator_fkm - Tests the DQ_SerialManipualtor.fkm() method    
%             test_serial_manipulator_pose_jacobian - Tests the DQ_SerialManipualtor.pose_jacobian() method  
%             test_serial_manipulator_pose_jacobian_derivative - Tests the DQ_SerialManipualtor.pose_jacobian_derivative() method 
%             test_whole_body_fkm - Tests the DQ_WholeBody.fkm() method 
%             test_whole_body_pose_jacobian - Tests the DQ_WholeBody.pose_jacobian() method
%             test_distance_jacobian - Tests the distance_jacobian() method 
%             test_rotation_jacobian - Tests the translation_jacobian() method
%             test_line_jacobian - Tests the line_jacobian() method
%             test_plane_jacobian - Tests the plane_jacobian() method 
%             test_line_to_line_distance_jacobian -Tests the line_to_line_distance_jacobian() method  
%             test_line_to_point_distance_jacobian - Tests the line_to_point_distance_jacobian() method
%             test_plane_to_point_distance_jacobian - Tests the plane_to_point_distance_jacobian() method
%             test_point_to_line_distance_jacobian - Tests the point_to_line_distance_jacobian() method
%             test_point_to_plane_distance_jacobian - Tests the point_to_plane_distance_jacobian() method
%             test_point_to_point_distance_jacobian - Tests the point_to_point_distance_jacobian() method
%             test_line_to_line_angle_jacobian - Tests the line_to_line_angle_jacobian() method%
%
%
%-----------------------------------How to get the mat-file---------------
%             clear all;
%             close all;
%             include_namespace_dq
%             
%             NUMBER_OF_RANDOM = 1000;
%             
%             serial_manipulator = KukaLwr4Robot.kinematics();
%             whole_body = KukaYoubot.kinematics();
%             
%             %% Generate data for unary and binary operators
%             random_q = random('unif',-pi,pi,[7 NUMBER_OF_RANDOM]);
%             random_q_dot = random('unif',-pi,pi,[7 NUMBER_OF_RANDOM]);
%             random_q_whole_body = random('unif',-pi,pi,[8 NUMBER_OF_RANDOM]);
%             random_dq_a = random('unif',-10,10,[8 NUMBER_OF_RANDOM]);
%             %random_dq_b = random('unif',-10,10,[8 NUMBER_OF_RANDOM]);
%             
%             %% Pre-allocate results
%             result_of_fkm = zeros(8, NUMBER_OF_RANDOM);
%             result_of_pose_jacobian = zeros(8, 7, NUMBER_OF_RANDOM);
%             result_of_pose_jacobian_derivative = zeros(8, 7, NUMBER_OF_RANDOM);
%             
%             result_of_whole_body_fkm = zeros(8, NUMBER_OF_RANDOM);
%             result_of_whole_body_jacobian = zeros(8, 8, NUMBER_OF_RANDOM);
%             
%             %       distance_jacobian - Compute the (squared) distance Jacobian.
%             result_of_distance_jacobian = zeros(1, 7, NUMBER_OF_RANDOM);
%             %       rotation_jacobian - Compute the rotation Jacobian.
%             result_of_rotation_jacobian = zeros(4, 7, NUMBER_OF_RANDOM);
%             %       translation_jacobian - Compute the translation Jacobian.
%             result_of_translation_jacobian = zeros(4, 7, NUMBER_OF_RANDOM);
%             %       line_jacobian - Compute the line Jacobian.
%             result_of_line_jacobian = zeros(8, 7, NUMBER_OF_RANDOM);
%             %       plane_jacobian - Compute the plane Jacobian.
%             result_of_plane_jacobian = zeros(8, 7, NUMBER_OF_RANDOM);
%             
%             
%             %       line_to_line_distance_jacobian  - Compute the line-to-line distance Jacobian.
%             result_of_line_to_line_distance_jacobian = zeros(1, 7, NUMBER_OF_RANDOM);
%             %       line_to_line_residual - Compute the line-to-line residual.
%             
%             %       line_to_point_distance_jacobian - Compute the line-to-line distance Jacobian.
%             result_of_line_to_point_distance_jacobian = zeros(1, 7, NUMBER_OF_RANDOM);
%             %       line_to_point_residual - Compute the line-to-point residual.
%             
%             %       plane_to_point_distance_jacobian - Compute the plane-to-point distance Jacobian.
%             result_of_plane_to_point_distance_jacobian = zeros(1, 7, NUMBER_OF_RANDOM);
%             %       plane_to_point_residual - Compute the plane-to-point residual.
%             
%             %       point_to_line_distance_jacobian - Compute the point-to-line distance Jacobian.
%             result_of_point_to_line_distance_jacobian = zeros(1, 7, NUMBER_OF_RANDOM);
%             %       point_to_line_residual - Compute the point to line residual.
%             
%             %       point_to_plane_distance_jacobian - Compute the point to plane distance Jacobian.
%             result_of_point_to_plane_distance_jacobian = zeros(1, 7, NUMBER_OF_RANDOM);
%             %       point_to_plane_residual - Compute the point to plane residual.
%             
%             
%             %       point_to_point_distance_jacobian - Compute the point to point distance Jacobian.
%             result_of_point_to_point_distance_jacobian = zeros(1, 7, NUMBER_OF_RANDOM);
%             %       point_to_point_residual - Compute the point to point residual.
%             
%             %       line_to_line_angle_jacobian - Compute the line-to-line angle Jacobian.
%             result_of_line_to_line_angle_jacobian = zeros(1, 7, NUMBER_OF_RANDOM);
%             
%             
%             
%             %% Loop
%             for i=1:NUMBER_OF_RANDOM
%                 %% Preliminaries
%                 ha = DQ(random_dq_a(:,i));
%                 
%                 %% DQ_SerialManipulator
%                 x_pose = serial_manipulator.fkm(random_q(:,i));
%                 J_pose = serial_manipulator.pose_jacobian(random_q(:,i));
%                 
%                 %% Preliminaries for DQ_Kinematics
%                 robot_point = translation(x_pose);
%                 robot_line = get_line_from_dq(x_pose, k_);
%                 robot_plane = get_plane_from_dq(x_pose, k_);
%                 workspace_line = get_line_from_dq(ha, k_);
%                 workspace_point = translation(normalize(ha));
%                 workspace_plane = get_plane_from_dq(ha, k_);
%                 translation_jacobian = DQ_Kinematics.translation_jacobian(J_pose, x_pose);
%                 line_jacobian = DQ_Kinematics.line_jacobian(J_pose, x_pose, k_);
%                 plane_jacobian = DQ_Kinematics.plane_jacobian(J_pose, x_pose, k_);
%                 
%                 %% Results of DQ_SerialManipulator
%                 result_of_fkm(:, i) = vec8(x_pose);
%                 result_of_pose_jacobian(:,:,i) = J_pose;
%                 result_of_pose_jacobian_derivative(:,:,i) = serial_manipulator.pose_jacobian_derivative(random_q(:,i),random_q_dot(:,i));
%                 %% Results of DQ_WholeBody
%                 result_of_whole_body_fkm(:, i) = vec8(whole_body.fkm(random_q_whole_body(:,i)));
%                 result_of_whole_body_jacobian(:,:,i) = whole_body.pose_jacobian(random_q_whole_body(:,i));
%                 %% Results of DQ_Kinematics
%                 result_of_distance_jacobian(:,:,i) = DQ_Kinematics.distance_jacobian(J_pose,x_pose);
%                 result_of_rotation_jacobian(:,:,i) = DQ_Kinematics.rotation_jacobian(J_pose);
%                 result_of_translation_jacobian(:,:,i) = translation_jacobian;
%                 result_of_line_jacobian(:,:,i) = line_jacobian;
%                 result_of_plane_jacobian(:,:,i) = plane_jacobian;
%                 result_of_line_to_line_distance_jacobian(:,:,i) = DQ_Kinematics.line_to_line_distance_jacobian(line_jacobian,robot_line,workspace_line);
%                 result_of_line_to_point_distance_jacobian(:,:,i) = DQ_Kinematics.line_to_point_distance_jacobian(line_jacobian,robot_line,workspace_point);
%                 result_of_plane_to_point_distance_jacobian(:,:,i) = DQ_Kinematics.plane_to_point_distance_jacobian(plane_jacobian,workspace_point);
%                 result_of_point_to_line_distance_jacobian(:,:,i) = DQ_Kinematics.point_to_line_distance_jacobian(translation_jacobian,robot_point,workspace_line);
%                 result_of_point_to_plane_distance_jacobian(:,:,i) = DQ_Kinematics.point_to_plane_distance_jacobian(translation_jacobian,robot_point,workspace_plane);
%                 result_of_point_to_point_distance_jacobian(:,:,i) = DQ_Kinematics.point_to_point_distance_jacobian(translation_jacobian,robot_point,workspace_point);
%                 result_of_line_to_line_angle_jacobian(:,:,i) = DQ_Kinematics.line_to_line_angle_jacobian(line_jacobian,robot_line,workspace_line);
%             end
%             
%             save DQ_Kinematics_test.mat
%             
%             function ret = get_line_from_dq(dq, primitive)
%             include_namespace_dq
%             dq = normalize(dq);
%             ret = Ad(rotation(dq), primitive) + E_*cross(translation(dq), Ad(rotation(dq), primitive));
%             end
%             
%             function ret = get_plane_from_dq(dq, primitive)
%             include_namespace_dq
%             dq = normalize(dq);
%             ret = Ad(rotation(dq), primitive) + E_*dot(translation(dq), Ad(rotation(dq), primitive));
%             end
%----------------------------------------------------------------------------
%
%
%
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

classdef DQKinematicsTestCase < matlab.unittest.TestCase
    
    properties
        % MAT corresponds to the m-file that contains the tested results. (See above)
        mat;  
        % TOLERANCE is used to compare if two results are equal.
        tolerance = 1e-15;  
        % This is used to compare if two results are equal but using a lower tolerance.
        almost_equal_tolerance = 1e-11;

        % The DQ_SerialManipulator used to calculate everything for DQ_Kinematics as well
        serial_manipulator_robot;
        % 
        whole_body_robot;
    end
    
    methods
        function testCase = DQKinematicsTestCase()
            data = load('DQ_Kinematics_test.mat');
            testCase.mat = data;        
            testCase.serial_manipulator_robot = KukaLwr4Robot.kinematics();
            testCase.whole_body_robot = KukaYoubot.kinematics();
        end        
    end

    methods (Test)
        function test_serial_manipulator_fkm(testCase) 
            % Tests the DQ_SerialManipualtor.fkm() method             
            for i=1:testCase.mat.NUMBER_OF_RANDOM                
                x = testCase.mat.result_of_fkm(:,i);
                q = testCase.mat.random_q(:,i);                
                testCase.assertEqual(vec8(testCase.serial_manipulator_robot.fkm(q)), x,...
                    "AbsTol", testCase.tolerance,...
                    "Error in DQ_SerialManipulator.fkm")          
            end 
        end

        function test_serial_manipulator_pose_jacobian(testCase)
            % Tests the DQ_SerialManipualtor.pose_jacobian() method             
            for i=1:testCase.mat.NUMBER_OF_RANDOM                
                J = testCase.mat.result_of_pose_jacobian(:,:,i);
                q = testCase.mat.random_q(:,i);                
                testCase.assertEqual(testCase.serial_manipulator_robot.pose_jacobian(q), J,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in DQ_SerialManipulator.pose_jacobian")          
            end 
        end

        function test_serial_manipulator_pose_jacobian_derivative(testCase)
            % Tests the DQ_SerialManipualtor.pose_jacobian_derivative() method             
            for i=1:testCase.mat.NUMBER_OF_RANDOM                
                J_dot = testCase.mat.result_of_pose_jacobian_derivative(:,:,i);
                q = testCase.mat.random_q(:,i);  
                q_dot = testCase.mat.random_q_dot(:,i);
                testCase.assertEqual(testCase.serial_manipulator_robot.pose_jacobian_derivative(q, q_dot), J_dot,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in DQ_SerialManipulator.pose_jacobian_derivative")          
            end 
        end

        % DQ_WholeBody.fkm
        function test_whole_body_fkm(testCase)
            % Tests the DQ_WholeBody.fkm() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM                
                x = testCase.mat.result_of_whole_body_fkm(:,i);
                q = testCase.mat.random_q_whole_body(:,i);                  
                testCase.assertEqual(vec8(testCase.whole_body_robot.fkm(q)), x,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in DQ_WholeBody.fkm")          
            end 
        end  

        function test_whole_body_pose_jacobian(testCase)
            % Tests the DQ_WholeBody.pose_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM              
                q = testCase.mat.random_q_whole_body(:,i);   
                J = testCase.mat.result_of_whole_body_jacobian(:,:,i);
                testCase.assertEqual(testCase.whole_body_robot.pose_jacobian(q), J,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in DQ_WholeBody.fkm")          
            end 
        end 
        
        function test_distance_jacobian(testCase)
            % Tests the distance_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM  
                %q = testCase.mat.random_q(:,i); 
                %x = testCase.serial_manipulator_robot.fkm(q);
                x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
                J = testCase.mat.result_of_pose_jacobian(:,:,i);
                Jd = testCase.mat.result_of_distance_jacobian(:,:,i);
                testCase.assertEqual(testCase.serial_manipulator_robot.distance_jacobian(J,x), Jd,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in distance_jacobian")          
            end   
        end

        function test_rotation_jacobian(testCase)
            % Tests the rotation_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM                 
                Jr = testCase.mat.result_of_rotation_jacobian(:,:,i);
                J = testCase.mat.result_of_pose_jacobian(:,:,i);                
                testCase.assertEqual(testCase.serial_manipulator_robot.rotation_jacobian(J), Jr,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in rotation_jacobian")          
            end   
        end

        function test_translation_jacobian(testCase)
            % Tests the translation_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                Jt = testCase.mat.result_of_translation_jacobian(:,:,i);
                x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
                J = testCase.mat.result_of_pose_jacobian(:,:,i);                
                testCase.assertEqual(testCase.serial_manipulator_robot.translation_jacobian(J,x), Jt,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in translation_jacobian")          
            end   
        end  

        function test_line_jacobian(testCase)
            % Tests the line_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                Jl = testCase.mat.result_of_line_jacobian(:,:,i);
                x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
                J = testCase.mat.result_of_pose_jacobian(:,:,i);                
                testCase.assertEqual(testCase.serial_manipulator_robot.line_jacobian(J,x, DQ.k), Jl,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in line_jacobian")          
            end   
        end 

        function test_plane_jacobian(testCase)
            % Tests the plane_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                Jl = testCase.mat.result_of_line_jacobian(:,:,i);
                x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
                J = testCase.mat.result_of_pose_jacobian(:,:,i);                
                testCase.assertEqual(testCase.serial_manipulator_robot.line_jacobian(J,x, DQ.k), Jl,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in plane_jacobian")          
            end   
        end   

        function test_line_to_line_distance_jacobian(testCase) 
            % Tests the line_to_line_distance_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                Jl = testCase.mat.result_of_line_jacobian(:,:,i);
                x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
                h = DQ(testCase.mat.random_dq_a(:,i)).normalize() ;     
                result = testCase.mat.result_of_line_to_line_distance_jacobian(:,:,i);
                testCase.assertEqual(testCase.serial_manipulator_robot.line_to_line_distance_jacobian(Jl,...
                    get_line_from_dq(x, DQ.k), get_line_from_dq(h, DQ.k)), result,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in line_to_line_distance_jacobian")          
            end   
        end  

        function test_line_to_point_distance_jacobian(testCase) 
            % Tests the line_to_point_distance_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                Jl = testCase.mat.result_of_line_jacobian(:,:,i);
                x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
                h = DQ(testCase.mat.random_dq_a(:,i)).normalize() ;     
                result = testCase.mat.result_of_line_to_point_distance_jacobian(:,:,i);
                testCase.assertEqual(testCase.serial_manipulator_robot.line_to_point_distance_jacobian(Jl,...
                    get_line_from_dq(x, DQ.k), get_point_from_dq(h)), result,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in line_to_point_distance_jacobian")          
            end   
        end  

        function test_plane_to_point_distance_jacobian(testCase)
            % Tests the plane_to_point_distance_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                Jpi = testCase.mat.result_of_plane_jacobian(:,:,i);                
                h = DQ(testCase.mat.random_dq_a(:,i)).normalize() ;     
                result = testCase.mat.result_of_plane_to_point_distance_jacobian(:,:,i);
                testCase.assertEqual(testCase.serial_manipulator_robot.plane_to_point_distance_jacobian(Jpi,...
                    get_point_from_dq(h)), result,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in plane_to_point_distance_jacobian")          
            end  
        end

        function test_point_to_line_distance_jacobian(testCase)
            % Tests the point_to_line_distance_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                Jt = testCase.mat.result_of_translation_jacobian(:,:,i); 
                x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
                h = DQ(testCase.mat.random_dq_a(:,i)).normalize() ;     
                result = testCase.mat.result_of_point_to_line_distance_jacobian(:,:,i);
                testCase.assertEqual(testCase.serial_manipulator_robot.point_to_line_distance_jacobian(Jt,...
                    translation(x),get_line_from_dq(h, DQ.k)), result,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in point_to_line_distance_jacobian")          
            end  
        end

        function test_point_to_plane_distance_jacobian(testCase)
            % Tests the point_to_plane_distance_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                Jt = testCase.mat.result_of_translation_jacobian(:,:,i); 
                x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
                h = DQ(testCase.mat.random_dq_a(:,i)).normalize() ;     
                result = testCase.mat.result_of_point_to_plane_distance_jacobian(:,:,i);
                testCase.assertEqual(testCase.serial_manipulator_robot.point_to_plane_distance_jacobian(Jt,...
                    translation(x),get_plane_from_dq(h, DQ.k)), result,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in point_to_plane_distance_jacobian")          
            end  
        end

        function test_point_to_point_distance_jacobian(testCase)
            % Tests the point_to_point_distance_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                Jt = testCase.mat.result_of_translation_jacobian(:,:,i); 
                x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
                h = DQ(testCase.mat.random_dq_a(:,i)).normalize() ;     
                result = testCase.mat.result_of_point_to_point_distance_jacobian(:,:,i);
                testCase.assertEqual(testCase.serial_manipulator_robot.point_to_point_distance_jacobian(Jt,...
                    translation(x),get_point_from_dq(h)), result,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in point_to_point_distance_jacobian")          
            end  
        end
        function test_line_to_line_angle_jacobian(testCase)
            % Tests the line_to_line_angle_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                Jl = testCase.mat.result_of_line_jacobian(:,:,i); 
                x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
                h = DQ(testCase.mat.random_dq_a(:,i)).normalize() ;     
                result = testCase.mat.result_of_line_to_line_angle_jacobian(:,:,i);
                testCase.assertEqual(testCase.serial_manipulator_robot.line_to_line_angle_jacobian(Jl,...
                    get_line_from_dq(x, DQ.k), get_line_from_dq(h, DQ.k)), result,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in line_to_line_angle_jacobian")          
            end  
        end


    end
end


























