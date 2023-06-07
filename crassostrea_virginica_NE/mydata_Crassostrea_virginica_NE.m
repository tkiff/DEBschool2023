function [data, auxData, metaData, txtData, weights] = mydata_Crassostrea_virginica_NE

%% Set metaData

metaData.phylum     = 'Mollusca';
metaData.class      = 'Bivalvia';
metaData.order      = 'Ostreoida';
metaData.family     = 'Ostreidae';
metaData.species    = 'Crassostrea_virginica_NE';
metaData.species_en = 'Eastern oyster';

metaData.ecoCode.climate = {'MB', 'MC'};
metaData.ecoCode.ecozone = {'MAW'};
metaData.ecoCode.habitat = {'0jMp', 'jiMb', 'jiMi'};
metaData.ecoCode.embryo  = {'Mp'};
metaData.ecoCode.migrate = {};
metaData.ecoCode.food    = {'biPp'};
metaData.ecoCode.gender  = {'D'};
metaData.ecoCode.reprod  = {'O'};

metaData.T_typical  = C2K(20);                                                                            % K, body temp
metaData.data_0     = {'ab'; 'aj'; 'ap'; 'am'; 'Lb'; 'Lj'; 'Lp'; 'Li'; 'Wdb'; 'Wdj'; 'Wdp'; 'Wdi'; 'Ri'}; % tags for different types of zero-variate data
metaData.data_1     = {'t-L_f'; 'L-Ww'; 'Wd-JO_T'};                                                       % tags for different types of uni-variate data

metaData.COMPLETE = 3.5; % using criteria of LikaKear2011

metaData.author    = {'Thomas Kiffney'};    
% metaData.date_subm = [2018 01 22];          
metaData.email     = {'thomas.kiffney@maine.edu'};
metaData.address   = {'Graduate student at Darling Marine Center, University of Maine, Walpole, ME 04573, USA'}; % affiliation

%% Set Zero-variate data

% Retained from original estimation
data.ab   = 1.5;      units.ab      = 'd'; label.ab      = 'age at birth';         bibkey.ab = {'Gals1964','Carr2009'};
  temp.ab = C2K(25);  units.temp.ab = 'K'; label.temp.ab = 'temperature';
  
% modified from original estimation
data.aj   = 14;       units.aj      = 'd'; label.aj      = 'age at metamorphosis'; bibkey.aj = {'Pryth1929'};
  temp.aj = C2K(23.5);  units.temp.aj = 'K'; label.temp.aj = 'temperature';
  
% modified from original estimation
data.ap   = 545;       units.ap      = 'd'; label.ap      = 'age at puberty';       bibkey.ap = {'Coe1932'};
  temp.ap = C2K(11);  units.temp.ap = 'K'; label.temp.ap = 'temperature';
  comment.ap = 'Unclear on exact time, estimated from "reaches puberty in second year"';
% Orinigal
% data.ap   = 84;       units.ap      = 'd'; label.ap      = 'age at puberty';       bibkey.ap = {'HayeMenz1981','ObeiHeff1996'};
%   temp.ap = C2K(28);  units.temp.ap = 'K'; label.temp.ap = 'temperature';

% Retained from original estimation
data.am   = 20 * 365; units.am      = 'd'; label.am      = 'life span';            bibkey.am = 'Gals1964';
  temp.am = C2K(20);  units.temp.am = 'K'; label.temp.am = 'temperature';
% Alternate data suggests shorter lifespan 6-7 years

% Retained from original estimation
data.Lb = 0.0075; units.Lb = 'cm'; label.Lb = 'diameter of a D-larvae';        bibkey.Lb = {'Gals1964','GallMann1986','Carr2009'};
% Retained from original estimation
data.Lj = 0.035;  units.Lj = 'cm'; label.Lj = 'diameter of a settling larvae'; bibkey.Lj = {'Andr1979','Toma1981','Carr2009'};
% Retained from original estimation
data.Lp = 3;      units.Lp = 'cm'; label.Lp = 'shell height';                  bibkey.Lp = {'Gals1964','HayeMenz1981','ObeiHeff1996','Carr2009'};
% Retained from original estimation
data.Li = 20.6;   units.Li = 'cm'; label.Li = 'ultimate shell height';         bibkey.Li = 'Gals1964';
% Data from wild oysters, Surface grown oysters are typically shorter  

% retained from orginal estimation
data.Wdb = 1.5e-7; units.Wdb = 'g'; label.Wdb = 'dry weight at birth';         bibkey.Wdb = 'GallMann1986';
% Not specified in source if this includes shell weight

% original
data.Wdj = 7.5e-6; units.Wdj = 'g'; label.Wdj = 'dry weight at metamorphosis'; bibkey.Wdj = 'LabaFern1999';
  comment.Wdj = 'data from Ostrea edulis';

% original
data.Wdp = 0.12;   units.Wdp = 'g'; label.Wdp = 'dry weight at puberty';       bibkey.Wdp = {'HayeMenz1981','ObeiHeff1996'};
  comment.Wdp = 'estimated from length given by HayeMenz1981 and ObreHeff1996 (with W=L^3)';

% Original
data.Wdi = 35.8;   units.Wdi = 'g'; label.Wdi = 'ultimate dry weight';         bibkey.Wdi = 'Gals1964';
% data.Wwi = 35.8;   units.Wdi = 'g'; label.Wdi = 'ultimate wet weight';         bibkey.Wdi = 'Gals1964';
% Not specified that this is dry weight in source

% Replace ultimate reproductive rate with rate at a large length  
data.R97  = 15700000; units.R97  = '#/d'; label.R97  = 'reprod rate at 97 mm shell length';   bibkey.R97  = 'GlanMich2016';   
  temp.R97 = C2K(16); units.temp.R97 = 'K'; label.temp.R97 = 'temperature';
  comment.R97 = 'Choptank river chesapeak';
% code in AmP - Mnemiopsis leidyi
% Need to add predict and pars init
% data.Ri   = 1.3e6;   units.Ri      = '#/d'; label.Ri      = 'maximum reprod rate'; bibkey.Ri  = {'HoffPowe1992','ChoiLewi1993'};
%   temp.Ri = C2K(20); units.temp.Ri = 'K';   label.temp.Ri = 'temperature';

%% Set Uni-variate data

 %%% Data from KraeFord2007 - MetaAnalysis of oyster growth methods
 % Mid atlantic site with selected cultured diploids
 % age (d) length (mm) at f = 0.9 (high food in shallow new jersey waters), T = 13-14 C
data.tL_KraeFord2007 = [352	356	357	363	725	725	733	733	1089 1093 1093 1094	1460 1460 1464 1465	1820 1825 1827 1827	2181 2188 2190 2193	2550 2550 2551 2555; % d,  time since birth
                        34 24 27 29	62 65 55 58	81 88 89 77 104	107	92 95 106 103 114 115 113 122 110 117 123 126 120 110]'; % cm, physical length
data.tL_KraeFord2007(:,2) = data.tL_KraeFord2007(:,2) / 10; % cm, convert mm to cm
units.tL_KraeFord2007 = {'d','cm'}; label.tL_KraeFord2007 = {'time since birth','shell length'};
temp.tL_KraeFord2007 = C2K(14); units.temp.tL_KraeFord2007 = 'K'; label.temp.tL_KraeFord2007 = 'temperature';
bibkey.tL_KraeFord2007 = 'KraeFord2007';

 %%% Data from GrizWard2017
 % Great bay new hapshire
 % age (yr) length (mm) at f = 0.5 (enclosed bay with fluctuating salinity could reduce feeding), T = 11 C
