%% Load data
all_data = load_music_data('Classification music/GenreClassData_30s.txt');
all_data_normalized = data_set_normalizer(all_data);

% Choose features and classes
features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "tempo"];
classes  = ["pop", "disco", "metal", "classical"];

%% Histogram
plot_histogram(all_data_normalized, features, classes);

%% Test performance
features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean"];
classes  = ["pop", "disco", "metal", "classical"];

[test_set, training_set] = test_and_training_set(all_data_normalized, features, classes);
classified_data = k_NN_classifier(training_set, test_set, 5);
[confusion,labels,error_rate] = confusion_matrix(classified_data);
error_rate







