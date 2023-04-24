function plot_histogram(all_data, features, classes)
    % Init histogram
    for data = all_data
        if ~isempty(classes) && isempty(find(data.Genre == classes, 1))
            continue
        end
        for i = 1:length(features)
            histograms.(features(i)).(data.Genre) = [];
        end
    end
    % Structure data for histogram
    for data = all_data
        if ~isempty(classes) && isempty(find(data.Genre == classes, 1))
            continue
        end
        for i = 1:length(features)
            histograms.(features(i)).(data.Genre) = [histograms.(features(i)).(data.Genre), data.(features(i))];
        end
    end
    
    % Generate histogram plot
    features = fieldnames(histograms);
    figure
    for f = 1:length(features)
        nexttile
        labels = fieldnames(histograms.(features{f}));
        for l = 1:length(labels)
            histogram(histograms.(features{f}).(labels{l}), 0:0.05:1)
            hold on
        end
        title(features{f}, Interpreter="none")
        legend(labels)
        hold off
    end

end