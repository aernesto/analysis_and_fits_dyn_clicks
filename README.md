# analysis_and_fits_dyn_clicks
code to analyze and fit ideal observer models to data in the dynamic clicks task

## Description of the fields from the [db_fits.csv](https://github.com/aernesto/analysis_and_fits_dyn_clicks/blob/dev/db_fits.csv) file
- *fit_id*: integer representing the iteration value of the fit. This is field is there to distinguish between two fits that would otherwise generate identical rows in the csv file.
- *db_name*: filename of the database used for the fit.
- *trial_start*: trial index within the database where the trial block for the fit starts. Whenever trials are shuffled before the fit, this field is set to -1.
- *trial_stop*: trial index within the database where the trial block for the fit ends. Whenever trials are shuffled before the fit, this field is set to -1.
- *num_trials*: total number of trials used for the fit. Useful whenever the previous two fields are set to -1.
- *script_name*: name of the script used for the fit.
- *commit*: commit number for the version of the script used.
- *fit_model*: type of the model that is fitted.
- *ref_model*: type of the model that produced the choice data used from the database.
- *disc*: point estimate of the discounting parameter yielded by the fit
- *fit_method*: method used to calculate the point estimate. 'map' stands for MAP estimate, 'max_pp' stands for maximization of the predictive power.

## Description of the fields from the [db_PP.csv](https://github.com/aernesto/analysis_and_fits_dyn_clicks/blob/dev/db_PP.csv) file
- *fit_id*: integer representing the iteration value of the fit. _This field should match its counterpart in `db_fits.csv`._
- *db_name*: filename of the database used to compute percent match.
- *trial_start*: trial index within the database where the trial block for the percent match calculation starts. Whenever trials are shuffled before the calculation, this field is set to -1.
- *trial_stop*: trial index within the database where the trial block for the percent match calculation ends. Whenever trials are shuffled before the calculation, this field is set to -1.
- *num_trials*: total number of trials used for the percent match calculation. Useful whenever the previous two fields are set to -1.
- *script_name*: name of the script used for the percent match calculation.
- *commit*: commit number for the version of the script used.
- *fit_model*: type of the model that is fitted. _This field should match its counterpart in `db_fits.csv`._
- *ref_model*: type of the model that produced the choice data used from the database. _This field should match its counterpart in `db_fits.csv`._
- *percent_match*: percent match value obtained.
- *fit_method*: method used to calculate the point estimate. 'map' stands for MAP estimate, 'max_pp' stands for maximization of the predictive power. _This field should match its counterpart in `db_fits.csv`._
