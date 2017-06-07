function [ this_struct] = create_struct_to_save( X, data_name, tag, nsims, trueval)
  
  this_struct.store = X;
  this_struct.data_name = data_name;
  this_struct.tag = tag;
  this_struct.nsims = nsims;
  this_struct.trueval = trueval;

end

