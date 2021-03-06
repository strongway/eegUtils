% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/glm_fitting.R
\name{fit_glm}
\alias{fit_glm}
\title{Fit a GLM model to each timepoint for an individual subject.}
\usage{
fit_glm(formula, .data, ...)
}
\arguments{
\item{formula}{A regression formula for a GLM. See ?formula}

\item{.data}{An \code{eegUtils} object.}

\item{...}{Any other arguments passed to (LM/GLM)}
}
\description{
Fits a linear model to each timepoint using lm().
}
\author{
Matt Craddock, \email{matt@mattcraddock.com}
}
