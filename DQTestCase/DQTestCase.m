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
%         test_constructor_valid - Tests if a dq constructor is valid
%         test_contructor_invalid - Tests if a dq constructor is invalid
%         test_plus  - Tests the dual quaternion addition
%         test_minus - Tests the dual quaternion subtraction
%         test_times - Tests the dual quaternion multiplication
%         test_dot  - Tests the dot product between two pure dual quaternions
%         test_cross - Tests the cross product between two pure dual quaternions
%         test_ad    - Tests the adjoint operation
%         test_adsharp - Tests the adsharp operation
%         test_conj - Tests the conjugate operation of dq
%         test_sharp - Tests the sharp conjugate operation of dq
%         test_normalize - Tests the normalize operation of dq
%         test_translation - Tests the translation operation of unit dq
%         test_rotation - Tests the rotation operation of the unit dq
%         test_of_log - Tests the logarithm operation of dq
%         test_of_exp - Tests the exponential operation of pure dq
%         test_of_rotation_axis - Tests the rotation axis operation of unit dq
%         test_of_rotation_angle - Tests the rotation angle operation of unit dq
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
        % MAT corresponds to the m-file that contains the tested results. (See above)
        mat;  
        % TOLERANCE is used to compare if two results are equal.
        tolerance = 1e-15;  
        % This is used to compare if two results are equal but using a lower tolerance.
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
            % Tests the five ways to construct a dual quaternion.
            % This method uses the function assertEqual(actual, expected, message), which 
            % assert that actual is strictly equal to expected. 
            % More information:
            % https://www.mathworks.com/help/matlab/ref/matlab.unittest.qualifications.assertable-class.html
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
            % Tests the three incorrect ways to construct a dual
            % quaternion. If the DQ library raises an error, then this test
            % is passed.
            % [output1,...,outputN] = assertError(testCase,actual,identifier,diagnostic)
            % Assert that actual is a function handle that throws the exception specified by identifier.
            % More information:
            % https://www.mathworks.com/help/matlab/ref/matlab.unittest.qualifications.assertable-class.html
            %-------- Two  
            assertError(testCase,@() DQ([1, 2]),'');
            
            %-------- Five 
            assertError(testCase,@() DQ([1, 2, 3, 4, 5]),'');
            
            %-------- Seven  
            assertError(testCase,@() DQ([1, 2, 3, 4, 5, 6, 7]),''); 
        end
        
        %----Binary operators
        function test_plus(testCase)  
            % Tests the the dual quaternion addition
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_plus(:,i);
                testCase.assertEqual(a+b, c, "AbsTol", testCase.tolerance,...
                    "Error in +")          
            end         
        end
        
        function test_minus(testCase) 
            %Tests the dual quaternion subtraction
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_minus(:,i);
                testCase.assertEqual(a-b, c,"AbsTol", testCase.tolerance,...
                    "Error in -")               
            end         
        end
        
        function test_times(testCase)
            % Tests the dual quaternion multiplication
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_times(:,i);                
                testCase.assertEqual(vec8(DQ(a)*DQ(b)), vec8(DQ(c)),...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in *");     
                % The almost_equal_tolerance is used because of small
                % discrepancies in the results. 
            end         
        end   
        
        function test_dot(testCase) 
            % Tests the dot product between two pure dual quaternions.
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_dot(:,i);
                testCase.assertEqual(vec8(dot(DQ(a),DQ(b))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in dot") 
                % The almost_equal_tolerance is used because of small
                % discrepancies in the results. 
            end         
        end    
        
        function test_cross(testCase)  
            % Test the cross product between two pure dual uaternions
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_cross(:,i);
                testCase.assertEqual(vec8(cross(DQ(a),DQ(b))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in cross")
                % The almost_equal_tolerance is used because of small
                % discrepancies in the results. 
            end         
        end 
        
        function test_ad(testCase)
            % Tests the adjoint operation
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_Ad(:,i);
                testCase.assertEqual(vec8(Ad(DQ(a),DQ(b))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in Ad") 
                % The almost_equal_tolerance is used because of small
                % discrepancies in the results.                
            end         
        end   
        
        function test_adsharp(testCase)
            % Tests the adsharp operation
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i); 
                b = testCase.mat.random_dq_b(:,i);
                c = testCase.mat.result_of_Adsharp(:,i);
                testCase.assertEqual(vec8(Adsharp(DQ(a),DQ(b))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in Adsharp")
                % The almost_equal_tolerance is used because of small
                % discrepancies in the results.                 
            end         
        end 

        %----Unary operators
        function test_conj(testCase)    
            % Tests the conjugate operation of dual quaternions
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                
                c = testCase.mat.result_of_conj(:,i);
                testCase.assertEqual(vec8(conj(DQ(a))), c,...
                    "AbsTol", testCase.tolerance, "Error in conj")               
            end         
        end   
        
        function test_sharp(testCase)
            % Tests the sharp conjugate operation of dual quaternions
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                 
                c = testCase.mat.result_of_sharp(:,i);
                testCase.assertEqual(vec8(sharp(DQ(a))), c,...
                    "AbsTol", testCase.tolerance, "Error in sharp")               
            end         
        end     
        
        function test_normalize(testCase) 
            % Tests the normalize operation of dual quaternions
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                
                c = testCase.mat.result_of_normalize(:,i);
                testCase.assertEqual(vec8(normalize(DQ(a))), c,...
                    "AbsTol", testCase.tolerance, "Error in normalize")               
            end         
        end   
        
        function test_translation(testCase)   
            % Tests the translation operation of unit dual quaternions
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                 
                c = testCase.mat.result_of_translation(:,i);
                testCase.assertEqual(vec8(translation(normalize(DQ(a)))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in translation")
                % The almost_equal_tolerance is used because of small
                % discrepancies in the results.
            end         
        end 
       
        function test_rotation(testCase)  
            % Tests the rotation operation of the unit dual quaternions
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                
                c = testCase.mat.result_of_rotation(:,i);
                testCase.assertEqual(vec8(rotation(normalize(DQ(a)))), c,...
                    "AbsTol", testCase.tolerance, "Error in rotation")               
            end         
        end   
        
        function test_of_log(testCase)
            %  Tests the logarithm operation of dual quaternions
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                
                c = testCase.mat.result_of_log(:,i);
                testCase.assertEqual(vec8(log(normalize(DQ(a)))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in log") 
                % The almost_equal_tolerance is used because of small
                % discrepancies in the results.
            end         
        end     
        
        function test_of_exp(testCase)  
            % Tests the exponential operation of pure dual quaternions
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                
                c = testCase.mat.result_of_exp(:,i);
                testCase.assertEqual(vec8(exp(DQ(vec6(DQ(a)) ))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in exp")
                % The almost_equal_tolerance is used because of small
                % discrepancies in the results.
            end         
        end   
        
        function test_of_rotation_axis(testCase) 
            % Tests the rotation axis operation of unit dual quaternions
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                 
                c = testCase.mat.result_of_rotation_axis(:,i);
                testCase.assertEqual(vec8(rotation_axis(normalize(DQ(a)))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in rotation axis")
                % The almost_equal_tolerance is used because of small
                % discrepancies in the results.
            end         
        end 
        
        function test_of_rotation_angle(testCase) 
            % Tests the rotation angle operation of unit dual quaternions
            for i=1:testCase.mat.NUMBER_OF_RANDOM
                a = testCase.mat.random_dq_a(:,i);                 
                c = testCase.mat.result_of_rotation_angle(:,i);
                testCase.assertEqual(vec8(DQ(rotation_angle(normalize(DQ(a))))), c,...
                    "AbsTol", testCase.almost_equal_tolerance, "Error in rotation angle") 
                % The almost_equal_tolerance is used because of small
                % discrepancies in the results.
            end         
        end         
        
    end
end

