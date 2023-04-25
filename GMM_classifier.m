function test_set = GMM_classifier(all_data, features, classes, M)

    % features = ["spectral_rolloff_mean", "mfcc_1_mean", "spectral_centroid_mean", "tempo"];
    % classes  = string(unique(extractfield(all_data, 'Genre')));
    test_set = test_and_training_set(all_data, features, classes);
    % Find mean and covariance for each class
    for i = 1:length(classes)
        [~, training_set_of_class] = test_and_training_set(all_data, features, classes(i));
        classFeatures = extractfield(training_set_of_class, "features");
        classFeatures = reshape(classFeatures, [], length(features));

        rng(1);
        options = statset('MaxIter',500);
        GMModel = fitgmdist(classFeatures, M, 'Options', options, 'CovarianceType','diagonal');
        GMM.(classes(i)).C = GMModel.ComponentProportion;
        GMM.(classes(i)).mu = GMModel.mu.';
        GMM.(classes(i)).sigma = GMModel.Sigma;

    end
    
    for i = 1:length(test_set)
        classes = fieldnames(GMM);
        for c = 1:length(classes)
            probabilities(c) = gaussian_mix_dist(test_set(i).features, GMM.(classes{c}).C ,GMM.(classes{c}).mu, GMM.(classes{c}).sigma);
        end
        [p_max, index_max] = max(probabilities);
        test_set(i).classified_as = classes{index_max};
    end

% end