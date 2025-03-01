function path=getWSLpath(path)
% getWSLpath
%   Translate Windows-style path to its Unix WSL (Windows Subsystem for
%   Linux) equivalent.
%
%   Input:
%   path        string with directory of file path, in Windows-style (e.g.
%               'C:\Directory\')
%
%   Output:
%   path        string with directory of file path, in Unix style (e.g.
%               '/mnt/c/Directory/')
%
%   Uses the WSL function 'wslpath' to translate the path.
%
%   Usage: path=getWSLpath(path)
[~,path]=system(['wsl wslpath ''' path '''']);
path=path(1:end-1);% Remove final character (line-break)
end
