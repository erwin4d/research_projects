function [vals] = get_small_v_obs(est_obj, kvals, div_by)
  
  vals = est_obj(:,:,kvals) / div_by;
  
end