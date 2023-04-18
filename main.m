%% Load data
all_data = load_music_data('Classification music/GenreClassData_30s.txt');

%% Split data in training-sets and test-sets
% Choose features
features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "tempo"];

training_set = [];
test_set = [];
for data = all_data
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


asdf = k_NN_classifier(training_set, test_set, 5);