data.tL_GrizWard2017 = [0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.7	1.7	1.7	1.7	1.7	1.7	1.7	1.7	0.6	0.6	0.6	0.6	0.6	1.7	1.7	1.7	1.7	1.7	1.7	1.7	1.7	1.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7; % yr,  time since birth
                        37.7 41.9 37.1 38.3 34.3 26.9 41.3 34.1 23.2 37.9 29.2 26.3 27.4 30 35 35.7 27.7 26.1 33 30 37.9 31.4 34.5 32.4 29.5 40 40.7 24.5 27.5 37.3 24.9 32.9 33.3 28.8 31.3 19 28.9 37.3 33 33.5 37.7 30.6 42.5 33.3 41.5 34 28.5 31 46 36 43 33.5 29 32.5 28.5 34 43 36.5 27.5 49.5 45.5 29 34 50 35 39.7 39.8 40.8 32.3 39.1 39.9 43 40.8 49.8 37.5 38.5 39.4 43.7 47.5 27.9 34.5 40.8 47 71.6 60 69.7 61 57.2 46.2 58.2 42 30 28.5 29 38.5 27.5 49.1 53.3 49 46 50.2 41.7 50 52 55.7 60.5 77.1 61.5 81.7 70 86.8 64.5 42.5 62 74 61.7 66.3 68.5 56 63.4 51 66.7 80 84.2 76.4 59.5 64.5 83.4 78.3 68.4 92.2 77.6 79.5 54.9 44.3 64.9 58.9 51.7 43.5 55.7 78.8 60 46.7 43.3 40.5 54.4 66 61.4 39 46 63.9 55 70.5 50 58.9 49.5 51 62.9 52 46.4 43 36.3 27.5 29.6 58 39.4 51.7 32.9 63.4 63.3 60.5 65.2 42.2 57.3 50 55 48 59.5 45 62 57 59 58 59 57 48 63 54.5 51.5 46 64.5 57 58 51.5 58 65 58 60.5 58.5 50.5 59.5 53.5 45.5 51 52.5 47 56.2 58.3 59.8 63.4 58.1 62 66.7 59.9 74 56.4 59.8 66.4 65.4 63.7 53.8 59.3 64.7 80.3 71.2 93 75.7 78.8 67.9 59.5 75.7 65.7 79.5 78.3 86.5 87 81.4 80 71 76.5 72.8 80.5 84.1 79.5 76.8 70 57.6 83 64.5 89.6 106.5 68 82.8 67 93.5 90 99 88.5 78.5 86.8 93.5]'; % cm, physical length
data.tL_GrizWard2017(:,2) = data.tL_GrizWard2017(:,2) / 10; % cm, convert mm to cm
data.tL_GrizWard2017(:,1) = data.tL_GrizWard2017(:,1) * 365; % d, convert yr to d
units.tL_GrizWard2017 = {'d','cm'}; label.tL_GrizWard2017 = {'time since birth','shell length'};
temp.tL_GrizWard2017 = C2K(11); units.temp.tL_GrizWard2017 = 'K'; label.temp.tL_GrizWard2017 = 'temperature';
bibkey.tL_GrizWard2017 = 'GrizWard2017';
% Time since birth - dry tissue wt data
data.tWd_GrizWard2017 = [0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.3	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	0.6	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.1	1.7	1.7	1.7	1.7	1.7	1.7	1.7	1.7	0.6	0.6	0.6	0.6	0.6	1.7	1.7	1.7	1.7	1.7	1.7	1.7	1.7	1.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.3	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	1.6	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.1	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	2.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7	3.7;
                         0.038	0.039	0.033	0.031	0.049	0.017	0.039	0.036	0.025	0.047	0.017	0.016	0.033	0.019	0.026	0.034	0.011	0.011	0.020	0.031	0.030	0.025	0.026	0.036	0.014	0.031	0.047	0.016	0.016	0.028	0.011	0.034	0.033	0.022	0.028	0.009	0.019	0.030	0.019	0.023	0.049	0.023	0.050	0.050	0.080	0.010	0.010	0.040	0.060	0.030	0.070	0.010	0.020	0.030	0.040	0.030	0.080	0.030	0.040	0.130	0.180	0.050	0.050	0.200	0.040	0.050	0.060	0.070	0.030	0.100	0.080	0.070	0.120	0.120	0.070	0.060	0.080	0.120	0.110	0.080	0.140	0.130	0.130	0.480	0.410	0.410	0.380	0.260	0.160	0.250	0.160	0.080	0.060	0.070	0.050	0.020	0.260	0.140	0.170	0.130	0.120	0.120	0.180	0.120	0.110	1.050	1.050	0.570	1.310	0.820	1.920	0.610	0.300	0.420	0.560	0.670	0.660	0.500	0.680	0.460	0.400	0.530	0.770	0.800	0.550	0.560	0.620	1.290	0.880	1.000	1.820	1.790	1.740	0.328	0.138	0.287	0.153	0.110	0.112	0.155	0.259	0.221	0.121	0.131	0.098	0.239	0.235	0.205	0.110	0.186	0.361	0.190	0.174	0.140	0.231	0.096	0.103	0.219	0.239	0.163	0.105	0.071	0.034	0.030	0.169	0.087	0.180	0.036	0.184	0.178	0.217	0.249	0.092	0.237	0.203	0.240	0.200	0.370	0.190	0.230	0.310	0.330	0.220	0.270	0.320	0.190	0.140	0.110	0.210	0.200	0.270	0.290	0.250	0.190	0.200	0.220	0.390	0.130	0.130	0.280	0.300	0.220	0.180	0.300	0.290	0.130	0.140	0.220	0.350	0.200	0.230	0.340	0.340	0.300	0.440	0.210	0.260	0.190	0.300	0.210	0.170	0.300	0.290	0.320	0.380	0.710	0.420	0.690	0.790	0.260	0.420	0.490	1.170	0.960	0.780	0.610	1.530	1.420	0.840	1.150	1.600	1.780	1.370	1.190	1.270	1.420	0.460	0.940	0.740	0.940	1.340	0.460	1.530	1.100	1.780	1.300	2.550	1.820	1.560	1.170	2.430]';
data.tWd_GrizWard2017(:,1) = data.tWd_GrizWard2017(:,1) * 365; % d, convert yr to d
units.tWd_GrizWard2017 = {'d', 'g'}; label.tWd_GrizWard2017 = {'time since birth', 'dry weight', 'male'};  
temp.tWd_GrizWard2017 = C2K(11);  units.temp.tWd_GrizWard2017 = 'K'; label.temp.tWd_GrizWard2017 = 'temperature';
bibkey.tWd_GrizWard2017 = 'GrizWard2017'; 

 %%% Data from Kiff2022 - Field monitoring
 % length (mm) wet weight (g) at f = 1 (Collection of data from 6 farms in maine) at 16.6 C
