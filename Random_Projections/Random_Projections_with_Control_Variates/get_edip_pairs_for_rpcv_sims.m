function [XStruct] = get_edip_pairs_for_rpcv_sims(eig_vecs, rand_vecs, XStruct)
  
 
  % rand ip, rand ed
  % eig ip eig ed

  % To loop in new iteration (Not now)

  % First work with rand_vecs

  newpair1 = zeros(size(XStruct.pair1,1),size(rand_vecs,1));
  newpair2 = zeros(size(XStruct.pair1,1),size(rand_vecs,1));

  % Do ED for rand_vecs
  for j = 1:size(rand_vecs,1);
  	newpair1(:,j) = sum((repmat(rand_vecs(j,:), size(XStruct.pair1,1), 1) - XStruct.pair1).^2,2);
  	newpair2(:,j) = sum((repmat(rand_vecs(j,:), size(XStruct.pair2,1), 1) - XStruct.pair2).^2,2);
  end
  
  XStruct.random_ED_1 = newpair1;
  XStruct.random_ED_2 = newpair2;

  newpair1 = zeros(size(XStruct.pair1,1),size(eig_vecs,1));
  newpair2 = zeros(size(XStruct.pair1,1),size(eig_vecs,1));

  % Do ED for eig_vecs
  for j = 1:size(eig_vecs,1);
    newpair1(:,j) = sum((repmat(eig_vecs(j,:), size(XStruct.pair1,1), 1) - XStruct.pair1).^2,2);
    newpair2(:,j) = sum((repmat(eig_vecs(j,:), size(XStruct.pair2,1), 1) - XStruct.pair2).^2,2);
  end
  
  XStruct.eigvecs_ED_1 = newpair1;
  XStruct.eigvecs_ED_2 = newpair2;

  % Do IP for rand_vecs

  newpair1 = zeros(size(XStruct.pair1,1),size(rand_vecs,1));
  newpair2 = zeros(size(XStruct.pair1,1),size(rand_vecs,1));

  for j = 1:size(rand_vecs,1);
    newpair1(:,j) = sum((repmat(rand_vecs(j,:), size(XStruct.pair1,1), 1) .* XStruct.pair1),2);
    newpair2(:,j) = sum((repmat(rand_vecs(j,:), size(XStruct.pair2,1), 1) .* XStruct.pair2),2);
  end

  XStruct.random_IP_1 = newpair1;
  XStruct.random_IP_2 = newpair2;


  % Do IP for eigvecs
  newpair1 = zeros(size(XStruct.pair1,1),size(eig_vecs,1));
  newpair2 = zeros(size(XStruct.pair1,1),size(eig_vecs,1));

  for j = 1:size(eig_vecs,1);
    newpair1(:,j) = sum((repmat(eig_vecs(j,:), size(XStruct.pair1,1), 1) .* XStruct.pair1),2);
    newpair2(:,j) = sum((repmat(eig_vecs(j,:), size(XStruct.pair2,1), 1) .* XStruct.pair2),2);
  end

  XStruct.eigvecs_IP_1 = newpair1;
  XStruct.eigvecs_IP_2 = newpair2;



end