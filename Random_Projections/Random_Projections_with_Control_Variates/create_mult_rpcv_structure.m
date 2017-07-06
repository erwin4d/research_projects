function [overall_struct] = create_mult_rpcv_structure( mat, true_ED_vals, true_IP_vals, data_name, nsims, struct_name)
  
  [ one_evec_by_ED_for_ED] = create_struct_to_save(mat, data_name, 'one_evec_by_ED_for_ED', nsims, true_ED_vals);  
  [ two_evec_by_ED_for_ED] = create_struct_to_save(mat, data_name, 'two_evec_by_ED_for_ED', nsims, true_ED_vals);  

  overall_struct.one_evec_by_ED_for_ED = one_evec_by_ED_for_ED;
  overall_struct.two_evec_by_ED_for_ED = two_evec_by_ED_for_ED;

  [ one_evec_by_IP_for_ED] = create_struct_to_save(mat, data_name, 'one_evec_by_IP_for_ED', nsims, true_ED_vals);  
  [ two_evec_by_IP_for_ED] = create_struct_to_save(mat, data_name, 'two_evec_by_IP_for_ED', nsims, true_ED_vals);  

  overall_struct.one_evec_by_IP_for_ED = one_evec_by_IP_for_ED;
  overall_struct.two_evec_by_IP_for_ED = two_evec_by_IP_for_ED;

  [ one_rand_by_ED_for_ED] = create_struct_to_save(mat, data_name, 'one_rand_by_ED_for_ED', nsims, true_ED_vals);  
  [ two_rand_by_ED_for_ED] = create_struct_to_save(mat, data_name, 'two_rand_by_ED_for_ED', nsims, true_ED_vals);  

  overall_struct.one_rand_by_ED_for_ED = one_rand_by_ED_for_ED;
  overall_struct.two_rand_by_ED_for_ED = two_rand_by_ED_for_ED;


  [ one_rand_by_IP_for_ED] = create_struct_to_save(mat, data_name, 'one_rand_by_IP_for_ED', nsims, true_ED_vals);  
  [ two_rand_by_IP_for_ED] = create_struct_to_save(mat, data_name, 'two_rand_by_IP_for_ED', nsims, true_ED_vals);  

  overall_struct.one_rand_by_IP_for_ED = one_rand_by_IP_for_ED;
  overall_struct.two_rand_by_IP_for_ED = two_rand_by_IP_for_ED;




  [ one_evec_by_ED_for_IP] = create_struct_to_save(mat, data_name, 'one_evec_by_ED_for_IP', nsims, true_IP_vals);  
  [ two_evec_by_ED_for_IP] = create_struct_to_save(mat, data_name, 'two_evec_by_ED_for_IP', nsims, true_IP_vals);  

  overall_struct.one_evec_by_ED_for_IP = one_evec_by_ED_for_IP;
  overall_struct.two_evec_by_ED_for_IP = two_evec_by_ED_for_IP;

  [ one_evec_by_IP_for_IP] = create_struct_to_save(mat, data_name, 'one_evec_by_IP_for_IP', nsims, true_IP_vals);  
  [ two_evec_by_IP_for_IP] = create_struct_to_save(mat, data_name, 'two_evec_by_IP_for_IP', nsims, true_IP_vals);  

  overall_struct.one_evec_by_IP_for_IP = one_evec_by_IP_for_IP;
  overall_struct.two_evec_by_IP_for_IP = two_evec_by_IP_for_IP;

  [ one_rand_by_ED_for_IP] = create_struct_to_save(mat, data_name, 'one_rand_by_ED_for_IP', nsims, true_IP_vals);  
  [ two_rand_by_ED_for_IP] = create_struct_to_save(mat, data_name, 'two_rand_by_ED_for_IP', nsims, true_IP_vals);  

  overall_struct.one_rand_by_ED_for_IP = one_rand_by_ED_for_IP;
  overall_struct.two_rand_by_ED_for_IP = two_rand_by_ED_for_IP;


  [ one_rand_by_IP_for_IP] = create_struct_to_save(mat, data_name, 'one_rand_by_IP_for_IP', nsims, true_IP_vals);  
  [ two_rand_by_IP_for_IP] = create_struct_to_save(mat, data_name, 'two_rand_by_IP_for_IP', nsims, true_IP_vals);  
  
  overall_struct.one_rand_by_IP_for_IP = one_rand_by_IP_for_IP;
  overall_struct.two_rand_by_IP_for_IP = two_rand_by_IP_for_IP;
  
  overall_struct.name = struct_name;

 

end

