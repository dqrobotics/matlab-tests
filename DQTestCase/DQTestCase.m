% CLASS DQTestCase performs unit tests of the DQ class. 
%
% How to run the unit tests:
%         >> runtests("DQTestCase")
%
%
% DQTestCase Properties:
%         mat - mat file that containts the results of some random operations using DQ.
%         tolerance = 1e-15 - Tolerance used to compare two quantities.
%         almost_equal_tolerance = 1e-11 - Tolerance used to consider equal two quantities. 
%
% DQTestCase Methods:
%         DQTestCase() - Constructor
%
% DQTestCase Methods (Test):
%         test_constructor_valid - Test if a dq constructor is valid
%         test_contructor_invalid - Test if a dq constructor is invalid
%         test_plus  - Test the dual quaternion addition
%         test_minus - Test the dual quaternion subtraction
%         test_times - Test the dual quaternion multiplication
%         test_dot  - Test the dot product between two pure dual quaternions
%         test_cross - Test the cross product between two pure dual quaternions
%         test_ad    - Test the adjoint operation
%         test_adsharp - Test the adsharp operation
%         test_conj - Test the conjugate operation of dq
%         test_sharp - Test the sharp conjugate operation of dq
%         test_normalize - Test the normalize operation of dq
%         test_translation - Test the translation operation of unit dq.
%         test_rotation
%         test_of_log
%         test_of_exp
%         test_of_rotation_axis
%         test_of_rotation_angle
%       
%----------------------------------------------------------------------
%--------------------how to get the mat file---------------------------
% clear all;
% close all;
% 
% NUMBER_OF_RANDOM = 1000;
% 
% %% Generate data for unary and binary operators
% random_dq_a = random('unif',-10,10,[8 NUMBER_OF_RANDOM]);
% random_dq_b = random('unif',-10,10,[8 NUMBER_OF_RANDOM]);
% 
% %% Binary
% result_of_plus = zeros(8, NUMBER_OF_RANDOM);
% result_of_minus = zeros(8, NUMBER_OF_RANDOM);
% result_of_times = zeros(8, NUMBER_OF_RANDOM);
% result_of_dot = zeros(8, NUMBER_OF_RANDOM);
% result_of_cross = zeros(8, NUMBER_OF_RANDOM);
% result_of_Ad = zeros(8, NUMBER_OF_RANDOM);
% result_of_Adsharp = zeros(8, NUMBER_OF_RANDOM);
% 
% %% Unary
% result_of_conj = zeros(8, NUMBER_OF_RANDOM);
% result_of_sharp = zeros(8, NUMBER_OF_RANDOM);
% 
% result_of_normalize = zeros(8, NUMBER_OF_RANDOM);
% result_of_translation = zeros(8, NUMBER_OF_RANDOM);
% result_of_rotation = zeros(8, NUMBER_OF_RANDOM);
% result_of_log = zeros(8, NUMBER_OF_RANDOM);
% result_of_exp = zeros(8, NUMBER_OF_RANDOM);
% result_of_rotation_axis = zeros(8, NUMBER_OF_RANDOM);
% result_of_rotation_angle = zeros(8, NUMBER_OF_RANDOM);
% 
% %% Loop
% for i=1:NUMBER_OF_RANDOM
%     %% Binary
%     result_of_plus(:,i) = vec8(DQ(random_dq_a(:,i))+DQ(random_dq_b(:,i)));
%     result_of_minus(:,i) = vec8(DQ(random_dq_a(:,i))-DQ(random_dq_b(:,i)));
%     result_of_times(:,i) = vec8(DQ(random_dq_a(:,i))*DQ(random_dq_b(:,i)));
%     result_of_dot(:,i) = vec8(dot(DQ(random_dq_a(:,i)),DQ(random_dq_b(:,i))));
%     result_of_cross(:,i) = vec8(cross(DQ(random_dq_a(:,i)),DQ(random_dq_b(:,i))));
%     result_of_Ad(:,i) = vec8(Ad(DQ(random_dq_a(:,i)),DQ(random_dq_b(:,i))));
%     result_of_Adsharp(:,i) = vec8(Adsharp(DQ(random_dq_a(:,i)),DQ(random_dq_b(:,i))));
%     
%     %% Unary
%     result_of_conj(:,i) = vec8(conj(DQ(random_dq_a(:,i))));
%     result_of_sharp(:,i) = vec8(sharp(DQ(random_dq_a(:,i))));
%     
%     result_of_normalize(:,i) = vec8(normalize(DQ(random_dq_a(:,i))));
%     result_of_translation(:,i) = vec8(translation(normalize(DQ(random_dq_a(:,i)))));
%     result_of_rotation(:,i) = vec8(rotation(normalize(DQ(random_dq_a(:,i)))));
%     result_of_log(:,i) = vec8(log(normalize(DQ(random_dq_a(:,i)))));
%     result_of_exp(:,i) = vec8(exp(get_pure(DQ(random_dq_a(:,i)))));
%     result_of_rotation_axis(:,i) = vec8(DQ(rotation_axis(normalize(DQ(random_dq_a(:,i))))));
%     result_of_rotation_angle(:,i) = vec8(DQ(rotation_angle(normalize(DQ(random_dq_a(:,i))))));
%     
% end
% 
% save DQ_test.mat
% 
% function ret = get_pure(dq)
%     ret = DQ(vec6(dq));
% end
%----------------------------------------------------------------------
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

