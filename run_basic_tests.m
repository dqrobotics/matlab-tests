result = runtests('DQ_TestBasicOperations');

for i = 1:length(result)
    if result(i).Failed
       exit(1,"force");      
    end
end


result = runtests('DQ_TestCase');

for i = 1:length(result)
    if result(i).Failed
       exit(1,"force");      
    end
end


result = runtests('DQ_KinematicsTestCase');

for i = 1:length(result)
    if result(i).Failed
       exit(1,"force");      
    end
end
exit(0)
