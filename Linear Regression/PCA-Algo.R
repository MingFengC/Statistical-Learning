##############################################
#
#                  PCA-Seq                   #
#
##############################################

#' Find the leading principal component of a data matrix
#' @param X data matrix, in n-by-p dimensions
#' @return return the leading principal component
find.leading.eigenvector = function(X)
{
    n = nrow(X)
    Sigma = cov(X) * (n-1) / n
    return( eigen(Sigma)$vectors[,1] )
}

#' PCA via a sequential optimization
#' @param X data matrix, in n-by-p dimensions
#' @param k the number of leading principal components to be computed
#' @return return the first k leading principal components and scores
pca.seq = function(X,k)
{
    n = nrow(X)
    p = ncol(X)
    
    # Step 0
    r0 = scale(X, center=T, scale=F)
    Phi = matrix(NA,p,k)
    Zeta = matrix(NA,n,k)
    
    # Step 1...k
    rj = r0
    for(j in 1:k)
    {
        Phi[,j] = find.leading.eigenvector(rj)
        Zeta[,j] = r0 %*% Phi[,j]
        rj = rj - Zeta[,j,drop=F] %*% t(Phi[,j,drop=F])
    }
    
    return( list(Phi=Phi,Zeta=Zeta) )
}



##############################################
#
#                PCA-Eigen                   #
#
##############################################

#' PCA via eigen-decomposion
#' @param X data matrix, in n-by-p dimensions
#' @return return all principal components and scores
pca.eigen = function(X)
{
    
    n = nrow(X)
    q = min(dim(X))
    
    # Step 1
    Sigma = cov(X) * (n-1) / n
    
    # Step 2
    Phi = eigen(Sigma)$vectors
    
    # Step 3
    Zeta = scale(X, center=T, scale=F) %*% Phi[,1:q]
    
    return( list(Phi=Phi,Zeta=Zeta) )
}


##############################################
#
#                PCA-SVD                     #
#
##############################################

#' PCA via SVD
#' @param X data matrix, in n-by-p dimensions
#' @return return all principal components and scores
pca.svd = function(X)
{
    # SVD on centered predictors
    S = svd(scale(X,center=T,scale=F))
    
    # principal components
    Phi = S$v
    
    # scores
    q = min(dim(X))
    Zeta = S$u[,1:q] * matrix(S$d,nrow(X),q,byrow=T)   #scale(X, center=T, scale=F) %*% Phi
    
    return( list(Phi=Phi,Zeta=Zeta) )
}



##############################################
#
#          Numeric Validation                #
#
##############################################

n = 20
p = 30

X = matrix(rnorm(n*p),n,p)

# sequential method
pca.seq(X,p)

# eigen-decomposition method
pca.eigen(X)

# SVD method
pca.svd(X)