data.LWd = [42	48	40	38	45	47	42	35	54	32	33	48	32	43	34	37	39	51	40	39	38	55	36	40	48	42	41	31	52	64	55	49	58	52	47	60	54	59	60	60	57	50	59	56	65	73	66	72	73	73	61	59	76	69	78	87	55	59	68	93	70	68	88	94	74	78	82	66	78	86	60	76	78	90	90	84	75	86	97	96	95	73	75	85	95	87	90	73	80	45	42	36	47	47	39	52	37	40	42	49	50	46	45	51	47	53	49	31	44	40	38	40	46	50	45	50	46	38	42	54	50	51	51	48	49	55	66	63	57	64	58	73	65	68	55	66	64	61	59	65	65	79	70	66	73	75	83	70	69	68	71	73	69	61	73	72	95	95	83	74	78	71	76	66	65	76	65	91	71	52	67	47	46	39	44	44	40	42	31	43	39	57	48	35	35	56	31	46	45	30	45	36	42	34	41	40	45	41	32	44	42	49	50	46	64	59	52	43	46	55	65	43	51	48	48	55	65	60	55	68	58	55	57	55	56	53	56	56	57	42	51	54	55	77	72	63	65	67	61	59	54	75	61	73	67	67	61	67	66	77	74	73	66	63	80	78	67	68	60	80	76	41	55	31	40	42	40	43	45	37	40	40	40	41	43	38	40	33	43	38	46	35	50	46	45	50	38	41	43	33	37	42	39	38	44	42	46	48	45	46	49	40	44	46	43	47	53	43	46	54	54	46	47	49	46	48	49	48	36	52	44	49	52	48	42	45	52	41	53	42	49	44	60	45	50	50	54	53	51	41	65	50	54	56	58	50	55	52	49	60	58	5.68	4.91	5.41	3.02	3.43	4.91	4.19	4.52	3.3	3.15	3.45	3.14	3.4	3.65	3.96	3.17	2.79	4.12	3.74	3.68	3.23	3.71	4.16	5.12	5.48	3.09	3.32	3.97	3.32	7.1	6.27	6.13	7.25	6.44	5.66	5.38	6.6	6.51	6.84	7.63	6.62	7.73	4.21	5.53	8.69	6.66	4.69	8.42	6.95	7.48	8.07	6.98	8.12	7.4	3.99	6.89	5.16	14.82	10.74	12.24	10.71	8.52	12.35	9.63	13.72	8.87	6.16	16.18	12.61	11.32	11.59	13.2	14.77	13.25	11	5.61	11.59	17.23	14.36	14.69	10.27	18.41	11.8	15.17	12.51	9.34	13.8	18.05	12.71	15.94	14.69	16.64	15.47	14.04	14.96	14.67	16.33	19.86	17.01	21.8	16.41	16.13	16.91	13.28	18.01	12.67	12.63	17.81	17.6	20.83	16.99	18.52	16.47	18.5	15.97	17.01	13.24	29.03	24.77	22.78	17.37	22.63	21.57	24.61	24.11	24.76	18.12	27.79	28.38	28.17	26.67	29.9	27.56	25.65	30.48	22.65	18.04	26.25	30.45	30.35	17.88	29.32	31.28	23.35	23.37	19.24	23.2	37.22	31.36	34.37	38.65	39.93	36.42	36.23	32.33	33.53	37.15	41.18	25.48	29.85	22.18	34.51	41.37	51.06	24.84	36.96	27.83	32.09	38.61	37.01	30.34	30.14	25.69	29.12	34.74	33.22	39.3	23.58	18.06	18.43	17.67	21.72	20.77	23.32	19.54	21.58	21.19	17.9	25.2	19.93	21.66	21.37	16.25	24.69	22.4	24.91	20.63	24.67	24.93	21.11	19.8	15.32	22.1	23.62	21.48	23.8	15.96	36.28	35.88	28.67	38.11	36.32	25.63	33.41	31.2	37.3	27.35	36.57	33.22	26.57	29.97	17.49	25.4	37.08	39.91	26.18	32.32	31.47	30.23	31.8	22.78	32.52	33.28	26.73	29.7	38.07	35.76	29.69	31.91	37.1	43.9	35.54	31.75	30.1	31.38	37.27	37.98	34.94	42.14	39.16	41.82	34.36	32.37	28.97	33.98	45.28	36.18	26.19	26.31	33.27	33.36	34.44	33.14	38.86	32.34	41.13	35.82	22.69	32.3	38.21	26.08	44.88	32.07	21.92	24.78	34.75	37.4	31.43	41.33	32.36	27.36	33.79	43.77	29.5	36.31	24.57	29.24	31.6	31.26	22.01	28.13	29.8	26.58	28.79	36.81	26.34	39.53	45.3	28.07	42.56	49.21	39.27	28.9	41.15	35.51	36.7	43.27	38.79	34.02	29.16	35.18	40.59	41.78	27.65	31.13	39.83	29.48	40.55	26.04	31.3	37.18	21.79	35.65	27.09	19.03	4.58	3.95	3.61	4.32	4.81	5.78	3.7	4.71	4.36	3.78	7.41	3.18	3.82	3.34	3.41	4.96	4.34	4.95	3.94	4.13	4.44	4.43	4.01	4.39	5.42	4.88	4.21	4.4	4.42	3.42	10.71	11.21	8.86	11.35	12.02	8.87	7.46	16.15	9.28	6.83	10.93	9.78	12.02	10.29	8.04	10.24	8.04	12.74	10.93	7.68	9.31	10.12	12.07	8.66	9.74	8.54	9.67	19.9	20.83	25.4	11.68	16.19	22.41	20.49	26.45	18.21	20.31	20.94	20.54	13.79	16.82	12.3	17.86	13.11	17.53	12.86	10.26	19.41	12.01	18.99	15.19	18.29	22.18	18.63	17.22	21.36	10.68	33.22	34	26.57	34.76	27.66	22.79	35.19	22.51	26.35	27.24	31.36	29.73	35.13	27.81	22.63	28.45	30.05	27.63	31.73	26.71	26.8	31.46	26.82	22.78	33.1	26.83	21.57	29.36	24.93	56.65	66.18	52.4	51.5	53.23	57.35	54.44	47.23	53.37	57.75	46.17	42.59	50.16	58.85	54.19	47.01	46.11	52.35	62.06	41.54	42.68	51.74	52.25	59.73	57.03	55.26	59.78	64.71	68.97	60.93	48.58	42.64	48.36	37.99	33.35	46.42	40.91	55.42	41.98	52.82	51.13	39.25	55.98	52.07	51.47	43.55	34.57	47.95	36.18	50.95	41.58	36.11	47.08	49.89	42.87	50.6	46.41	56.91	55.04	47.88	29.06	37.78	29.71	33.11	38.24	39.89	36.56	43.84	37.35	32.97	43.03	32.16	32.52	47.36	40.59	40.65	34.07	33.94	37.24	31.98	35.19	44.35	41.97	34.02	38.36	42.03	32.67	34.09	32.8	64.6	44.19	50.83	51.11	55.75	57.24	60.4	36.32	45.87	43.04	61.29	42.37	49.12	37.39	53.39	44.01	48.55	40.46	45.07	54.32	49.46	46.48	53.67	52.36	51.51	44.5	54.71	43.4	47.9	41.92	47.05	46.68	50.37	57.32	43.7	39.08	45.66	45.36	55.44	38.86	36.79	55.41	54.27	58.77	56.89	47.78	59.55	56.71	42.8	47.51	48	53.77	56.11	58.92	59.29	38.95	56.01	55.19	57.75	61.5	46.56	65.28	50.86	47.09	54.32	48.37	36.87	56.32	51.38	58.21	58.08	60.33	65.05	65.1	51.93	45.54	54.29	63.36	56.44	55	55.74	46.53	48.54	62.02	61.05	48.28	58.87	41.06	59.55	49.94	53.4	51.15	62.86	51.69	69.13	56.46	54.03	53.06	49.67	44.93	57.5	54.72	59.38	66.58	47.4	51.9	53.61	59.27	63.71	58.13	53.07	55.24	39.7	55.38	54.91	62.47	42.51	54.43	45.21	50.91; % mm, shell height
            0.1240	0.1480	0.0790	0.0840	0.1540	0.1240	0.0170	0.0770	0.3500	0.0730	0.0640	0.1620	0.0660	0.0580	0.0620	0.1880	0.1410	0.3540	0.4700	0.1720	0.1780	0.2710	0.1450	0.2850	0.4580	0.2800	0.2230	0.1810	0.1150	0.4870	0.4900	0.3890	0.8570	0.4630	0.3710	0.4190	0.5990	0.6620	0.6480	0.6070	0.5860	0.4740	0.6150	0.4520	1.1270	1.1100	1.2210	1.4340	0.8600	1.2350	0.9900	1.0800	1.2730	0.9890	1.3200	1.5160	0.5260	1.1630	1.8050	1.9860	1.8830	0.6650	2.3820	2.2190	1.2060	2.2170	2.0010	0.8490	1.4380	1.8740	1.1280	1.5150	1.9230	1.9750	2.1880	1.2530	2.1560	1.8200	2.0720	2.8920	2.4640	1.0900	1.9120	1.7760	1.8690	2.1080	2.4610	1.6250	1.4220	0.0800	0.1100	0.2260	0.3200	0.3080	0.0910	0.4790	0.0770	0.1770	0.0590	0.0870	0.1540	0.0650	0.1580	0.4100	0.3630	0.7310	0.3120	0.1590	0.3960	0.1530	0.0430	0.2780	0.4770	0.3830	0.2440	0.5610	0.6310	0.3600	0.9300	0.8290	0.5600	0.7920	0.7050	0.6220	0.7230	0.7540	1.6430	0.9470	0.8830	1.3120	0.7400	1.4500	1.2270	1.4640	0.8000	1.0930	1.1150	0.8140	1.4200	1.3430	1.0940	2.2780	1.9890	1.7760	2.3600	2.0810	2.4320	2.4030	2.1620	1.5540	1.5810	1.0430	1.4120	2.1540	1.8870	2.2900	3.0050	2.7930	1.1640	1.5310	1.5850	1.8840	2.0400	2.0610	2.2040	1.3160	2.2290	2.8000	1.7510	1.1860	2.8400	0.2130	0.1560	0.1190	0.1950	0.1780	0.1570	0.1240	0.0530	0.1330	0.1190	0.1420	0.1430	0.1310	0.0670	0.1290	0.1050	0.1660	0.1450	0.0830	0.2370	0.1300	0.1340	0.1770	0.2560	0.2660	0.2380	0.2000	0.1120	0.2200	0.1780	0.3320	0.4200	0.2640	0.5120	0.5280	0.4860	0.3930	0.2980	0.6070	0.8430	0.3110	0.4740	0.5420	0.5040	0.5440	1.1510	1.1790	0.9070	1.2850	0.5620	0.8220	1.0740	0.5800	1.1830	0.4650	0.7260	0.9840	1.0100	0.3400	0.5990	0.6900	0.6600	1.3440	0.9420	0.7650	1.0250	0.7940	0.6230	0.5170	1.1350	1.4050	0.6570	1.4290	0.9630	1.1720	0.8220	0.8100	0.6760	1.5340	1.3240	1.2060	0.7380	0.8040	1.0150	1.1640	0.6630	0.9060	0.5560	1.5440	1.2900	0.1390	0.1300	0.0530	0.0870	0.1060	0.0930	0.2190	0.2270	0.0760	0.1260	0.1080	0.1140	0.0970	0.0910	0.1130	0.0970	0.0440	0.1640	0.1230	0.1180	0.1590	0.1900	0.1580	0.1440	0.2150	0.0710	0.1100	0.2440	0.0860	0.1180	0.1420	0.4380	0.1410	0.4080	0.3290	0.3160	0.4400	0.3900	0.5420	0.4780	0.3580	0.3610	0.2640	0.2410	0.3640	0.6960	0.4520	0.4780	0.8390	0.5340	0.3810	0.6380	0.7310	0.3000	0.6050	0.5130	0.4450	0.2840	0.7040	0.2280	0.6190	1.0980	0.4370	0.5430	0.3040	0.5100	0.4090	0.7200	0.4680	0.5860	0.1040	0.9560	0.3630	0.7060	0.5150	0.8370	0.8130	0.5890	0.4690	0.9910	0.8220	0.4720	0.5790	1.0200	0.6930	0.3780	0.7220	0.4170	1.0060	1.0930	0.0008	0.0004	0.0009	0.0001	0.0003	0.0006	0.0005	0.0007	0.0003	0.0003	0.0004	0.0002	0.0003	0.0004	0.0004	0.0002	0.0002	0.0004	0.0003	0.0003	0.0002	0.0003	0.0005	0.0007	0.0005	0.0002	0.0002	0.0003	0.0002	0.0013	0.0009	0.0009	0.0009	0.0007	0.0007	0.0007	0.0007	0.0010	0.0008	0.0017	0.0010	0.0019	0.0003	0.0009	0.0020	0.0009	0.0003	0.0022	0.0017	0.0012	0.0020	0.0011	0.0020	0.0012	0.0002	0.0011	0.0006	0.0065	0.0055	0.0063	0.0047	0.0010	0.0060	0.0061	0.0084	0.0021	0.0005	0.0103	0.0071	0.0036	0.0046	0.0093	0.0093	0.0087	0.0046	0.0009	0.0062	0.0141	0.0116	0.0129	0.0072	0.0142	0.0088	0.0064	0.0058	0.0038	0.0097	0.0278	0.0084	0.0189	0.0113	0.0198	0.0158	0.0147	0.0178	0.0112	0.0158	0.0297	0.0212	0.0406	0.0135	0.0194	0.0174	0.0059	0.0255	0.0071	0.0046	0.0231	0.0228	0.0463	0.0221	0.0204	0.0210	0.0205	0.0255	0.0133	0.0109	0.0482	0.0369	0.0217	0.0153	0.0294	0.0344	0.0319	0.0255	0.0309	0.0129	0.0484	0.0699	0.0697	0.0705	0.0777	0.0581	0.0408	0.0632	0.0350	0.0199	0.0524	0.0826	0.0905	0.0134	0.0768	0.0864	0.0444	0.0346	0.0324	0.0339	0.1771	0.0819	0.1066	0.1123	0.1308	0.1130	0.1071	0.0960	0.0945	0.1285	0.1056	0.0446	0.0637	0.0299	0.0838	0.1263	0.2166	0.0515	0.1134	0.0658	0.1009	0.1332	0.0995	0.0521	0.0630	0.0499	0.0710	0.0860	0.0941	0.1404	0.0439	0.0189	0.0375	0.0272	0.0351	0.0433	0.0517	0.0314	0.0431	0.0322	0.0243	0.0634	0.0205	0.0289	0.0243	0.0200	0.0452	0.0327	0.0477	0.0295	0.0391	0.0349	0.0335	0.0290	0.0131	0.0373	0.0442	0.0381	0.0468	0.0178	0.1382	0.0944	0.0553	0.0792	0.1040	0.0311	0.1148	0.0648	0.0925	0.0377	0.1104	0.1180	0.0455	0.0603	0.0168	0.0444	0.1461	0.1298	0.0426	0.0672	0.0915	0.0630	0.0539	0.0347	0.0648	0.0648	0.0616	0.0504	0.0857	0.0900	0.0549	0.0506	0.1696	0.2034	0.1166	0.0793	0.0539	0.0765	0.1655	0.1046	0.1175	0.1331	0.0975	0.1541	0.1011	0.0929	0.0652	0.0743	0.1667	0.1584	0.0449	0.0504	0.0667	0.0779	0.0877	0.0844	0.1541	0.0807	0.1347	0.0800	0.0481	0.0911	0.1539	0.0574	0.2098	0.1418	0.0331	0.0408	0.1545	0.1743	0.1162	0.1865	0.0909	0.0350	0.1470	0.1920	0.0792	0.1549	0.0479	0.0764	0.1135	0.0861	0.0413	0.0797	0.1055	0.0434	0.0483	0.1857	0.0536	0.2104	0.2457	0.0783	0.1535	0.2585	0.1624	0.0523	0.1744	0.1136	0.1282	0.1484	0.2552	0.1356	0.0746	0.1244	0.1636	0.2327	0.0237	0.0915	0.2071	0.0887	0.1286	0.0719	0.1054	0.1117	0.0470	0.1735	0.0719	0.0212	0.0005	0.0004	0.0003	0.0005	0.0006	0.0013	0.0003	0.0007	0.0004	0.0004	0.0008	0.0003	0.0003	0.0003	0.0007	0.0005	0.0003	0.0006	0.0004	0.0004	0.0006	0.0004	0.0003	0.0005	0.0006	0.0004	0.0004	0.0007	0.0005	0.0002	0.0027	0.0031	0.0017	0.0048	0.0021	0.0016	0.0016	0.0051	0.0011	0.0012	0.0026	0.0017	0.0053	0.0028	0.0010	0.0027	0.0019	0.0041	0.0031	0.0013	0.0018	0.0015	0.0041	0.0006	0.0012	0.0016	0.0016	0.0267	0.0230	0.0364	0.0057	0.0107	0.0251	0.0377	0.0502	0.0230	0.0243	0.0307	0.0344	0.0121	0.0195	0.0099	0.0233	0.0131	0.0228	0.0076	0.0044	0.0267	0.0064	0.0312	0.0187	0.0380	0.0362	0.0202	0.0177	0.0475	0.0061	0.1124	0.1321	0.0767	0.1455	0.0791	0.0589	0.1433	0.0616	0.1058	0.0923	0.1208	0.1249	0.1216	0.0873	0.0591	0.0759	0.0962	0.0839	0.1102	0.1078	0.0754	0.0825	0.0723	0.0637	0.0958	0.0560	0.0364	0.0889	0.0487	0.5177	0.6774	0.3705	0.3138	0.6141	0.3787	0.3484	0.4095	0.6834	0.5278	0.2258	0.2339	0.5379	0.5097	0.4141	0.2663	0.3569	0.5668	0.4129	0.2019	0.2459	0.2870	0.2642	0.5992	0.4697	0.4231	0.2760	0.6909	0.7792	0.6664	0.3680	0.1240	0.1991	0.1808	0.1159	0.2405	0.1599	0.3623	0.1075	0.2085	0.2087	0.2479	0.3325	0.1831	0.1660	0.2325	0.1302	0.1488	0.1047	0.3955	0.1348	0.0636	0.2773	0.4412	0.1573	0.2084	0.1584	0.2360	0.2269	0.2522	0.0853	0.1261	0.0851	0.0982	0.1763	0.1632	0.1287	0.1353	0.1330	0.1441	0.2369	0.1253	0.1113	0.2456	0.1969	0.2407	0.1356	0.1258	0.2697	0.1129	0.1711	0.2148	0.1663	0.1333	0.1649	0.1736	0.0885	0.1607	0.1617	0.4623	0.1867	0.6591	0.1961	0.4119	0.3731	0.4329	0.1513	0.2100	0.1137	0.5217	0.1840	0.3517	0.1883	0.4024	0.2086	0.3312	0.2506	0.2869	0.3562	0.2431	0.3726	0.2355	0.3476	0.3633	0.1933	0.3623	0.1839	0.2849	0.1374	0.2436	0.2998	0.2749	0.3582	0.2624	0.2300	0.1807	0.2524	0.3177	0.2136	0.2257	0.4397	0.3977	0.4195	0.4134	0.2635	0.3821	0.5005	0.2178	0.2892	0.2825	0.3721	0.4666	0.3795	0.4390	0.1584	0.2368	0.4785	0.3167	0.5905	0.2248	0.5735	0.3841	0.3761	0.3770	0.4275	0.2095	0.5715	0.4799	0.4600	0.6965	0.5002	0.5866	0.6187	0.3127	0.3846	0.3399	0.7345	0.5419	0.5813	0.4610	0.2589	0.4180	0.7424	0.6563	0.2872	0.2928	0.2579	0.5965	0.3782	0.4574	0.3258	0.6242	0.4165	0.5557	0.5751	0.4564	0.7180	0.4027	0.1277	0.6772	0.3200	0.4795	0.4466	0.6300	0.4932	0.4851	0.4711	0.7141	0.7434	0.3627	0.6015	0.2787	0.3824	0.6016	0.4076	0.3217	0.4682	0.2437	0.4459]'; % mg, dry weight
