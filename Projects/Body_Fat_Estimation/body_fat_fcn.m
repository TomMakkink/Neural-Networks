% function body_fat_fcn which accepts 13 × 1 inputs and returns
% the house value.
function bodyFatPercentage = body_fat_fcn (x)
load bodyFat.mat
bodyFatPercentage = sim(bodyFatNet,x)
end 