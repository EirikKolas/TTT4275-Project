function [confusion_matrix, labels] = confusion_matrix(data)
    unique_labels = convertCharsToStrings(unique({data.label}, 'sorted'));
    d = dictionary(unique_labels, 1:length(unique_labels));
    
    confusion_matrix = zeros(length(unique_labels));
    for point = data
        confusion_matrix(d(point.label),d(point.classifed_as)) = confusion_matrix(d(point.label),d(point.classifed_as))+1;
    end
    labels = unique_labels;
end