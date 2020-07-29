function [] = Install_PTloop()
% Install_PTloop is a program to install the program PTloop 
%
%

clc

Files4TestM = {'PTloop'};

if exist('Install_PTloop')
    WhereIsSetup = which('Install_PTloop');
    WhereIsSetup = WhereIsSetup(1:end-(length('Install_PTloop')+3));
else
    f = warndlg({'PTloop cannot be installed', ...
        '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -', ...
        '###  Critical error [ES0666]  ###', ...
        '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -', ...
        'Please repport the error to pierre.lanari@geo.unibe.ch'});
    
    disp(' ')
    disp('---------------------------------------------------------------')
    disp(' ')
    disp('### Critical error [ES0666] ###')
    disp('Problem to find where is the program Install_PTloop.p')
    cd
    ls
    disp('---------------------------------------------------------------')
    disp(' ')
    
    return
end

disp(' ')
disp('TEST of PTloop setup directory -> DONE')


WhereWeAre = cd;
if ~isequal(WhereWeAre,WhereIsSetup)
    f = warndlg({'PTloop cannot be installed', ...
        '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -', ...
        '###  Error [ES0601]  ###', ...
        '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -', ...
        'You are not running Install_PTloop.p from the correct directory' ...
        '   (1) go to PTloop directory using the MATLAB Current Folder tool' ...
        '   (2) run again the setup' ...
        ' ' ...
        'Details are printed out in the MATLAB Command Window'});
    
    disp(' ')
    disp('---------------------------------------------------------------')
    disp(' ')
    disp('### Critical error [ES0601] ###')
    disp('Where you are:')
    WhereWeAre
    disp('Where is Install_PTloop.p:')
    WhereIsSetup
    disp(' ')
    disp('---------------------------------------------------------------')
    disp(' ')
    
    return
else
    disp(' ')
    disp(['Directory: ',char(WhereWeAre)]);
    disp(' ')
end

% TEST 3
for i=1:length(Files4TestM)
    FileForTest = Files4TestM{i};
    
    if exist([WhereWeAre,'/',FileForTest,'.m']) || exist([WhereWeAre,'/',FileForTest,'.p'])
        disp(['TEST: ',FileForTest,'.p -> DONE'])
    else
        f = warndlg({'The setup package seems to be corrupted', ...
            '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -', ...
            '###  Error [ES0604]  ###', ...
            '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -', ...
            'At least one critical file is missing. Try getting a new copy' ...
            ' ' ...
            'Details are printed out in the MATLAB Command Window'});
        
        disp(' ')
        disp('---------------------------------------------------------------')
        disp(' ')
        disp('### Critical error [ES0604] ###')
        disp(['Setup package corrupted: ',char(FileForTest),'.p is missing ...'])
        cd
        ls
        disp('---------------------------------------------------------------')
        disp(' ')
        
        return
    end
end
disp(' ')
disp('TEST of the PTloop package -> DONE')


disp(' ')
disp('                               * * *  ');
disp(' ')
disp('                 -------------------------------     ');
disp('                  #### ##### #    #### #### ####     ');
disp('                  #  #   #   #    #  # #  # #  #     ');
disp('                  ####   #   #    #  # #  # ####     ');
disp('                  #      #   #    #  # #  # #        ');
disp('                  #      #   #### #### #### #        ');
disp('                 -------------------------------     ');
disp(' ')
disp('                               * * *  ');




ButtonName = questdlg({['This program will install PTloop in your computer'],'Would you like to continue?'}, ...
                         'Install_PTloop', ...
                         'Yes', 'No', 'Cancel', 'Yes');


if isequal(ButtonName,'Yes')
    
    ButtonName = questdlg({'PTloop needs to know THERIAK''s directory','What do we do?'}, ...
                         'Install_PTloop', ...
                         'Select THERIAK''s directory','Cancel', 'Select THERIAK''s directory');
    
    
    if ~isequal(ButtonName,'Select THERIAK''s directory')
        disp(' ')
        disp('CANCELLATION: PTLOOP IS NOT INSTALLED ON YOUR MACHINE ...');
        disp(' ')
        disp(' ')
        return
    end
    
    DirectoryName = uigetdir(cd,'THERIAK''s directory');
    
    if ~length(DirectoryName)
        disp(' ')
        disp('CANCELLATION: PTLOOP IS NOT INSTALLED ON YOUR MACHINE ...');
        disp(' ')
        disp(' ')
        return
    end
    
    disp(' ')
    disp(['THERIAK directory: ',DirectoryName]);
                     

    
    fid =fopen([WhereIsSetup,'/PTL_Config.txt'],'w');
    fprintf(fid,'%s\n',WhereIsSetup);
    fprintf(fid,'%s',DirectoryName);
    fclose(fid);

    
  
    % Update the Paths
    eval(['addpath ',char(WhereIsSetup)]);
    resultMod = savepath;
    if resultMod == 0
        textAfficher = { ...
                        'The setup is completed', ...
                        ' ', ...
                        ' ', ...
                        'PTloop can be run from working directory using the command:', ...
                        '     >> PTloop', ...
                        ' ', ...
                        'Use the MATLAB window to change the current folder. ', ...
                        ' ', ...
                        ' ', ...
                        'Press OK to exit',};

        uiwait(msgbox(textAfficher,'Install_PTloop','help'));

    else
        textAfficher = { ...
                        'The setup was not completed ',...
                        '  ', ...
                        '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -', ...
                        '###  Error [ES0616]  ###', ...
                        '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -', ...
                        'PTloop can not save the Path ...', ...
                        'This error could occur if the file pathdef.m is locked for the user. ', ...
                        ' ', ...
                        'Optimal solution: Change the user permissions for pathdef.m' ...
                        '         [1] Find the file using the command >> which pathdef.m' ...
                        '         [2] Change the permission of this file to read/write' ...
                        ' ',...
                        'Alternative solution: You need to add the PTloop folder to the favorite path of MATLAB: ', ...
                        '         [1] In the MATLAB main GUI, use the menu: "File >> Set Path..." ', ...
                        '         [2] Add the path of GRTMOD using the button "Add Folder..." ', ...
                        '         [4] Save the path (in a new file), Close the Set Path GUI. ', ...
                        ' ', ...
                        'After this change, PTloop can be run from working directory using the command:', ...
                        '     >> PTloop', ...
                        ' ', ...
                        'Use the MATLAB GUI window to change the current folder. ', ...
                        ' ', ...
                        ' ', ...
                        'Press OK to exit',};

         uiwait(msgbox(textAfficher,'Install_GRTMOD','warn'));

    end

else
    textAfficher = { ...
                    'The setup was not completed ',...
                    '  ', ...
                    '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -', ...
                    '###  Error [ES0611]  ###', ...
                    '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -', ...
                    'User pressed ''cancel'' or ''no''', ...
                    ' ', ...
                    'WARNING: PTloop should not be used without correct setup', ...
                    ' ', ...
                    ' ', ...
                    'Press OK to exit'};
    
    uiwait(msgbox(textAfficher,'Install_PTloop','warn'));
    
end

disp(' ');
disp(' ');
disp(' ');