data.LWd(:,1) = data.LWd(:,1) / 10; % cm, convert mm to cm
%data.LWd(:,2) = data.LWd(:,2) / 1000; % cm, convert mm to cm
units.LWd = {'cm', 'g'}; label.LWd = {'shell height', 'dry weight', '17 C'};
temp.LWd = C2K(17); units.temp.LWd = 'K'; label.temp.LWd = 'temperature';
bibkey.LWd = 'Kiff2022';

%%% Data from Rice et al. 1996
% flume experiment passing water over groups of oysters 
% temperature is the same for all animals
temp.tL_f1 = C2K(19); units.temp.tL_f = 'K'; label.temp.tL_f = 'temperature';
% f1 - Highest food (closest to raw sea water in flume)
data.tL_f1 = [0 15 27 39;            % d,  time since start of exp
              42.9 49.4 52.7 53.9]'; % mm, physical length
data.tL_f1(:,2) = data.tL_f1(:,2) / 10; % cm, convert mm to cm
units.tL_f1 = {'d','cm'}; label.tL_f1 = {'time since start of experiment','shell length'};
bibkey.tL_f1 = 'RheaRice1996';
% f2 - Lower food than f1
data.tL_f2 = [0 15 27 39;            % d,  time since start of exp
              42.9 48.9 51.8 52.4]'; % mm, physical length
