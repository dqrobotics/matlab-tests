classdef DQ_TestBasicOperations < matlab.unittest.TestCase
    % DQ_TestBasicOperations performs simple tests using hard coded operations.
    %   
    % This class perform the most basic tests regarding dual quaternion
    % operations, operators, and relations. If one of those tests fails, it
    % means that probably all more complex tests will fail as well.
    % 
    % Since tests are hardcoded (e.g., i_*i_ = -1), they evaluate just some
    % very specific cases for all DQ operations
    
    properties
        dq = DQ([1 2 3 4 5 6 7 8]);
    end
    
    methods (Test)
        
        % TODO: test different constructors
        
        
        function test_multiplications(test_case)
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
        
        function test_addition(test_case)
            expected_solution = DQ(0);
            h = rand(8,1);
            dq1 = DQ(h);
            dq2 = DQ(-h);
            actual_solution = dq1+dq2;
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
        function test_subtraction(test_case)
            expected_solution = DQ(0);
            h = rand(8,1);
            dq1 = DQ(h);
            dq2 = DQ(h);
            actual_solution = dq1-dq2;
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
        function test_right_division(test_case)
            expected_solution = DQ(1);
            h = rand(8,1);
            dq1 = DQ(h);    
            dq2 = DQ(h);   
            actual_solution = dq1/dq2;
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
        function test_left_division(test_case)
            expected_solution = DQ(1);
            h = rand(8,1);
            dq1 = DQ(h);   
            dq2 = DQ(h); 
            actual_solution = dq1\dq2;
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
        function test_unary_minus(test_case)
            h = rand(8,1);
            expected_solution = DQ(-h);
            actual_solution = -DQ(h);
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
        function test_conjugate(test_case)
            h = test_case.dq;
            expected_solution = DQ([1, -2, -3, -4, 5, -6, -7, -8]);
            actual_solution = h';            
            test_case.verifyEqual(actual_solution,expected_solution);
            
            actual_solution = conj(h);            
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
        %TODO .' and sharp conjugate
        
        function test_log(test_case)
            include_namespace_dq;
            n = k_;
            phi = pi/2;
            p = 1*i_ +  2*j_ + 3*k_;
            r = cos(phi/2) + n * sin(phi/2); 
            x = r + 0.5*E_*p*r;
            
            expected_solution = 0.5*(n*phi + E_*p);
            
            actual_solution = log(x);            
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
        function test_exp(test_case)
            include_namespace_dq;
            n = k_;
            phi = pi/2;
            p = 1*i_ +  2*j_ + 3*k_;
            r = cos(phi/2) + n * sin(phi/2); 
            y = 0.5*(n*phi + E_*p);
            
            expected_solution = r + 0.5*E_*p*r;
            actual_solution = exp(y);            
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
        function test_inv(test_case)
            n = k_;
            phi = pi/2;
            p = 1*i_ +  2*j_ + 3*k_;
            r = cos(phi/2) + n * sin(phi/2); 
            x = r + 0.5*E_*p*r;
            
            rconj = cos(phi/2) - n * sin(phi/2);
            
            % Since we're using a unit dual quaternion, its inverse  equals
            % its conjugate.
            expected_solution = rconj - 0.5*E_*rconj*p;
            actual_solution = inv(x);
            
            test_case.verifyEqual(actual_solution,expected_solution);
        end
        
        function test_hami4(test_case)
            r = normalize(DQ(rand(4,1)));
            Hplus = hamiplus4(r);
            Hminus = haminus4(r);
            
            expected_solution(eye(4));
            
            %The Hamilton operator of a unit quaternion belongs to O(4).
            %Thus, the inverse equals the transpose. Furthermore, the
            %tranpose equals the Hamilton operator of the conjugate.
            actual_solution = Hplus*Hplus';
            test_case.verifyEqual(actual_solution,expected_solution);
            
            actual_solution = Hplus*hamiplus4(r');
            test_case.verifyEqual(actual_solution,expected_solution);
            
            actual_solution = Hminus*Hminus';
            test_case.verifyEqual(actual_solution,expected_solution);
            
            actual_solution = Hminus*haminus4(r');
            test_case.verifyEqual(actual_solution,expected_solution);
            
            %Let's perform some multiplications using normal dual
            %quaternion multiplications
            
            a = DQ(rand(4,1));
            b = DQ(rand(4,1));
            
            expected_solution(DQ(0));
            
            actual_solution = a*b - DQ(hamiplus4(a)*vec4(b));
            test_case.verifyEqual(actual_solution,expected_solution);
            
            actual_solution = a*b - DQ(haminus4(b)*vec4(a));
            test_case.verifyEqual(actual_solution,expected_solution);
        end
    end
end

