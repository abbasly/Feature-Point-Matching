% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Please implement the "nearest neighbor distance ratio test", 
% Equation 4.18 in Section 4.1.3 of Szeliski. 
% For extra credit you can implement spatial verification of matches.

%
% Please assign a confidence, else the evaluation function will not work.
%

% This function does not need to be symmetric (e.g., it can produce
% different numbers of matches depending on the order of the arguments).

% Input:
% 'features1' and 'features2' are the n x feature dimensionality matrices.
%
% Output:
% 'matches' is a k x 2 matrix, where k is the number of matches. The first
%   column is an index in features1, the second column is an index in features2. 
%
% 'confidences' is a k x 1 matrix with a real valued confidence for every match.

function [matches, confidences] = match_features(features1, features2)

% Placeholder random matches and confidences.
feature_count = min(size(features1, 1), size(features2,1));
matches = zeros(feature_count, 2);
matches(:,2) = randperm(feature_count);
matches(:,1) = randperm(feature_count); 
confidences = rand(feature_count,1);
Dist = pdist2(features1, features2, 'euclidean');
thrsld = 0.7;
[B,I] = sort(Dist,2);
nrst_neighbor = B(:,1);
nrst_neighbor2 = B(:,2);
confidences = nrst_neighbor ./ nrst_neighbor2;
index = find(confidences < thrsld);
s = size(index);
matches = zeros(s(1),2);
matches(:,1) = index; 
matches(:,2) = I(index);
confidences = 1./confidences(index);
[confidences, ind] = sort(confidences, 'descend');
matches = matches(ind,:);
end