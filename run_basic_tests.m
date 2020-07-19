result = runtests('DQ_TestBasicOperations')

for i = 1:length(result)
    if result(i).Failed
       error('Some basic operations failed');
    end
end


