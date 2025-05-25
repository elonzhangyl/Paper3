X = [1 1;-1 -1];
X=[-1 -1 0 2 0;-2 0 0 1 1]';
[coeff,score,latent] = pca(X,'NumComponents',2)
X*coeff

eigenvector = [1 -1;1 1];
X*eigenvector