data.tL_f2(:,2) = data.tL_f2(:,2) / 10; % cm, convert mm to cm
units.tL_f2 = {'d','cm'}; label.tL_f2 = {'time since start of experiment','shell length'};
bibkey.tL_f2 = 'RheaRice1996';
% f3 - Lower food than f2
data.tL_f3 = [0 15 27 39;            % d,  time since start of exp
              42.9 48.1 51.2 51.7]'; % mm, physical length
data.tL_f3(:,2) = data.tL_f2(:,2) / 10; % cm, convert mm to cm
units.tL_f3 = {'d','cm'}; label.tL_f3 = {'time since start of experiment','shell length'};
bibkey.tL_f3 = 'RheaRice1996';
% Lower food than f3
data.tL_f4 = [0 15 27 39;            % d,  time since start of exp
              42.9 46.9 48.0 48.2]'; % mm, physical length
data.tL_f4(:,2) = data.tL_f2(:,2) / 10; % cm, convert mm to cm
units.tL_f4 = {'d','cm'}; label.tL_f4 = {'time since start of experiment','shell length'};
bibkey.tL_f4 = 'RheaRice1996';



%%% Data from Davis 1999 - growth in the upper damariscotta estuary
% Dodge cove (upper river) f = 0.9, Typically higher chl + POM than lower estuary
data.tL1_Davi1999 = [29 47 55 66 73 83 91 105 114 119 125 132 143 362 433 481 525 567 ;
                     6.0 16.1 18.9 22.2 23.8 25.3 26.1 29.3 31.4 31.9 32.8 33.3 33.3 34.7 58.4 67.5 70.1 69.2]';  % mm, shell length at f and T
