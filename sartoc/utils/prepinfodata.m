function prepinfodata(fn)
%creates the info file
%
%Arguments:
%   fn (str): the file name to save to
%
%Returns:
%   None

    fid = fopen(['./results/', fn, '_info.txt'], 'wt');
    info = input('Information for this test case: ', "s");
    fprintf(fid, '%s', info);
    fclose(fid);