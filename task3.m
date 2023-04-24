%% Load data
all_data = load_music_data('Classification music/GenreClassData_30s.txt');
all_data_normalized = data_set_normalizer(all_data);


fields = fieldnames(all_data);

% Brukt til å printe alle features i histogrammer
% i = 1;
% for j = 1:length(fields)
%     if ~(strcmp(fields(j), 'TrackID') || strcmp(fields(j), 'File') || strcmp(fields(j), 'GenreID') || strcmp(fields(j), 'Genre') || strcmp(fields(j), 'Type') || strcmp(fields(j), 'spectral_rolloff_mean') || strcmp(fields(j), 'mfcc_1_mean') || strcmp(fields(j), 'spectral_centroid_mean'))
%          features(i) = string(fields(j));
%          i = i + 1;
%     end
% end 

% Choose features and classes
classes  = ["pop", "disco", "metal", "classical"];

% for j = 1:length(fields)
%     if ~(strcmp(fields(j), 'TrackID') || strcmp(fields(j), 'File') || strcmp(fields(j), 'GenreID') || strcmp(fields(j), 'Genre') || strcmp(fields(j), 'Type') || strcmp(fields(j), 'spectral_rolloff_mean') || strcmp(fields(j), 'mfcc_1_mean') || strcmp(fields(j), 'spectral_centroid_mean'))
%         features(4) = string(fields(j));
% 
%         [test_set, training_set] = test_and_training_set(all_data_normalized, features, classes);
%         classified_data = k_NN_classifier(training_set, test_set, 5);
%         [confusion_matrix,labels,error_rate] = generate_confusion_matrix(classified_data);
%         X = ['Error rate for ', features(4), ' er: ', error_rate];
%         disp(X)
%     end
% end 

%% Histogram
features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "mfcc_8_mean"];

plot_histogram(all_data_normalized, features, classes);

%% Test performance

classes  = ["pop", "disco", "metal", "classical"];
features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "mfcc_8_mean"];

[test_set, training_set] = test_and_training_set(all_data_normalized, features, classes);
classified_data = k_NN_classifier(training_set, test_set, 5);
[confusion_matrix,labels,error_rate] = generate_confusion_matrix(classified_data);
X = ['Error rate for ', features(4), ' er: ', error_rate];
disp(X)







