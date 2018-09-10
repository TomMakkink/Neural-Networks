% function risk_fcn which accepts 4 × 1 inputs and returns
% the risk value.
function r = risk_fcn (x)
load risk_train.mat
r = sim(risk_net,x);
end 