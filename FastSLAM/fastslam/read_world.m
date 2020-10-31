function landmarks = read_world(filename)
    % Reads the world definition and returns a structure of landmarks.
    %
    % filename: path of the file to load
    % landmarks: structure containing the parsed information
    %
    % Each landmark contains the following information:
    % - id : id of the landmark
    % - x  : x-coordinate
    % - y  : y-coordinate
    %
    % Examples:
    % - Obtain x-coordinate of the 5-th landmark
    %   landmarks(5).x
   % input = fopen(filename);
data2=load('world.dat')
 
 for i=1:length(data2)
landmark = struct( ...
            "id", data2(i,1),...
            "x" , data2(i,2),...
            "y" , data2(i,3) ...
        )
landmarks(i)=[landmark]     
 end

end
