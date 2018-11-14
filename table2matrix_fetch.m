function matrix = table2matrix_fetch(csv_file,trial_number,field,...
    expected_dim)
% fetches entries in specific field from a csv table and returns them in a 
% matrix format
% ARGS:
%   csv_file        csv filename (full path to it)
%   trial_number    entry value to filter the field "num_trials" in table
%   field           string for name of field the function should fetch from
%   expected_dim    expected dimension of the output matrix
% RETURNS:
%   matrix          an n-by-4 matrix where columns correspond to model
%                   pairs as follows: 1 = LL; 2 = L-NL; 3 = NL-NL; 4 = NL-L

file=readtable(csv_file);

row1=strcmp(file.ref_model,'lin') & strcmp(file.fit_model,'lin')...
            & file.num_trials == trial_number;
col1=table2array(file(row1,{field}));

row2=strcmp(file.ref_model,'nonlin') & strcmp(file.fit_model,'lin')...
            & file.num_trials == trial_number;
col2=table2array(file(row2,{field}));

row3=strcmp(file.ref_model,'nonlin') & strcmp(file.fit_model,'nonlin')...
            & file.num_trials == trial_number;
col3=table2array(file(row3,{field}));

row4=strcmp(file.ref_model,'lin') & strcmp(file.fit_model,'nonlin')...
            & file.num_trials == trial_number;
col4=table2array(file(row4,{field}));

matrix=[col1,col2,col3,col4];
if size(matrix) ~= expected_dim
    error('wrong expected dimensions')
end
end