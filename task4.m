clear

%% Load data
all_data = load_music_data('Classification music/GenreClassData_30s.txt');
all_data_normalized = data_set_normalizer(all_data);

% Choose features
features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "tempo"];
classes  = ["pop", "disco", "metal", "classical"];
[test_set, training_set] = test_and_training_set(all_data_normalized, features, classes);

dataFeatures = extractfield(training_set,"features");
dataFeatures = reshape(dataFeatures, [length(training_set), length(features)]);

% Define number of classes
numClasses = 4;

% Train GMM classifier
options = statset('MaxIter', 1000);
GMM = fitgmdist(dataFeatures, numClasses, 'Options', options, 'CovarianceType', 'diagonal');

% Compute the likelihood of each point belonging to each component
P = posterior(GMM, dataFeatures);

% Determine the predicted class for each point
[~,pred] = max(P,[],2);

% Predict class labels, alternativ 2
predictedLabels = cluster(GMM, dataFeatures);

% Generate classified_data matrix to calculate error rate and confusion matrix
%uniqueLabels = string(unique(extractfield(all_data,"Genre")));
uniqueLabels = ["pop", "disco", "metal", "classical"]; %= classes
classified_data = training_set;
for i = 1:length(predictedLabels)
    classified_data(i).classified_as = uniqueLabels(predictedLabels(i));
end 

% Confusion matrix and error rate
[confusion_matrix,labels,error_rate] = generate_confusion_matrix(classified_data);

confusion_matrix
error_rate

%uniqueGroups = double(unique(extractfield(all_data,"GenreID")));
%uniqueGroups = double(unique(extractfield(all_data,"Genre")));

% RGB values of your favorite colors: 
colors = ["#FF0000"; "#00FF00"; "#0000FF"; "#00FFFF"; "#FF00FF"; "#000000"; "#FFFFFF"; "#FFFF00"; "#0F0F0F"; "#777777"];

% Initialize some axes
view(3)
grid on
hold on
title('GMM Classifier with Diagonal Covariance')

% Plot each point: 
for k = 1:length(pred)
      for i = 1:length(uniqueLabels)
          if classified_data(k).classified_as == uniqueLabels(i)
             %classified_data(k).classified_as
             %uniqueLabels(i)
             plot3(dataFeatures(k,1), dataFeatures(k,2), dataFeatures(k,3),'.','color',colors(i),'markersize',20); 
          end 
      end 
end
legend('pop', 'disco', 'metal', 'classical')%, 'raggae', 'blues', 'rock', 'hiphop', 'country', 'jazz');
