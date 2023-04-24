function [confusion_matrix, labels, error_rate] = confusion_matrix(data)
    unique_labels = convertCharsToStrings(unique({data.label}, 'sorted'));
    d = dictionary(unique_labels, 1:length(unique_labels));
    
    confusion_matrix = zeros(length(unique_labels));
    for point = data
        confusion_matrix(d(point.label),d(point.classifed_as)) = confusion_matrix(d(point.label),d(point.classifed_as))+1;
    end
    labels = unique_labels;

    % Error rate
    diag_sum = sum(diag(confusion_matrix));
    total_sum = sum(confusion_matrix(:));
    error_rate = (total_sum - diag_sum)/total_sum;
end