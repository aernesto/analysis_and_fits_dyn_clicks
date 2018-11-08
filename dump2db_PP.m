function dump2db_PP(file_path,row)
% dumps a single row of data to the provided file
% ARGS:
%   file_path   full path to csv file
%   row         cell array of data for the row to write to the file
% RETURNS:
%   nothing, but writes to file

num_fields=length(row);
% fit_id,db_name,trial_start,trial_stop,num_trials,script_name,commit,fit_model,ref_model,percent_match,fit_method
fields_types={'%d','%s','%d','%d','%d','%s','%s','%s','%s','%.4f','%s'};

fid=fopen(file_path,'a');

for r=1:num_fields-1
    fprintf(fid, [fields_types{r},','], row{r}) ;
end

fprintf(fid, [fields_types{end},'\n'], row{end}) ;

fclose(fid) ;
end