function test_set = k_NN_classifier(training_set, test_set, k)
    for i = 1:length(test_set)
        test_point = test_set(i);
        for j = 1:length(training_set)
            training_point = training_set(j);
            % Calculate Euclidian distance to all points
            temp.distance = norm(test_point.features - training_point.features);
            temp.label = training_point.label;
            distances(j) = temp;
        end
        
        % Sort for the smallest distances 
        T = struct2table(distances);
        T_sorted = sortrows(T,'distance');
        S_sorted = table2struct(T_sorted);

        % Pick out the 5 shortest
        distances_sorted = S_sorted(1:k);

        %% Count classes
        labels = {distances_sorted.label};
        
        % Get the unique labels and their indices
        [unique_labels,~,label_indices] = unique(labels);
        
        % Count the occurrences of each label
        label_counts = histcounts(label_indices, 1:numel(unique_labels)+1);
        [~, max_index] = max(label_counts);
        test_set(i).classifed_as = char(unique_labels(max_index));

    end
    
end
