# analysis_and_fits_dyn_clicks
code to analyze and fit ideal observer models to data in the dynamic clicks task

## Description of the fields from the [db_fits.csv](https://github.com/aernesto/analysis_and_fits_dyn_clicks/blob/dev/db_fits.csv) file
- *fit_id*: integer representing the iteration value of the fit. This is field is there to distinguish between two fits that would otherwise generate identical rows in the csv file.
- *db_name*: filename of the database used for the fit.
- *trial_start*: trial index within the database where the trial block for the fit starts.
- *trial_stop*: trial index within the database where the trial block for the fit ends.
- *script_name*: name of the script used for the fit.
- *commit*: commit number for the version of the script used.
- *fit_model*: type of the model that is fitted.
- *ref_model*: type of the model that produced the choice data used from the database.
- *disc*: point estimate of the discounting parameter yielded by the fit
- *fit_method*: method used to calculate the point estimate. 'map' stands for MAP estimate, 'max_pp' stands for maximization of the predictive power.
