close all;
global pets

pets = {'Squalus_acanthias_br'};
check_my_pet(pets);

estim_options('default');
estim_options('max_step_number', 5e2); % 500
% set at small number of iterations so that the nm simplex does now get...
% stuck early on

% if no convergence
% 1) increase max step number
% 2) decrease tol_simplex - size of simplex
% estim_options('tol_simplex', 1e-6);

estim_options('max_fun_evals',5e3); % 5000
% do not increase - means you are not in the right parameter space

estim_options('pars_init_method', -2);
% n = 1 - reads parameters from the output of the first estimation
% n = 2 - reads from the pars_init file
estim_options('results_output', 3);
% 0 - only .mat (no screen or figure)
% -2, saves .mat + prints parameters on screen
% 4 implied traits
% 6 everything
estim_options('method', 'no');
% 'no' = just see output
% 'nm' = nelder-mead

estim_pars;
% MRE ranges = [0, inf]
% SMSE = [0, 1]

% prioritize biological and physical realism over gooness of fit
% check implied properties

% once happy, use mat2pars_init() to override

% when you run results output to compare to other species (option 5)...
% the color relates to the the Coefficient of variation between the...
% parameter values
% red = big
% blue = low