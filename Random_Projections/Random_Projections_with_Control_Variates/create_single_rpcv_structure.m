function [overall_struct] = create_single_rpcv_structure( mat, true_ED_vals, true_IP_vals, data_name, nsims)
  
  [ err_mat_ED_ord] = create_struct_to_save(mat, data_name, 'ordinary_ED', nsims, true_ED_vals);
  [ err_mat_ED_li] = create_struct_to_save(mat, data_name, 'li_ED', nsims, true_ED_vals);
  [ err_mat_ED_cv_emp] = create_struct_to_save(mat, data_name, 'cv_emp_ED', nsims, true_ED_vals);
  [ err_mat_ED_cv_thr_ord] = create_struct_to_save(mat, data_name, 'cv_subst_ord_IP_for_ED', nsims, true_ED_vals);
  [ err_mat_ED_cv_thr_li] = create_struct_to_save(mat, data_name, 'cv_subst_li_IP_for_ED', nsims, true_ED_vals);

  [ err_mat_IP_ord] = create_struct_to_save(mat, data_name, 'ord_IP', nsims, true_IP_vals);
  [ err_mat_IP_li] = create_struct_to_save(mat, data_name, 'li_IP', nsims, true_IP_vals);
  [ err_mat_IP_cv_emp] = create_struct_to_save(mat, data_name, 'cv_emp_IP', nsims, true_IP_vals);
  [ err_mat_IP_cv_thr_ord] = create_struct_to_save(mat, data_name, 'cv_subst_ord_IP_for_IP', nsims, true_IP_vals);
  [ err_mat_IP_cv_thr_li] = create_struct_to_save(mat, data_name, 'cv_subst_li_IP_for_IP', nsims, true_IP_vals);

  overall_struct.err_mat_ED_ord = err_mat_ED_ord;
  overall_struct.err_mat_ED_li = err_mat_ED_li;
  overall_struct.err_mat_ED_cv_emp = err_mat_ED_cv_emp;
  overall_struct.err_mat_ED_cv_thr_ord = err_mat_ED_cv_thr_ord;
  overall_struct.err_mat_ED_cv_thr_li = err_mat_ED_cv_thr_li;      

  overall_struct.err_mat_IP_ord = err_mat_IP_ord;
  overall_struct.err_mat_IP_li = err_mat_IP_li;
  overall_struct.err_mat_IP_cv_emp = err_mat_IP_cv_emp;
  overall_struct.err_mat_IP_cv_thr_ord = err_mat_IP_cv_thr_ord;
  overall_struct.err_mat_IP_cv_thr_li = err_mat_IP_cv_thr_li;

end