classdef DQTestCase < matlab.unittest.TestCase
    %DQTESTCASE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mat;
        tolerance = 1e-15;
        almost_equal_tolerance = 1e-11;
    end
    
    methods
        function testCase = DQTestCase()
            data = load('DQ_test.mat');
            testCase.mat = data;                  
        end   
    end
    
    methods (Test)
        function test_constructor_valid(testCase)           
            
            %-------- Eight
            testCase.assertEqual(DQ([1, 2, 3, 4, 5, 6, 7, 8]),...
                DQ([1, 2, 3, 4, 5, 6, 7, 8]),"Incorrect 8 elements constructor")
            
            %-------- Six
            testCase.assertEqual(DQ([1, 2, 3, 4, 5, 6]),...
                DQ([0, 1, 2, 3, 0, 4, 5, 6]),"Incorrect 6 elements constructor")
            
            %-------- Three
            testCase.assertEqual(DQ([1, 2, 3]),...
                DQ([0, 1, 2, 3, 0, 0, 0, 0]),"Incorrect 3 elements constructor")
            
                        
            %-------- Four
            testCase.assertEqual(DQ([1, 2, 3, 4]),...
                DQ([1, 2, 3, 4, 0, 0, 0, 0]),"Incorrect 4 elements constructor")
            
            %-------- One
            testCase.assertEqual(DQ(1),...
                DQ([1, 0, 0, 0, 0, 0, 0, 0]),"Incorrect 1 element constructor")            
        end
        
        function test_contructor_invalid(testCase)
            %-------- Two  
            verifyError(testCase,@() DQ([1, 2]),'');
            
            %-------- Five 
            verifyError(testCase,@() DQ([1, 2, 3, 4, 5]),'');
            
            %-------- Seven  
            verifyError(testCase,@() DQ([1, 2, 3, 4, 5, 6, 7]),''); 
        end
        
        %----Binary operators
        function test_plus(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_plus(:,i);
                testCase.assertEqual(a+b, c, "AbsTol", testCase.tolerance,...
                    "Error in +")          
            end         
        end
        
        function test_minus(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_minus(:,i);
                testCase.assertEqual(a-b, c,"AbsTol", testCase.tolerance,...
                    "Error in -")               
            end         
        end
        
        function test_times(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_times(:,i);                
                testCase.assertEqual(vec8(DQ(a)*DQ(b)), vec8(DQ(c)),...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in *");     
                % The absolute tolerance is used because of small
                % discrepancies in the results. 
            end         
        end   
        
        function test_dot(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_dot(:,i);
                testCase.assertEqual(vec8(dot(DQ(a),DQ(b))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in dot")               
            end         
        end    
        
        function test_cross(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_cross(:,i);
                testCase.assertEqual(vec8(cross(DQ(a),DQ(b))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in cross")               
            end         
        end 
        
        function test_ad(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_Ad(:,i);
                testCase.assertEqual(vec8(Ad(DQ(a),DQ(b))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in Ad")               
            end         
        end   
        
        function test_adsharp(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_Adsharp(:,i);
                testCase.assertEqual(vec8(Adsharp(DQ(a),DQ(b))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in Adsharp")               
            end         
        end 
        %----Unary operators
        function test_conj(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                
                c = testCase.mat.result_of_conj(:,i);
                testCase.assertEqual(vec8(conj(DQ(a))), c,...
                    "AbsTol", testCase.tolerance, "Error in conj")               
            end         
        end   
        
        function test_sharp(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                 
                c = testCase.mat.result_of_sharp(:,i);
                testCase.assertEqual(vec8(sharp(DQ(a))), c,...
                    "AbsTol", testCase.tolerance, "Error in sharp")               
            end         
        end     
        
        function test_normalize(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                
                c = testCase.mat.result_of_normalize(:,i);
                testCase.assertEqual(vec8(normalize(DQ(a))), c,...
                    "AbsTol", testCase.tolerance, "Error in normalize")               
            end         
        end   
        
        function test_translation(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                 
                c = testCase.mat.result_of_translation(:,i);
                testCase.assertEqual(vec8(translation(normalize(DQ(a)))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in translation")               
            end         
        end     
        %--       
        function test_rotation(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                
                c = testCase.mat.result_of_rotation(:,i);
                testCase.assertEqual(vec8(rotation(normalize(DQ(a)))), c,...
                    "AbsTol", testCase.tolerance, "Error in rotation")               
            end         
        end   
        
        function test_of_log(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                
                c = testCase.mat.result_of_log(:,i);
                testCase.assertEqual(vec8(log(normalize(DQ(a)))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in log")               
            end         
        end     
        
        function test_of_exp(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                
                c = testCase.mat.result_of_exp(:,i);
                testCase.assertEqual(vec8(exp(DQ(vec6(DQ(a)) ))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in exp")               
            end         
        end   
        
        function test_of_rotation_axis(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                 
                c = testCase.mat.result_of_rotation_axis(:,i);
                testCase.assertEqual(vec8(rotation_axis(normalize(DQ(a)))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in rotation axis")               
            end         
        end 
        
        function test_of_rotation_angle(testCase)            
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                 
                c = testCase.mat.result_of_rotation_angle(:,i);
                testCase.assertEqual(vec8(DQ(rotation_angle(normalize(DQ(a))))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in rotation angle")               
            end         
        end         
        
    end
end

