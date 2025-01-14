function files=checkFileExistence(files,fullOrTemp,allowSpace)
% checkFileExistence
%   Check whether files exist. If no full path is given a file should be
%   located in the current folder, which by default is appended to the
%   filename.
%
%   Input:
%   files           string or cell array of strings with path to file(s) or
%                   path or filename(s)
%   fullOrTemp      0: do not change path to file(s)
%                   1: return full path to file(s)
%                   2: copy file(s) to system default temporary folder and
%                      return full path
%                   (opt, default 0)
%   allowSpace      logical, whether 'space' character is allowed in the
%                   path (opt, default true)
%
%   Output:
%   files           string or cell array of strings with updated paths if
%                   fullOrTemp was set as 1 or 2, otherwise original paths
%                   are returned
%   
%   Usage: files=checkFileExistence(files,fullOrTemp,allowSpace)

if nargin<2
    fullOrTemp = 0;
end
if nargin<3
    allowSpace = true;
end

if isstr(files)
    oneFile=true;
    files={files};
else
    oneFile=false;
end
filesOriginal = files;

%Make all full paths before check of file existence
if ispc % full path starts like "C:\"
    inCurrDir = cellfun(@isempty,regexpi(files,'^[a-z]\:\\'));
else %isunix full path starts like "/"
    inCurrDir = cellfun(@isempty,regexpi(files,'\/'));
end
files(inCurrDir) = fullfile(cd,files(inCurrDir));

%Check existence
for i=1:numel(files)
    if ~exist(files{i},'file')
        error('File "%s" cannot be found\n',files{i});
    elseif allowSpace == false & strfind(files{i},' ')
        error('File "%s" has an invalid space in the filename or path, please remove this before running this function\n',files{i});
    end
end

switch fullOrTemp
    case 0
        files = filesOriginal;
    case 1
        % files already contains full path
    case 2
        for i=1:numel(files)
            tmpFile=tempname;
            copyfile(files{i},tmpFile);
            files{i}=tmpFile;
        end
end

if oneFile == true
    files = files{1};
end