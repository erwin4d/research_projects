function [newpair1, newpair2] = get_edip_pairs_for_rpcv_sims(known_vecs, pair1, pair2, sim_type)
  
  newpair1 = zeros(size(pair1,1),size(known_vecs,1));
  newpair2 = zeros(size(pair1,1),size(known_vecs,1));

  if strcmp(sim_type, 'ED')
  	for j = 1:size(known_vecs,1);
  		newpair1(:,j) = sum((repmat(known_vecs(j,:), size(pair1,1), 1) - pair1).^2,2);
  		newpair2(:,j) = sum((repmat(known_vecs(j,:), size(pair2,1), 1) - pair2).^2,2);
    end
  elseif strcmp(sim_type, 'IP')
  	for j = 1:size(known_vecs,1);
  		newpair1(:,j) = sum((repmat(known_vecs(j,:), size(pair1,1), 1) .* pair1),2);
  		newpair2(:,j) = sum((repmat(known_vecs(j,:), size(pair2,1), 1) .* pair2),2);
    end
  end



end