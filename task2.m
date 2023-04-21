%% Load data
all_data = load_music_data('Classification music/GenreClassData_30s.txt');
all_data_normalized = data_set_normalizer(all_data);

% Choose features and classes
features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "tempo"];
classes  = ["pop", "disco", "metal", "classical"];

% Split data in training-sets and test-sets
training_set = [];
test_set = [];
for data = all_data_normalized
    if isempty(find(data.Genre == classes, 1))
        continue
    end
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

%% Histogram
% Init histogram
for data = all_data_normalized
    if isempty(find(data.Genre == classes, 1))
        continue
    end
    for i = 1:length(features)
        histograms.(features(i)).(data.Genre) = [];
    end
end
% Structure data for histogram
for data = all_data_normalized
    if isempty(find(data.Genre == classes, 1))
        continue
    end
    for i = 1:length(features)
        histograms.(features(i)).(data.Genre) = [histograms.(features(i)).(data.Genre), data.(features(i))];
    end
end

% Generate histogram plot
n_bins = 10;
features = fieldnames(histograms);
for f = 1:length(features)
    nexttile
    labels = fieldnames(histograms.(features{f}));
    for l = 1:length(labels)
        histogram(histograms.(features{f}).(labels{l}), n_bins)
        hold on
    end
    title(features{f}, Interpreter="none")
    legend(labels)
    hold off
end


