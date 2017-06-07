function [vecs] = get_rand_vecs_for_rpcv_sims(num_para)
  
  vecs = zeros(2, num_para);

  vecs(1,:) = normrnd(0,1,1,num_para);
  vecs(1,:) = vecs(1,:) / norm(vecs(1,:));
  vecs(2,:) = -vecs(1,:);

  

end