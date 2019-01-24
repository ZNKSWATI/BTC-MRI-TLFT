%% Fine Tuning VGG19
% This example shows how to fine tune a pre-trained deep convolutional
% neural network (CNN) VGG19 for classification of brain tumors
% gpuDevice()
% %% Load Image Data
% % Data is 5 fold 3 types of tumor
% % Create an imageDataStore to read images

trainingDS = imageDatastore('/home/swati/Documents/MATLAB/five_fold/dataset1/trainingDS1',...
    'IncludeSubfolders',true,'LabelSource','foldernames');
testDS = imageDatastore('/home/swati/Documents/MATLAB/five_fold/dataset1/testDS1',...
    'IncludeSubfolders',true,'LabelSource','foldernames');
tbl = countEachLabel(trainingDS)

%% Load Pre-trained VGG19
net=vgg19;
%% Look at structure of pre-trained network
% Notice the last layer performs 1000 object classification

% read the network layers
net.Layers

%% Perform net surgery
% The pre-trained layers at the end of the network are designed to classify
% 1000 objects. But we need to classify different objects now. So the
% first step in transfer learning is to replace the last 3 layers of the
% pre-trained network with a set of layers that can classify 3 classes.

% Get the layers from the network. the layers define the network
% architecture and contain the learned weights. Here we only need to keep
% everything except the last 3 layers.

layers = net.Layers(1:end-3);

% Add fullyConnectedLayer layer to network

layers(end+1) = fullyConnectedLayer(height(tbl), 'Name', 'fc8');

% Add the softmax layer and the classification layer which make up the
% remaining portion of the networks classification layers.
layers(end+1) = softmaxLayer('Name','Softmax');
layers(end+1) = classificationLayer('name', 'classifier');

%The size of the input images is set to the
% original networks input size.
layers(1) = imageInputLayer([224 224 3]);

% show the modified network
layers

%% Setup learning rates for fine-tuning
% For fine-tuning, we want to changed the network ever so slightly. How
% much a network is changed during training is controlled by the learning
% rates. Here we modify the learning rates of the original layers,

% WeightLearnRateFactor 
wlrf=0.1;

%BiasLearnRateFactor
blrf=0.2;

% B1 - 
layers(2).WeightLearnRateFactor = wlrf;
layers(2).BiasLearnRateFactor = blrf;
layers(4).WeightLearnRateFactor = wlrf;
layers(4).BiasLearnRateFactor = blrf;

%B2
layers(7).WeightLearnRateFactor = wlrf;
layers(7).BiasLearnRateFactor = blrf;
layers(9).WeightLearnRateFactor = wlrf;
layers(9).BiasLearnRateFactor = blrf;

%B3
layers(12).WeightLearnRateFactor = wlrf;
layers(12).BiasLearnRateFactor = blrf;
layers(14).WeightLearnRateFactor = wlrf;
layers(14).BiasLearnRateFactor = blrf;
layers(16).WeightLearnRateFactor = wlrf;
layers(16).BiasLearnRateFactor = blrf;
layers(18).WeightLearnRateFactor = wlrf;
layers(18).BiasLearnRateFactor = blrf;

%B4
layers(21).WeightLearnRateFactor = wlrf;
layers(21).BiasLearnRateFactor = blrf;
layers(23).WeightLearnRateFactor = wlrf;
layers(23).BiasLearnRateFactor = blrf;
layers(25).WeightLearnRateFactor = wlrf;
layers(25).BiasLearnRateFactor = blrf;
layers(27).WeightLearnRateFactor = wlrf;
layers(27).BiasLearnRateFactor = blrf;

%B5
layers(30).WeightLearnRateFactor = wlrf;
layers(30).BiasLearnRateFactor = blrf;
layers(32).WeightLearnRateFactor = wlrf;
layers(32).BiasLearnRateFactor = blrf;
layers(34).WeightLearnRateFactor = wlrf;
layers(34).BiasLearnRateFactor = blrf;
layers(36).WeightLearnRateFactor = wlrf;
layers(36).BiasLearnRateFactor = blrf;

