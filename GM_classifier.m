function test_set = GM_classifier(all_data, features, classes)

    % features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "tempo"];
    % classes  = string(unique(extractfield(all_data, 'Genre')));
    test_set = test_and_training_set(all_data, features, classes);
    % Find mean and covariance for each class
    for i = 1:length(classes)
        [~, training_set_of_class] = test_and_training_set(all_data, features, classes(i));
        classFeatures = extractfield(training_set_of_class, "features");
        classFeatures = reshape(classFeatures, [], length(features));

        GMM.(classes(i)).sigma = cov(classFeatures);
        GMM.(classes(i)).mu = mean(classFeatures).';
    end
    
    for i = 1:length(test_set)
        classes = fieldnames(GMM);
        for c = 1:length(classes)
            probabilities(c) = gaussian_dist(test_set(i).features, GMM.(classes{c}).mu, GMM.(classes{c}).sigma);
        end
        [p_max, index_max] = max(probabilities);
        test_set(i).classified_as = classes{index_max};
    end

% end