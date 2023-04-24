%% Load data
all_data = load_music_data('Classification music/GenreClassData_30s.txt');
all_data_normalized = data_set_normalizer(all_data);

% Choose features
features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "tempo"];

% Split data in training-sets and test-sets
training_set = [];
test_set = [];
for data = all_data_normalized
    temp.label = data.Genre;
    for i = 1:length(features)
        temp.features(i,1) = data.(features(i));
    end
    if data.Type == "Train"
        training_set = [training_set, temp];
    end
    if data.Type == "Test"
        test_set = [test_set, temp];
    end
end


%% Classify
classified_data = k_NN_classifier(training_set, test_set, 5);

% Confusion matrix
[confusion, labels, error_rate] = confusion_matrix(classified_data);

