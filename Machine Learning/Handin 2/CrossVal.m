function [res] = CrossVal(data,model)
%CrossValidate to find hyperparameters!
% data is preproccesed data
% model is 0 (linear), 1 (poly) or 2 (rfb)
a = size(data.au_train_digits(:,1));
a = a(1);
b = round(a/10); %size of testset


trainLabels = data.au_train_labels(b+1:a,:);
trainData = data.au_train_digits(b+1:a,:);

testLabels = data.au_train_labels(1:b,:);
testData = data.au_train_digits(1:b,:);

res = zeros(10,3);

%startvalues for hyperparameters
c = 2^(-3); %to 2^15
cmax = 2^15;
cstep = 2^2;

g = 2^(-15); %to 2^3
gmax = 2^3;
gstep = 2^2;

d = 1; %dunno yet


bestAcc = 0;
bestC = 0;
bestG = 0;
%rfb kernel:
if(model==2)
    for i=g:gstep:gmax
        for k=c:cstep:cmax
        libsvm_options = sprintf('-s 0 -c %d -g %d -t %d -v 5',k,i,model);
        acc = svmtrain(trainLabels,trainData,libsvm_options);
            if (acc>=bestAcc)
                bestAcc = acc; 
                bestC = k;
                bestG = i;
            end
        end
    end
fprintf('best acc %d, best C %d, best G %d',bestAcc,bestC,bestG);
end

end

