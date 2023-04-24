function [test_set, training_set] = test_and_training_set(all_data, features, classes)
    training_set = [];
    test_set = [];
    for data = all_data
        if ~isempty(classes) && isempty(find(data.Genre == classes, 1))
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
end