data.tL1_Davi1999(:,2) = data.tL1_Davi1999(:,2) / 10; % cm, convert mm to cm
units.tL1_Davi1999   = {'d', 'cm'};  label.tL1_Davi1999 = {'time since 5/28/1994', 'shell length'};  bibkey.tL1_Davi1999 = 'Davi1999';
temp.tL1_Davi1999    = C2K(18);  units.temp.tL1_Davi1999 = 'K'; label.temp.tL1_Davi1999 = 'temperature';
comment.tL1_Davi1999 = 'Oysters deployed mid may'; 
% DMC (lower river) f = 0.7, Typically lower chl + POM than lower estuary
data.tL2_Davi1999 = [29 47 53 62 72 81 88 101 110 118 124 133 142 150 363 480 526 567; 
                     5.8 9.6 10.8 14.4 19.0 20.5 21.4 23.9 24.0 24.5 25.7 26.7 26.3 27.1 31.2 52.7 55.2 56.3]';  % mm, shell length at f and T
data.tL2_Davi1999(:,2) = data.tL2_Davi1999(:,2) / 10; % cm, convert mm to cm
units.tL2_Davi1999   = {'d', 'cm'};  label.tL2_Davi1999 = {'time since 5/28/1994', 'shell length'};  bibkey.tL2_Davi1999 = 'Davi1999';
temp.tL2_Davi1999    = C2K(14);  units.temp.tL2_Davi1999 = 'K'; label.temp.tL2_Davi1999 = 'temperature';
comment.tL2_Davi1999 = 'Oysters deployed mid may';

% Data from Eastern Canada - feeding on natural seston (surface aquaculture specific)
% shell length (cm), filtering rate (l/h)
data.LF = [57.34 57.34 58.73 59.47 62.72 61.08 63.95 66.37 62.81 62.12 64.15 65.11 62.20 62.46 64.36 68.71 75.98 75.03 88.77 96.06 93.07 92.81 94.82 89.02 91.29 86.54 95.57 98.67 102.31;
           1.9 2.5 2.0 2.8 4.4 5.7 7.3 7.9 3.0 3.1 3.5 2.6 2.0 1.7 1.6 2.9 2.7 4.3 4.2 4.6 5.1 5.8 6.2 6.3 7.4 7.9 11.5 7.3 7.5]';
data.LF(:,1) = data.LF(:,1)/10; % convert mm to cm
data.LF(:,2) = data.LF(:,2)*24;
units.LF = {'cm', 'l/d'}; label.LF = {'shell length', 'filtering rate'};  
temp.LF = C2K(16); units.temp.LF = 'K'; label.temp.LF = 'temperature';
bibkey.LF = 'Come2013'; 

% time since 1 jan 1935 (d), dry tissue weight (g)
data.tWd_LeviDoal2013 = [0 27 58 84 111 140 186 254 325 342 375 400 427 457 480 519 ;
                         0.29 0.53 0.98 1.11 1.40 1.55 1.59 1.50 1.55 1.76 1.79 1.66 2.04 2.70 2.96 3.14]';
units.tWd_LeviDoal2013   = {'d', 'g'};  label.tWd_LeviDoal2013 = {'time since 2008/06/09', 'dry tissue weight'};  
temp.tWd_LeviDoal2013    = C2K(14.4);  units.temp.tWd_LeviDoal2013 = 'K'; label.temp.tWd_LeviDoal2013 = 'temperature';
bibkey.tWd_LeviDoal2013 = 'LeviDoal2013';
comment.tWd_LeviDoal2013 = 'Data from shelter island (unpolluted control site)';

