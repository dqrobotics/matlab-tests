classdef DQ_TestBasicOperations < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Test)
        function test_basic_multiplications(test_case)
            include_namespace_dq;
            % Most basic multiplication test that evaluates
            % i^2=j^2=k^2=i*j*k = -1 and i*j=k, k*i=j, j*k=i
            actual_solution = i_*i_;
            expected_solution = DQ(-1);
            test_case.verifyEqual(actual_solution,expected_solution);
            
            actual_solution = j_*j_;
            expected_solution = DQ(-1);
            test_case.verifyEqual(actual_solution,expected_solution);
            
            actual_solution = k_*k_;
            expected_solution = DQ(-1);
            test_case.verifyEqual(actual_solution,expected_solution);
            
            actual_solution = i_*j_*k_;
            expected_solution = DQ(-1);
            test_case.verifyEqual(actual_solution,expected_solution);
            
            actual_solution = i_*j_;
            expected_solution = k_;
            test_case.verifyEqual(actual_solution,expected_solution);
            
            actual_solution = j_*k_;
            expected_solution = i_;
            test_case.verifyEqual(actual_solution,expected_solution);
            
            actual_solution = k_*i_;
            expected_solution = j_;
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
        function test_basic_addition(test_case)
            expected_solution = DQ(0);
            h = rand(8,1);
            dq1 = DQ(h);
            dq2 = DQ(-h);
            actual_solution = dq1+dq2;
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
        function test_basic_subtraction(test_case)
            expected_solution = DQ(0);
            h = rand(8,1);
            dq1 = DQ(h);
            dq2 = DQ(h);
            actual_solution = dq1-dq2;
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
       
    end
end

