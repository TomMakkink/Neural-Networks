% function housingfcn which accepts 13 × 1 inputs and returns
% the house value.
function price = housing_fcn (x)
load housing_sup.mat
price = sim(housingnet,x);
end 