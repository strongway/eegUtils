% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/frequency_analysis.R
\name{remove_edges}
\alias{remove_edges}
\title{Remove convolution edges}
\usage{
remove_edges(sigtime, sigma_t)
}
\arguments{
\item{sigtime}{timepoints in the signal}

\item{sigma_t}{standard deviations of the morlet wavelets}
}
\description{
Create a matrix indicating which timepoints likely suffer from edge effects.
Returns a time by frequency matrix with NA
}
\keyword{internal}
