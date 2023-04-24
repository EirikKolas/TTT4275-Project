%% Load data
all_data = load_music_data('Classification music/GenreClassData_30s.txt');
all_data_normalized = data_set_normalizer(all_data);

% Choose features
features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "tempo"];

% Split data in training-sets and test-sets
[test_set, training_set] = test_and_training_set(all_data_normalized, features, []);


%% Classify
classified_data = k_NN_classifier(training_set, test_set, 5);

% Confusion matrix
[confusion, labels, error_rate] = generate_confusion_matrix(classified_data);

