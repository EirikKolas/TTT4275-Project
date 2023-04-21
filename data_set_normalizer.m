function data_set_normalized = data_set_normalizer(all_data)
    
    data_table = struct2table(all_data);
    fields = fieldnames(all_data);

    for j = 1:length(fields)
        if ~(strcmp(fields(j), 'TrackID') || strcmp(fields(j), 'File') || strcmp(fields(j), 'GenreID') || strcmp(fields(j), 'Genre') || strcmp(fields(j), 'Type'))
            field = extractfield(all_data, string(fields(j)));
            normalized = array2table(normalize(field,'range')');
            data_table(:,j) = normalized;
        end
    end 

    data_set_normalized = table2struct(data_table)';
end 
