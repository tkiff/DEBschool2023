function [data, auxData, metaData, txtData, weights] = mydata_Squalus_acanthias_br
% file generated by prt_mydata

%% set metaData
metaData.phylum     = 'Chordata';
metaData.class      = 'Chondrichthyes';
metaData.order      = 'Squaliformes';
metaData.family     = 'Squalidae';
metaData.species    = 'Squalus_acanthias_br';
metaData.species_en = 'Spurdog';

metaData.ecoCode.climate = {'MB','MC'};
metaData.ecoCode.ecozone = {'MAN','MAS','MAm'};
metaData.ecoCode.habitat = {'0iMcd'};
metaData.ecoCode.embryo  = {'T','Mv'};
metaData.ecoCode.migrate = {'Mo'};
metaData.ecoCode.food    = {'biCi','biCvf'};
metaData.ecoCode.gender  = {'D'};
metaData.ecoCode.reprod  = {'O'};

metaData.T_typical  = C2K(9); % K, body temp

metaData.data_0     = {'ab','tp','am','Lb','Lp','Li','Ww0','Wwp','Wwi','Ri','ah','tp','am','Lb','Lp','Li','Ww0','Wwp','Wdi','Ri'};
metaData.data_1     = {'LR'};

metaData.COMPLETE   = 1; % using criteria of LikaKear2011

metaData.author     = {'x'};
metaData.date_subm  = [2023 6 6];
metaData.email      = {'x'};
metaData.address    = {'x'};

metaData.curator    = {'Dina Lika'};
metaData.email_cur  = {'lika@uoc.gr'};
metaData.date_acc   = [2023 6 6];

%% set zero-variate data
data.ah = 690; units.ah = 'd'; label.ah = 'age at hatch'; bibkey.ah = {'x'};
  temp.ah = C2K(9); units.temp.ah = 'K'; label.temp.ah = 'temperature';
data.tp = 2190; units.tp = 'd'; label.tp = 'time since birth at puberty'; bibkey.tp = {'x'};
  temp.tp = C2K(9); units.temp.tp = 'K'; label.temp.tp = 'temperature';
data.am = 29200; units.am = 'd'; label.am = 'life span'; bibkey.am = {'x'};
  temp.am = C2K(9); units.temp.am = 'K'; label.temp.am = 'temperature';

data.Lb = 24; units.Lb = 'cm'; label.Lb = 'length at birth'; bibkey.Lb = {'x'};
data.Lp = 72; units.Lp = 'cm'; label.Lp = 'length at puberty'; bibkey.Lp = {'x'};
data.Li = 136; units.Li = 'cm'; label.Li = 'ultimate length'; bibkey.Li = {'x'};

data.Ww0 = 35; units.Ww0 = 'g'; label.Ww0 = 'initial wet weight'; bibkey.Ww0 = {'x'};
data.Wwp = 950; units.Wwp = 'g'; label.Wwp = 'wet weight at puberty'; bibkey.Wwp = {'x'};
data.Wdi = 9900; units.Wdi = 'g'; label.Wdi = 'ultimate dry weight'; bibkey.Wdi = {'x'};

data.Ri = 0.019; units.Ri = '#/d'; label.Ri = 'ultimate reproduction rate'; bibkey.Ri = {'x'};
  temp.Ri = C2K(9); units.temp.Ri = 'K'; label.temp.Ri = 'temperature';

%% set weights for all real data
weights = setweights(data, []);

%% set pseudodata and respective weights
[data, units, label, weights] = addpseudodata(data, units, label, weights);

%% pack auxData and txtData for output
auxData.temp = temp;
txtData.units = units;
txtData.label = label;
txtData.bibkey = bibkey;

%% Links
metaData.links.id_CoL = ''; % Cat of Life

%% References
bibkey = 'Kooy2010'; type = 'Book'; bib = [ ...  % used in setting of chemical parameters and pseudodata
'author = {Kooijman, S.A.L.M.}, ' ...
'year = {2010}, ' ...
'title  = {Dynamic Energy Budget theory for metabolic organisation}, ' ...
'publisher = {Cambridge Univ. Press, Cambridge}, ' ...
'pages = {Table 4.2 (page 150), 8.1 (page 300)}, ' ...
'howpublished = {\url{http://www.bio.vu.nl/thb/research/bib/Kooy2010.html}}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'x'; type = 'article'; bib = [ ...
''];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ', bib, '}'';'];
%
