function [matches, confidences] = match_features_kd_tree(features1, features2)
mdl = KDTreeSearcher(features2);
[I,B] = knnsearch(mdl,features1,'K',2) ;
confidences = B(:,1) ./ B(:,2); 
ind = find(confidences);
s = size(ind);
matches = zeros(s(1),2);
matches(:,1) = ind; 
matches(:,2) = I(ind);                                                                       
confidences = 1./confidences(ind);
[confidences, ind] = sort(confidences, 'descend');
matches = matches(ind,:);
matches = matches(1:100,:); 
confidences = confidences(1:100,:);
end
