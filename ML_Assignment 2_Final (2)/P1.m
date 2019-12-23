data = zeros(10,2);
[rd, cd]=size(data);
target = zeros(10,1);
T = zeros(10,1);
for i=1:10
   x1= (rand()-0.5)*10;
   x2 = (rand()-0.5)*10;
   temp = x1 + 2*x2 - 2;
   if temp > 0
       y = 1;
   else
       y = -1;
   end
   data(i,1) = x1;
   data(i,2)=x2;
   T(i) = y;
   target(i) = temp;
end
eta = 0.0001;
error = 0.1;
epochs = 150;
%Delta Training Rule batch start
tstartBatch = tic;
[wBatch,iterationsBatch,eBatch,ePerIterationBatch,predictedWBatch]=DeltaRuleTrainingBatch(data, target, eta, error, epochs,Decaying,decRate,Adaptive, positiveRate, treshold);
[predictedRDBatch, predictedCDBatch]=size(predictedWBatch);
tendBatch = toc(tstartBatch);
xAxisBatch = zeros(iterationsBatch,1);
for i=1:iterationsBatch
    xAxisBatch(i)=i;
end
figure(1);
plot(xAxisBatch,ePerIterationBatch);
title('Batch');
xlabel('No. of Iterations');
ylabel('Error');

figure(2);
title('Batch');
for i=1:predictedRDBatch
    m = ((-1)*predictedWBatch(i,1))/predictedWBatch(i,2);
    yIntercept = ((-1)*predictedWBatch(i,3))/predictedWBatch(i,2);
    x = -10:10;
    a = plot(x, ((m*x)+yIntercept));
    hold on;
end
legend({'5 iterations','10 iterations','50 iterations','100 iterations'},'Location','southwest')
m = -0.5;
yIntercept = 1;
x = -10:10;
plot(x, ((m*x)+yIntercept));
hold on;
for i=1:rd
    if T(i) == 1
        s = 'r*';
    else
        s = 'b*';
    end
    plot(data(i,1),data(i,2),s);
    hold on;
end
hold off;
%Batch delta training rule end

%Incremental Delta Training Rule start
tstart = tic;
[w,iterations,e,ePerIteration,predictedW]=DeltaRuleTraining(data, target, eta, error, epochs);
[predictedRD, predictedCD]=size(predictedW);
tend = toc(tstart);
xAxis = zeros(iterations,1);
for i=1:iterations
    xAxis(i)=i;
end
figure(3);
plot(xAxis,ePerIteration);
title('Incremental');
xlabel('No. of Iterations');
ylabel('Error');

figure(4);
title('Incremental');
for i=1:predictedRD
    m = ((-1)*predictedW(i,1))/predictedW(i,2);
    yIntercept = ((-1)*predictedW(i,3))/predictedW(i,2);
    x = -10:10;
    a = plot(x, ((m*x)+yIntercept));
    hold on;
end
legend({'5 iterations','10 iterations','50 iterations','100 iterations'},'Location','southwest')
m = -0.5;
yIntercept = 1;
x = -10:10;
plot(x, ((m*x)+yIntercept));
hold on;
for i=1:rd
    if T(i) == 1
        s = 'r*';
    else
        s = 'b*';
    end
    plot(data(i,1),data(i,2),s);
    hold on;
end
hold off;
%Incremental delta training rule  end