%B6
layers(39).WeightLearnRateFactor = wlrf;
layers(39).BiasLearnRateFactor = blrf;
layers(42).WeightLearnRateFactor = wlrf;
layers(42).BiasLearnRateFactor = blrf;
layers(45).WeightLearnRateFactor = wlrf;
layers(45).BiasLearnRateFactor = blrf;

%% images of each class in training set

trainingDS.Labels = categorical(trainingDS.Labels);
trainingDS.ReadFcn = @readFunctionTrain;
% Setup test data for validation
testDS.Labels = categorical(testDS.Labels);
testDS.ReadFcn = @readFunctionValidation;

%% Fine-tune the Network

miniBatchSize = 64; % lower this if your GPU runs out of memory.
numImages = numel(trainingDS.Files);

% Run training for 5000 iterations. Convert 20000 iterations into the
% number of epochs this will be.
maxEpochs = 100 % one complete pass through the training data
% batch size is the number of images it processes at once. Training
% algorithm chunks into manageable sizes. 
lr = 0.01;
lrs=0.9;
u=0.9;
opts = trainingOptions('sgdm', ...
    'L2Regularization',0.001,...
    'InitialLearnRate', lr,... 
    'LearnRateSchedule', 'piecewise',... 
    'LearnRateDropFactor', lrs,...
    'LearnRateDropPeriod',5,...
    'Momentum', u,...
    'MaxEpochs', maxEpochs, ...
    'MiniBatchSize', miniBatchSize,...
    'ValidationData', testDS,...
    'ValidationPatience',15,...
    'ValidationFrequency',38,...
    'VerboseFrequency',38,...
    'CheckpointPath', '/home/swati/Documents/MATLAB/Code/',... % path to save trained model 
    'Plot','training-progress');
[net,history] = trainNetwork(trainingDS, layers, opts);
save('history.mat','history')
save('trainingDS.mat','trainingDS')
save('trainedNet.mat','net')
save('testDS.mat','testDS')
% This could take over an hour to run, so lets stop and load a pre-traiend
% version that used the same data
return % the script will stop here if you run the entire file
%% Load in a previously saved network and test set
load('trainedNet.mat');
load('testDS.mat');
%% Test 3-class classifier on  validation set
% Now run the network on the test data set to see how well it does:
[labels,err_test] = classify(net, testDS, 'MiniBatchSize', 64);
confMat = confusionmat(testDS.Labels, labels);
confMat = bsxfun(@rdivide,confMat,sum(confMat,2));
mean(diag(confMat))
save('labels.mat', 'labels');

%% Can we tell anything about the misses?
idx = find(testDS.Labels == 'meningioma');
misses_only = find(labels(idx) ~= testDS.Labels(idx));
misses_only = idx(misses_only);

%% Check for misses
for ii = 1: length(misses_only)
    idx = misses_only(ii); 
    extra = ' ';
    imshow(imread(testDS.Files{idx})); 
    if(err_test(idx) < .3)
        extra = '?';
    end
    title(sprintf('%s %s',char(labels(idx)),extra)) ;
    
    pause;
end

%% Choose a random image and visualize the results
randNum = randi(length(testDS.Files));
im = readFunctionValidation(testDS.Files{randNum}) ;
label = char(classify(net,im)); % classify with deep learning 
imshow(im);
title(label);

%% We can also see how confident we are
% less than a certain score also shows the second most likely option, can
% set max_score to different confidence lavel
randNum = randi(length(testDS.Files));
im = readFunctionValidation(testDS.Files{randNum}) ;
[label,score] = classify(net,im); % classify with deep learning 
imshow(im);
interesting_title = char(label);
[max_score,idx] = sort(score,'descend');
if(max_score < .66)
    interesting_title = sprintf('%s? or \n');%[strcat(interesting_title,'? or  '), char(10)];
    second = find(score == max_score(2));
    interesting_title = strcat(interesting_title,' ',char(tbl.Label(second)));
end
title(interesting_title);