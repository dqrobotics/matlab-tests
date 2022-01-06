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
        Property1
    end
    
    methods
%         Defining constructor or destructor methods in a TestCase subclass is
%         not recommended. TestCase constructor and destructor methods are not
%         considered test content and should not be used to perform qualifications.
%         (https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html)
%         function obj = DQTestCase(inputArg1,inputArg2)
%         end       

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
        
        function test_plus(testCase)
        end
    end
end

