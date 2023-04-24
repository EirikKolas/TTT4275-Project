%% Load data
all_data = load_music_data('Classification music/GenreClassData_30s.txt');
all_data_normalized = data_set_normalizer(all_data);

% Choose features
features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "tempo"];
[test_set, training_set] = test_and_training_set(all_data_normalized, features, "pop");

a = extractfield(training_set,"features");
a = reshape(a, [length(training_set), length(features)]);
