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
%         function test_serial_manipulator_fkm(testCase) 
%             % Tests the DQ_SerialManipualtor.fkm() method             
%             for i=1:testCase.mat.NUMBER_OF_RANDOM                
%                 x = testCase.mat.result_of_fkm(:,i);
%                 q = testCase.mat.random_q(:,i);                
%                 testCase.assertEqual(vec8(testCase.serial_manipulator_robot.fkm(q)), x,...
%                     "AbsTol", testCase.tolerance,...
%                     "Error in DQ_SerialManipulator.fkm")          
%             end 
%         end
% 
%         function test_serial_manipulator_pose_jacobian(testCase)
%             % Tests the DQ_SerialManipualtor.pose_jacobian() method             
%             for i=1:testCase.mat.NUMBER_OF_RANDOM                
%                 J = testCase.mat.result_of_pose_jacobian(:,:,i);
%                 q = testCase.mat.random_q(:,i);                
%                 testCase.assertEqual(testCase.serial_manipulator_robot.pose_jacobian(q), J,...
%                     "AbsTol", testCase.almost_equal_tolerance,...
%                     "Error in DQ_SerialManipulator.pose_jacobian")          
%             end 
%         end
% 
%         function test_serial_manipulator_pose_jacobian_derivative(testCase)
%             % Tests the DQ_SerialManipualtor.pose_jacobian_derivative() method             
%             for i=1:testCase.mat.NUMBER_OF_RANDOM                
%                 J_dot = testCase.mat.result_of_pose_jacobian_derivative(:,:,i);
%                 q = testCase.mat.random_q(:,i);  
%                 q_dot = testCase.mat.random_q_dot(:,i);
%                 testCase.assertEqual(testCase.serial_manipulator_robot.pose_jacobian_derivative(q, q_dot), J_dot,...
%                     "AbsTol", testCase.almost_equal_tolerance,...
%                     "Error in DQ_SerialManipulator.pose_jacobian_derivative")          
%             end 
%         end
% 
%         % DQ_WholeBody.fkm
%         function test_whole_body_fkm(testCase)
%             % Tests the DQ_WholeBody.fkm() method  
%             for i=1:testCase.mat.NUMBER_OF_RANDOM                
%                 x = testCase.mat.result_of_whole_body_fkm(:,i);
%                 q = testCase.mat.random_q_whole_body(:,i);                  
%                 testCase.assertEqual(vec8(testCase.whole_body_robot.fkm(q)), x,...
%                     "AbsTol", testCase.almost_equal_tolerance,...
%                     "Error in DQ_WholeBody.fkm")          
%             end 
%         end  
% 
%         function test_whole_body_pose_jacobian(testCase)
%             % Tests the DQ_WholeBody.pose_jacobian() method  
%             for i=1:testCase.mat.NUMBER_OF_RANDOM              
%                 q = testCase.mat.random_q_whole_body(:,i);   
%                 J = testCase.mat.result_of_whole_body_jacobian(:,:,i);
%                 testCase.assertEqual(testCase.whole_body_robot.pose_jacobian(q), J,...
%                     "AbsTol", testCase.almost_equal_tolerance,...
%                     "Error in DQ_WholeBody.fkm")          
%             end 
%         end 
%         
%         function test_distance_jacobian(testCase)
%             % Tests the distance_jacobian() method  
%             for i=1:testCase.mat.NUMBER_OF_RANDOM  
%                 %q = testCase.mat.random_q(:,i); 
%                 %x = testCase.serial_manipulator_robot.fkm(q);
%                 x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
%                 J = testCase.mat.result_of_pose_jacobian(:,:,i);
%                 Jd = testCase.mat.result_of_distance_jacobian(:,:,i);
%                 testCase.assertEqual(testCase.serial_manipulator_robot.distance_jacobian(J,x), Jd,...
%                     "AbsTol", testCase.almost_equal_tolerance,...
%                     "Error in distance_jacobian")          
%             end   
%         end
% 
%         function test_rotation_jacobian(testCase)
%             % Tests the rotation_jacobian() method  
%             for i=1:testCase.mat.NUMBER_OF_RANDOM                 
%                 Jr = testCase.mat.result_of_rotation_jacobian(:,:,i);
%                 J = testCase.mat.result_of_pose_jacobian(:,:,i);                
%                 testCase.assertEqual(testCase.serial_manipulator_robot.rotation_jacobian(J), Jr,...
%                     "AbsTol", testCase.almost_equal_tolerance,...
%                     "Error in rotation_jacobian")          
%             end   
%         end
% 
%         function test_translation_jacobian(testCase)
%             % Tests the translation_jacobian() method  
%             for i=1:testCase.mat.NUMBER_OF_RANDOM
%                 Jt = testCase.mat.result_of_translation_jacobian(:,:,i);
%                 x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
%                 J = testCase.mat.result_of_pose_jacobian(:,:,i);                
%                 testCase.assertEqual(testCase.serial_manipulator_robot.translation_jacobian(J,x), Jt,...
%                     "AbsTol", testCase.almost_equal_tolerance,...
%                     "Error in translation_jacobian")          
%             end   
%         end  
% 
%         function test_line_jacobian(testCase)
%             % Tests the line_jacobian() method  
%             for i=1:testCase.mat.NUMBER_OF_RANDOM
%                 Jl = testCase.mat.result_of_line_jacobian(:,:,i);
%                 x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
%                 J = testCase.mat.result_of_pose_jacobian(:,:,i);                
%                 testCase.assertEqual(testCase.serial_manipulator_robot.line_jacobian(J,x, DQ.k), Jl,...
%                     "AbsTol", testCase.almost_equal_tolerance,...
%                     "Error in line_jacobian")          
%             end   
%         end 
% 
%         function test_plane_jacobian(testCase)
%             % Tests the plane_jacobian() method  
%             for i=1:testCase.mat.NUMBER_OF_RANDOM
%                 Jl = testCase.mat.result_of_line_jacobian(:,:,i);
%                 x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
%                 J = testCase.mat.result_of_pose_jacobian(:,:,i);                
%                 testCase.assertEqual(testCase.serial_manipulator_robot.line_jacobian(J,x, DQ.k), Jl,...
%                     "AbsTol", testCase.almost_equal_tolerance,...
%                     "Error in plane_jacobian")          
%             end   
%         end   

        function test_line_to_line_distance_jacobian(testCase) % not working!
            % Tests the line_to_line_jacobian() method  
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                Jl = testCase.mat.result_of_line_jacobian(:,:,i);
                x = DQ(testCase.mat.result_of_fkm(:,i)).normalize();
                h = DQ(testCase.mat.random_dq_a(:,i)).normalize() ;     
                result = testCase.mat.result_of_line_to_line_distance_jacobian(:,:,i);
                testCase.assertEqual(testCase.serial_manipulator_robot.line_to_line_distance_jacobian(Jl, get_line_from_dq(x, DQ.k), get_line_from_dq(h, DQ.k)), result,...
                    "AbsTol", testCase.almost_equal_tolerance,...
                    "Error in line_to_line_jacobian")          
            end   
        end          


    end
end








