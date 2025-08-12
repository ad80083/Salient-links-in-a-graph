% Copyright (C) 2022 by Ajay Kumar, Cranfield University
% All rights reserved.
% This code is adaptation of the method proposed by Grady et al in the
% following research paper.
% References: Grady, Daniel, Christian Thiemann, and Dirk Brockmann.
%            "Robust classification of salient links in complex networks."
%            Nature communications 3 (2012): 864.
function [G,GS] = salLink(mat)
% mat: Weighted adjacency matrix
n=size(mat,2);
matInv=mat.^(-1);% 1/weight
%Symmetrize mat
matSym = max(matInv,transpose(matInv));
G=graph(matSym,'omitselfloops');
P=cell(n,1);%cells for storing graph
D =cell(n,1);%cells for storing distance
E=cell(n,1);%cells for storing edges
for i=1:n
    [P{i},D{i},E{i}]= shortestpathtree(G,i,'all');%Computing Shortest Path Tree(SPT)    
end
S=zeros(n);
N=numnodes(G);% No of nodes in the parent graph
for i=1:n
    S = S+full(adjacency(P{i}));% accumulating all SPTs
end
S = 1.*(S/N);
Sal_Link = max(S,transpose(S));
GS=graph(Sal_Link);