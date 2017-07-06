function [est_vals ] = get_mult_plugin_ip_onevec(small_V_Pair1, small_V_Pair2, vec, true_vec1_vals, true_vec2_vals, types, mult_cv_type, to_est_vec, pluginval1, pluginval2, ipval)
  
  small_V_Pair1 = small_V_Pair1.vmat;
  small_V_Pair2 = small_V_Pair2.vmat;
  vec = vec.vmat;
  pluginval1 = pluginval1(:,1);
  pluginval2 = pluginval2(:,2);

  if types == 1 || types == 2 || types == 5
    mult = 1;
  elseif types == 3
    mult = 5;
  elseif types == 4
    mult = 10;
  end

  if strcmp(to_est_vec, 'est_ED')
    Avec = mult*(small_V_Pair1 - small_V_Pair2).^2;
  elseif strcmp(to_est_vec, 'est_IP')
    Avec = mult*(small_V_Pair1 .* small_V_Pair2);
  end


  if strcmp(mult_cv_type, 'ED-ish')
    Bvec = mult*(small_V_Pair1 - repmat(vec(1,:), size(small_V_Pair1,1),1)).^2;
    Cvec = mult*(small_V_Pair2 - repmat(vec(2,:), size(small_V_Pair2,1),1)).^2;
    var_z1 = 8*(1- pluginval1).^2;
    var_z2 = 8*(1-pluginval2).^2;
    cov_z1z2 = 2 * ( ipval - pluginval1 - pluginval2 + 1).^2;
    cov_yz1 = 2 * (1 - ipval - pluginval1 + pluginval2).^2;
    cov_yz2 = 2 * (ipval - pluginval1 +pluginval2 -1).^2;
  elseif strcmp(mult_cv_type, 'IP-ish')
    Bvec = mult*(small_V_Pair1 .* repmat(vec(1,:), size(small_V_Pair1,1),1));
    Cvec = mult*(small_V_Pair2 .* repmat(vec(2,:), size(small_V_Pair2,1),1));

    var_z1 = 1 + pluginval1.^2;
    var_z2 = 1 + pluginval2.^2;
    cov_z1z2 = ipval + pluginval1 .* pluginval2;
    cov_yz1 = (1 - ipval) .* (pluginval1 - pluginval2);
    cov_yz2 = (ipval - 1) .* (pluginval1 - pluginval2);
  end


  opt_c1 = (var_z2 .* cov_yz1 - cov_z1z2 .* cov_yz2)./(cov_z1z2.^2 - var_z1 .* var_z2);
  opt_c2 = (var_z1 .* cov_yz2 - cov_z1z2 .* cov_yz1)./(cov_z1z2.^2 - var_z1 .* var_z2);    
  
  if strcmp(to_est_vec, 'est_ED')
    est_vals = (mean(Avec + opt_c1 .* ( Bvec - true_vec1_vals(:,1)) + opt_c2 .* (Cvec - true_vec2_vals(:,1)),2));
    est_vals(est_vals <  0) = 0 ;
    est_vals = sqrt(est_vals);
  elseif strcmp(to_est_vec, 'est_IP')
    est_vals = (mean(Avec + opt_c1 .* ( Bvec - true_vec1_vals(:,1)) + opt_c2 .* (Cvec - true_vec2_vals(:,1)),2));
  end






end