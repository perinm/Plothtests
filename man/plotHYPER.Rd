% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/funcao_plotUD.R
\name{plotHYPER}
\alias{plotHYPER}
\title{Plot of Hypergeometric Distribution}
\usage{
plotHYPER(N, K, n, hlt = FALSE, i = 2, f = 4)
}
\arguments{
\item{N}{a set of N objects}

\item{K}{objects classified as successes}

\item{n}{a sample size of objects selected randomly (without replacement) from the set of N objects where `K <= N` and `n <= N`}

\item{hlt}{logical (default is FALSE); if TRUE, probabilities P[i ≤ X ≤ f] are highlighted in green color in the plot}

\item{i, f}{highlight probability from i' initial value of distribution to 'f' final value of distribution}
}
\description{
X is the random variable that is equal the number of successes in the sample selected randomly (without replacement).
}
\examples{
plotHYPER(N = 10,K = 5,n = 5, hlt = TRUE, i = 2, f = 4)
}
