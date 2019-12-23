dataOriginal = importdata('hayes-roth.data');
dataOriginalTest = importdata('hayes-roth.test');
dataTest = dataOriginalTest(:,[1,2,3,4]);
[rdTest, cdTest]=size(dataOriginalTest);
data = dataOriginal(:,[2,3,4,5]);
[rd, cd]=size(data);
target = dataOriginal(:,[6]);
targetClassTest = dataOriginalTest(:,[5]);
T = dataOriginal(:,[6]);
eta = 0.0005;
error =0.25;
epochs = 50000;
%Delta Training Rule incremental start with adaptive rates
[w,iterations,e,ePerIteration,predictedW]=DeltaRuleTrainingInc_P3(data, target, eta, error, epochs);
[predictedRD, predictedCD]=size(predictedW);
xAxis = zeros(iterations,1);
for i=1:iterations
    xAxis(i)=i;
end
figure(1);
plot(xAxis,ePerIteration);
title('Incremental');
xlabel('No. of Iterations');
ylabel('Error');
%delta training rule incremental end

%testing
PredictedValues = zeros(rdTest,1);
for i=1:rdTest
    PredictedValues(i) = round(mod(DeltaRuleTesting(dataTest(i,:),predictedW(5,:)),3));
end

noOfCorrectPreds = 0;
for i=1:rdTest
    if PredictedValues(i) == targetClassTest(i)
        noOfCorrectPreds = noOfCorrectPreds+1;
    end
end

accuracy = (noOfCorrectPreds/rdTest)*100;
