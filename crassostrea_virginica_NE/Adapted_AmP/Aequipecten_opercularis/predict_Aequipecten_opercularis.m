function [prdData, info] = predict_Aequipecten_opercularis(par, data, auxData)
  
  % unpack par, data, auxData
  cPar = parscomp_st(par); vars_pull(par); 
  vars_pull(cPar);  vars_pull(data);  vars_pull(auxData);
  
  % compute temperature correction factors
  TC_ab = tempcorr(temp.ab, T_ref, T_A);
  TC = tempcorr(temp.am, T_ref, T_A); kT_M = k_M * TC;
  
  % zero-variate data

  % life cycle
  pars_tj = [g k l_T v_Hb v_Hj v_Hp];
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B, info] = get_tj(pars_tj, f);
    
  % birth
  L_b = L_m * l_b;                  % cm, structural length at birth at f
  aT_b = t_b/ k_M/ TC_ab;           % d, age at birth at f and T
  Ww_b = L_b^3 * (1 + f * w);       % g, wet weight at birth
  
  % metam
  tT_j = (t_j - t_b)/ kT_M;         % d, time since birth at metam
  
  % puberty 
  L_p = L_m * l_p;                  % cm, structural length at puberty at f
  Lw_p = L_p/ del_M;                % cm, total length at puberty at f
  tT_p = (t_p - t_b)/ kT_M;         % d, time since birth at puberty

  % ultimate
  L_i = L_m * l_i;                  % cm, ultimate structural length at f
  Lw_i = L_i/ del_M;                % cm, ultimate total length at f
  Ww_i = L_i^3 * (1 + f * ome);     % g, ultimate flesh wet weight
 
  % reproduction
  pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hj; U_Hp]; % compose parameter vector at T
  RT_i = TC * 365 * reprod_rate_j(L_i, f, pars_R); % #/d, mas reprod rate  

  % life span
  pars_tm = [g; l_T; h_a/ k_M^2; s_G];  % compose parameter vector at T_ref
  t_m = get_tm_s(pars_tm, f, l_b);      % -, scaled mean life span at T_ref
  aT_m = t_m/ kT_M;                     % d, mean life span at T
  
  % pack to output
  prdData.ab = aT_b;
  prdData.tj = tT_j;
  prdData.tp = tT_p;
  prdData.am = aT_m;
  prdData.Li = Lw_i;
  prdData.Wwb = Ww_b;
  prdData.Wwi = Ww_i;
  prdData.Ri = RT_i;

  % uni-variate data
  
  % time-length post metam 
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tL);
  r_B = rho_B * k_M; L_i = l_i * L_m;
  [t L] = ode45(@get_L, tL(:,1), Lw_0*del_M, [], r_B, L_i, T_ref, T_A); 
  ELw = L/ del_M;
  
  % pack to output
  prdData.tL= ELw;

end

function dL = get_L(t, L, r_B, L_i, T_ref, T_A)
  TC = tempcorr(C2K(10+9*sin(2*pi*(t+250)/365)), T_ref, T_A);
  dL = TC * r_B * (L_i -L);
end