%  %%% Data from Shumway and Koen - Resp at different temperatures
%  % dry weight (g) oxygen consumption (mLO2/h) at T = 10C and f = 1
% data.WdJO_10 = [0.064	0.052	0.053	0.049	0.044	0.054	0.050	0.060	0.068	0.070	0.062	0.064	0.061	0.064	0.069	0.069	0.066	0.068	0.071	0.077	0.079	0.084	0.079	0.079	0.078	0.085	0.079	0.087	0.096	0.099	0.090	0.101	0.124	0.115	0.115	0.107	0.111	0.111	0.115	0.125	0.111	0.134	0.145	0.147	0.162	0.174	0.168	0.171	0.156	0.124	0.124	0.129	0.122	0.092	0.095	0.099	0.090	0.167	0.152	0.144	0.177	0.164	0.167	0.171	0.153	0.155	0.144	0.168	0.185	0.206	0.195	0.195	0.206	0.198	0.248	0.239	0.222	0.240	0.207	0.211	0.196	0.227	0.249	0.250	0.259	0.274	0.313	0.350	0.301	0.290	0.306	0.312	0.312	0.279	0.290	0.284	0.263	0.258	0.249	0.263	0.300	0.323	0.305	0.317	0.294	0.289	0.300	0.300	0.289	0.324	0.324	0.342	0.336	0.361	0.452	0.397	0.376	0.383	0.444	0.412	0.412	0.376	0.362	0.390	0.444	0.413	0.405	0.383	0.405	0.405	0.391	0.356	0.398	0.398	0.370	0.363	0.406	0.421	0.429	0.446	0.430	0.447	0.407	0.509	0.538	0.539	0.650	0.662	0.674	0.559	0.518	0.499	0.471	0.471	0.445	0.445	0.470	0.546	0.527	0.527	0.508	0.557	0.558	0.569	0.613	0.648	0.739	0.698	0.601	0.623	0.659	0.611; % g, dry weight
%                 0.011	0.012	0.014	0.015	0.013	0.018	0.020	0.023	0.024	0.021	0.020	0.019	0.017	0.017	0.018	0.016	0.015	0.015	0.013	0.013	0.016	0.017	0.017	0.018	0.021	0.022	0.024	0.029	0.026	0.023	0.020	0.020	0.019	0.020	0.021	0.023	0.024	0.028	0.031	0.034	0.035	0.030	0.033	0.039	0.037	0.036	0.033	0.030	0.030	0.028	0.026	0.024	0.023	0.018	0.017	0.016	0.016	0.021	0.021	0.022	0.024	0.024	0.023	0.027	0.028	0.026	0.026	0.042	0.039	0.035	0.035	0.032	0.028	0.027	0.026	0.031	0.032	0.037	0.042	0.047	0.050	0.049	0.044	0.053	0.063	0.057	0.061	0.070	0.059	0.053	0.052	0.050	0.047	0.049	0.049	0.044	0.042	0.037	0.036	0.033	0.032	0.033	0.034	0.038	0.037	0.037	0.040	0.043	0.042	0.042	0.044	0.042	0.039	0.032	0.036	0.036	0.041	0.039	0.039	0.041	0.042	0.045	0.048	0.044	0.042	0.044	0.048	0.048	0.049	0.051	0.052	0.055	0.054	0.058	0.063	0.067	0.052	0.055	0.060	0.066	0.070	0.077	0.084	0.081	0.080	0.088	0.086	0.098	0.078	0.075	0.071	0.061	0.061	0.052	0.050	0.047	0.045	0.047	0.050	0.054	0.054	0.052	0.060	0.067	0.072	0.071	0.070	0.066	0.059	0.054	0.050	0.047]'; % mlO2/h, oxygen consumption
% units.WdJO_10 = {'g', 'ml/h'}; label.WdJO_10 = {'dry weight', 'oxygen consumption'};
% temp.WdJO_10 = C2K(10); units.temp.WdJO_10 = 'K'; label.temp.WdJO_10 = 'temperature';
% bibkey.WdJO_10 = 'ShumKoen1982';
%  % at T = 20 C
% data.WdJO_20 = [0.035	0.037	0.046	0.045	0.034	0.041	0.044	0.050	0.046	0.047	0.053	0.056	0.057	0.067	0.065	0.056	0.057	0.063	0.065	0.070	0.089	0.078	0.078	0.089	0.080	0.102	0.105	0.089	0.089	0.099	0.109	0.122	0.134	0.123	0.123	0.102	0.145	0.153	0.145	0.151	0.147	0.178	0.185	0.165	0.182	0.172	0.172	0.151	0.215	0.264	0.241	0.241	0.204	0.216	0.237	0.280	0.307	0.350	0.338	0.376	0.343	0.377	0.447	0.439	0.448	0.424	0.358	0.371	0.338	0.463	0.539	0.560	0.511	0.605	0.676; % g, dry weight
%                 0.017	0.019	0.021	0.023	0.026	0.031	0.037	0.034	0.030	0.027	0.028	0.031	0.034	0.034	0.041	0.046	0.021	0.025	0.029	0.026	0.026	0.031	0.037	0.042	0.048	0.045	0.037	0.037	0.033	0.031	0.032	0.038	0.043	0.046	0.055	0.059	0.042	0.043	0.051	0.060	0.036	0.041	0.045	0.050	0.060	0.065	0.074	0.069	0.050	0.050	0.060	0.071	0.071	0.085	0.095	0.086	0.073	0.077	0.091	0.055	0.062	0.071	0.081	0.095	0.102	0.117	0.111	0.100	0.097	0.070	0.091	0.110	0.115	0.136	0.110]'; % mlO2/h, oxygen consumption
% units.WdJO_20 = {'g', 'ml/h'}; label.WdJO_20 = {'dry weight', 'oxygen consumption'};
% temp.WdJO_20 = C2K(20); units.temp.WdJO_20 = 'K'; label.temp.WdJO_20 = 'temperature';
% bibkey.WdJO_20 = 'ShumKoen1982';
%  % at T = 30C
% data.WdJO_30 = [0.036	0.040	0.042	0.047	0.047	0.055	0.057	0.063	0.059	0.056	0.056	0.063	0.043	0.088	0.083	0.096	0.091	0.083	0.073	0.079	0.069	0.069	0.077	0.083	0.093	0.099	0.104	0.093	0.112	0.123	0.146	0.149	0.126	0.121	0.102	0.111	0.136	0.146	0.170	0.177	0.198	0.187	0.186	0.170	0.189	0.183	0.251	0.286	0.314	0.281	0.271	0.261	0.233	0.271	0.267	0.327	0.327	0.327	0.359	0.359	0.332	0.393	0.474	0.493	0.466	0.467	0.433	0.418	0.370	0.360	0.434	0.450	0.494	0.494	0.574	0.575; % g, dry weight
%                 0.056	0.063	0.079	0.070	0.092	0.097	0.103	0.090	0.074	0.071	0.060	0.047	0.035	0.048	0.053	0.054	0.061	0.068	0.068	0.077	0.096	0.105	0.111	0.105	0.101	0.097	0.085	0.085	0.070	0.064	0.095	0.109	0.105	0.118	0.127	0.143	0.129	0.145	0.145	0.169	0.176	0.140	0.124	0.109	0.092	0.099	0.109	0.101	0.093	0.117	0.127	0.145	0.148	0.163	0.197	0.186	0.166	0.153	0.153	0.169	0.117	0.126	0.126	0.142	0.147	0.178	0.184	0.208	0.216	0.197	0.238	0.216	0.212	0.196	0.212	0.242]'; % mlO2/h, oxygen consumption
% units.WdJO_30 = {'g', 'ml/h'}; label.WdJO_30 = {'dry weight', 'oxygen consumption'};
% temp.WdJO_30 = C2K(30); units.temp.WdJO_30 = 'K'; label.temp.WdJO_30 = 'temperature';
% bibkey.WdJO_30 = 'ShumKoen1982';

%% set weights for all real data
weights = setweights(data, []);

%% set pseudodata and respective weights
[data, units, label, weights] = addpseudodata(data, units, label, weights);
% weights.psd.v = 2 * weights.psd.v;
% data.psd.k = 0.3; units.psd.k = '-'; label.psd.k = 'maintenance ratio';
% weights.psd.k = 2 * weights.psd.k_J; weights.psd.k_J = 0;
% weights.psd.p_M = 5 * weights.psd.p_M;

%% pack auxData and txtData for output
auxData.temp   = temp;
txtData.units  = units;
txtData.label  = label;
txtData.bibkey = bibkey;
txtData.comment = comment;

%% Group plots
set1 = {'tL_GrizWard2017','tL_KraeFord2007'}; subtitle1 = {'Growth at NH and NJ'};
set2 = {'tL1_Davi1999','tL2_Davi1999'}; subtitle2 = {'Growth in upper and lower DRE'};
% set3 = {'WdJO_30','WdJO_20','WdJO_10'}; subtitle3 = {'respiration rate at 30, 20, 10C'};

metaData.grp.sets    = {set1 set2};
metaData.grp.comment = {subtitle1 subtitle2};

%% Discussion points
% D1 = 'mod_1: use of pseudo-data k, instead of k_J, to avoid that maintenance ratio k exceeds 1';
% metaData.discussion = struct('D1', D1);

%% Links
metaData.links.id_CoL = 'Z6ZW'; % Cat of Life
metaData.links.id_ITIS = '79872'; % ITIS
metaData.links.id_EoL = '46467110'; % Ency of Life
metaData.links.id_Wiki = 'Crassostrea_virginica'; % Wikipedia
metaData.links.id_ADW = 'Crassostrea_virginica'; % ADW
metaData.links.id_Taxo = '39285'; % Taxonomicon
metaData.links.id_WoRMS = '140657'; % WoRMS
metaData.links.id_molluscabase = '140657'; % molluscabase


