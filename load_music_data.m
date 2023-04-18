function data = load_music_data(filename)
    % Open the text file for reading
    fid = fopen(filename, 'r');
    
    % Read the first line to get the field names
    fields = strsplit(fgetl(fid));
    
    
    % Loop through the rest of the file and create a struct for each line
    index = 1;
    while ~feof(fid)
        % Read the line and split it into fields
        line = strsplit(fgetl(fid));
        
        % Create a struct for this line
        item = struct();
        for i = 1:numel(fields)
            num = str2double(line{i});
            if isnan(num)
                item.(fields{i}) = line{i};
            else
                item.(fields{i}) = num;
            end
        end
        
        % Add the struct to the output array
        data(index) = item;
        index = index +1;
    end
    
    % Close the file
    fclose(fid);
end

