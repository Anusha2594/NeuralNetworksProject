function [w, iterations, e,ePerIteration,predictedW]=DeltaRuleTraining(Data, Target, eta, error, epochs)
%% Invoke as: [w, iterations, e] = DeltaRuleTraining(Data, Target, eta, error, epochs)
%% implements the delta  rule;
%% Input:
%%  Data is a matrix N x P data points/vectors
%%  Target is vector N x 1 of target values (true output) corresponding to the data points
%%  eta: learning rate; 
%%  error : desired approximation error;
%%  epochs: threshold on the number of epochs (iterations through the whole
%% data set)
%% Output:
%%  w is a vector of dimension P+1 x 1, where w_i is the weight for dimension i of a data point,
%%     for i=1:P, extended with weight w0 for the bias (input = 1)
%%  iterations = MIN{is the number of iterations taken to reach error threshold e, epochs}
%%  e: error threshold
predictedW = zeros(4,3);
[rd, cd]=size(Data);
[rt, ct]=size(Target);
if rd ~= rt
    error('num data points not equal to num target');
else
 w=rand(1,cd+1);
 iterations=0;
 ePerIteration=zeros(5,1);
 e=error;
while e >= error &&  iterations < epochs
 iterations=iterations+1;
 wrong=0;
 for i=1:rd
     out(i) = sum(w .* [Data(i,:),1]);  % delta rule 
     
% % %      %%%%% Perceptron rule 
% % %      temp=sum(w .* [Data(i,:),1]);
% % %      if temp < 0
% % %          out(i) = -1;
% % %      else
% % %          out(i)=+1;
% % %      end %%%%%%%%%% perceptron rule
     deltaw=eta*(Target(i)-out(i))*[Data(i,:),1];
     w=w+deltaw;
     err(i)=0.5*((Target(i)- out(i))^2);
     if err(i)>0
         wrong=wrong+1;
     end
 end  % for i=1:rd 
% total error for perceptron
% e=wrong/rd;

% error for delta rule
 e=sum(err)/rd;
 ePerIteration(iterations)=e;
    switch iterations
        case 5
            predictedW(1,:)=w;
        case 10
            predictedW(2,:)=w;
        case 50
            predictedW(3,:)=w;
        case 100
            predictedW(4,:)=w;
        otherwise
            
    end
end
end