clear

%% Load data
all_data = load_music_data('Classification music/GenreClassData_30s.txt');
all_data_normalized = data_set_normalizer(all_data);

%% Choose features
features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "mfcc_8_mean"];
features = ["rmse_mean", "chroma_stft_2_std"];
classes  = string(unique(extractfield(all_data, 'Genre')));

classified_data = GMM_classifier(all_data_normalized, features, classes, 2);

[confusion, labels, error_rate] = generate_confusion_matrix(classified_data);

confusion
error_rate

%uniqueGroups = double(unique(extractfield(all_data,"GenreID")));
%uniqueGroups = double(unique(extractfield(all_data,"Genre")));

% RGB values of your favorite colors: 
% colors = ["#FF0000"; "#00FF00"; "#0000FF"; "#00FFFF"; "#FF00FF"; "#000000"; "#FFFFFF"; "#FFFF00"; "#0F0F0F"; "#777777"];
% 
% % Initialize some axes
% view(3)
% grid on
% hold on
% title('GMM Classifier with Diagonal Covariance')
% 
% % Plot each point: 
% for k = 1:length(pred)
%       for i = 1:length(uniqueLabels)
%           if classified_data(k).classified_as == uniqueLabels(i)
%              %classified_data(k).classified_as
%              %uniqueLabels(i)
%              plot3(dataFeatures(k,1), dataFeatures(k,2), dataFeatures(k,3),'.','color',colors(i),'markersize',20); 
%           end 
%       end 
% end
% legend('pop', 'disco', 'metal', 'classical')%, 'raggae', 'blues', 'rock', 'hiphop', 'country', 'jazz');
