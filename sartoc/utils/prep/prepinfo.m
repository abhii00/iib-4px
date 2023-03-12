function prepinfo(info, fn)
%creates the info file
%
%Arguments:
%   info (str): the information for the test case
%   fn (str): the file name to save to
%
%Returns:
%   None

    fid = fopen([fn, '_info.txt'], 'wt');
    fprintf(fid, '%s', info);
    fclose(fid);
end