%% References
bibkey = 'Kooy2010'; type = 'Book'; bib = [ ...  % used in setting of chemical parameters and pseudodata
'author = {Kooijman, S.A.L.M.}, ' ...
'year = {2010}, ' ...
'title  = {Dynamic Energy Budget theory for metabolic organisation}, ' ...
'publisher = {Cambridge Univ. Press, Cambridge}, ' ...
'pages = {Table 4.2, p.150 and 8.1, p.300}, ' ...
'howpublished = {\url{../../../bib/Kooy2010.html}}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Pryth1929'; type = 'techreport'; bib = [ ...
'author = {Andrews, J. D.}, ' ... 
'year = {1929}, ' ...
'title = {Investigation of the physical conditions controlling spawning of oysters and the occurance, distribution, and setting of oyster larvae in Milford Harbor, Connecticut}, ' ...
'publisher = {US Government Printing Office}, '];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Coe1932'; type = 'Article'; bib = [ ...
'author = {Coe, W. R. }, ' ...
'year = {1932}, ' ...
'title = {Sexual Phases in the American Oyster (Ostrea Virginica)}, ' ...
'journal = {Biological Bulletin}, ' ...
'volume = {63}, ' ...
'pages = {419--441}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'GlanMich2016'; type = 'Article'; bib = [ ...
'author = {Glandon, H. L., Michaelis, A. K., Politano, V. A., Alexander, S. T., Vlahovich, E. A., Reece, K. S., Koopman, H. N., Meritt, D. W., Paynter, K. T.}, ' ...
'year = {2016}, ' ...
'title = {Impact of Environment and Ontogeny on Relative Fecundity and Egg Quality of Female Oysters (Crassostrea virginica) from Four Sites in Northern Chesapeake Bay}, ' ...
'journal = {Biological Bulletin}, ' ...
'volume = {231}, ' ...
'pages = {158--198}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
% 
bibkey = 'KraeFord2007'; type = 'Article'; bib = [ ...
'author = {Kraeuter, J. N., Ford, S., Cummings, M}, ' ...
'year = {2007}, ' ...
'title = {Oyster growth analysis: A comparison of methods}, ' ...
'journal = {Journal of Shellfish Research}, ' ...
'volume = {26}, ' ...
'pages = {479--491}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Kiff2022'; type = 'Misc'; bib = [ ...
'author = {Kiffney, T.}, ' ...
'year = {2022}, ' ...
'title = {Field Monitoring, unpublished data}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'GrizWard2017'; type = 'Article'; bib = [ ...
'author = {Grizzel, R. E., Ward, K. M., Peter, C. R., Cantwell, M., Katz, D., Sullivan, J.}, ' ...
'year = {2017}, ' ...
'title = {Growth, morphometrics, and nutrient content of farmed eastern oysters, Crassostrea virginica (Gmelin), in New Hampshire, USA}, ' ...
'journal = {Auatic resources}, ' ...
'volume = {48}, ' ...
'pages = {1525--1537}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Davi1999'; type = 'Article'; bib = [ ...
'author = {Davis, C. V., Barber, B. J}, ' ...
'year = {2017}, ' ...
'title = {Growth and survival of selected lines of eastern oysters, Crassostrea Virginica affected by juvenile oyster disease}, ' ...
'journal = {Aquaculture}, ' ...
'volume = {179}, ' ...
'pages = {253--271}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Come2013'; type = 'Article'; bib = [ ...
'author = {Comeau, L. A.}, ' ...
'year = {2017}, ' ...
'title = {Suspended versus bottom oyster culture in eastern Canada: Comparing stocking densities and clearance rates}, ' ...
'journal = {Aquaculture}, ' ...
'volume = {410}, ' ...
'pages = {57--65}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'ShumKoen1982'; type = 'Article'; bib = [ ...
'author = {Shumway, S. E., Koen, R. K.}, ' ...
'year = {1982}, ' ...
'title = {Oxygen consumption in the American oyster Crassostrea virginica}, ' ...
'journal = {Marine Ecology Progress Series}, ' ...
'volume = {9}, ' ...
'pages = {59--68}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];




% 
bibkey = 'Andr1979'; type = 'Inbook'; bib = [ ...
'author = {Andrews, J. D.}, ' ... 
'year = {1979}, ' ...
'title = {Pelecypoda: Ostreidae}, ' ...
'booktitle = {Reproduction of marine invertebrates Vol. 5: Molluscs: Pelecypods and lesser classes}, ' ...
'editor = {A. C. Giese and J. S. Pearse}, ' ...
'publisher = {Elsevier Science}, ' ...
'pages = {293-3-41}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Carr2009'; type = 'Inbook'; bib = [ ...
'author = {Carriker, M. R.}, ' ...
'year = {2009}, ' ...
'title = {The shell and the ligament}, ' ...
'booktitle = {The Eastern oyster \emph{Crassostrea virginica}}, ' ...
'editor = {V. S. Kennedy and R. I. E. Newell and A. F. Eble}, ' ...
'publisher = {Maryland Sea Greant College, University of Maryland System, College Park}, ' ...
'pages = {75--160}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'ChoiLewi1993'; type = 'Article'; bib = [ ...
'author = {Choi, K. S. and Lewis, D. H. and Powell, E. N. and Ray, S. M.}, ' ...
'year = {1993}, ' ...
'title = {Quantitative measurement of reproductive output in the {A}merican oyster, \emph{Crassostrea virginica}, using an enzyme-linked immunosorbent assay}, ' ...
'journal = {Aquaculture and Fisheries Management}, ' ...
'volume = {24}, ' ...
'pages = {299--322}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'GallMann1986'; type = 'Article'; bib = [ ...
'author = {Gallager, S. M. and Mann, R. and Sasaki, G. C.}, ' ...
'year = {1986}, ' ...
'title = {Lipid as an index of growth and viability in three species of bivalve larvae}, ' ...
'journal = {Aquaculture}, ' ...
'volume = {56}, ' ...
'pages = {81--103}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Gals1964'; type = 'Book'; bib = [ ...
'author = {Galstoff, P. S.}, ' ...
'year = {1964}, ' ...
'title = {The American oyster \emph{Crassostrea virginica} Gmelin}, ' ...
'publisher = {Unites States Department of the Interior, Fish and Wildlife Service, Bureau of Commercial Fisheries}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'HayeMenz1981'; type = 'Article'; bib = [ ...
'author = {Hayes, P. F. and Menzel, R. W.}, ' ...
'year = {1981}, ' ...
'title  = {The reproductive cycle of early setting \emph{Crassostrea virginica} in the northern {G}ulf of {M}exico, and its implications for population recruitment}, ' ...
'journal = {The Biological Bulletin}, ' ...
'volume = {160}, ' ...
'number = {1}, ' ...
'pages = {80--88}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'HoffPowe1992'; type = 'Article'; bib = [ ...
'author = {Hoffman, E. E. and Powell, E. N. and Klinck, J. N. and Wilson, E. A.}, ' ...
'year = {1992}, ' ...
'title  = {Modeling oyster populations III. {C}ritical feeding periods, growth and reproduction}, ' ...
'journal = {Journal of Shellfish Research}, ' ...
'volume = {11}, ' ...
'number = {2}, ' ...
'pages = {399--416}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'LabaFern1999'; type = 'Article'; bib = [ ...
'author = {Labarta, U. and Fern\~{a}ndez-Reiriz, M. J. and P\''{e}rez-Camacho, A.}, ' ...
'year = {1999}, ' ...
'title = {Energy, biochemical substrates and growth in the larval development, metamorphosis and postlarvae of \emph{Ostrea edulis}}, ' ...
'journal = {Journal of Experimental Marine Biology and Ecology}, ' ...
'volume = {238}, ' ...
'number = {3}, ' ...
'pages = {225-242}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'ObeiHeff1996'; type = 'Article'; bib = [ ...
'author = {O''Beirn, F. X. and Heffernan, P. B. and Walker, R. L. and Jansen, M. L.}, ' ...
'year = {1996}, ' ...
'title = {Young-of-the-year oyster, \emph{Crassostrea virginica}, reproduction in coastal {G}eorgia}, ' ...
'journal = {Estuaries}, ' ...
'volume = {19}, ' ...
'number = {3}, ' ...
'pages = {651--658}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Toma1981'; type = 'PhDthesis'; bib = [ ...
'author = {Tomaszewski, C.}, ' ...
'year = {1981}, ' ...
'title = {Cementation in the early dissoconch stage of \emph{Crassostrea virginica}}, ' ...
'school = {University of Delaware}, ' ...
'pages = {94}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Wiki'; type = 'Misc'; bib = ...
'URL = {http://en.wikipedia.org/wiki/Crassostrea_virginica}';
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
