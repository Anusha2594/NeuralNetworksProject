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
error =0;
epochs = 200;
isDecaying = 1;
decayingRate = 0.8;
isAdaptive = 0;
positiveRate = 1.02;
treshold = 1.03;
%Delta Training Rule batch start with decaying rate
tstartBatch = tic;
[wBatch,iterationsBatch,eBatch,ePerIterationBatch,predictedWBatch]=DeltaRuleTrainingBatch(data, target, eta, error, epochs,isDecaying,decayingRate,isAdaptive, positiveRate, treshold);
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
%delta training rule batch end
