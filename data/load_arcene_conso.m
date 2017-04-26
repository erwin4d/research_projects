function [X] = load_arcene_conso()

  X1 = sparse(feval('load', 'arcene_train.data'));
  X2 = sparse(feval('load', 'arcene_valid.data'));
  X3 = sparse(feval('load', 'arcene_test.data'));

  X = [X1;X2;X3];
end
