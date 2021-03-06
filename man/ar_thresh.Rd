% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/artefact_rejection.R
\name{ar_thresh}
\alias{ar_thresh}
\alias{ar_thresh.eeg_data}
\alias{ar_thresh.eeg_epochs}
\title{Simple absolute value thresholding}
\usage{
ar_thresh(data, threshold, reject = FALSE, ...)

\method{ar_thresh}{eeg_data}(data, threshold, reject = FALSE, ...)

\method{ar_thresh}{eeg_epochs}(data, threshold, reject = FALSE, ...)
}
\arguments{
\item{data}{An object of class \code{eeg_data} or \code{eeg_epochs}.}

\item{threshold}{In microvolts. If one value is supplied, it will be treated
as a +- value.}

\item{reject}{If TRUE, remove marked data immediately, otherwise mark for
inspection/rejection. Defaults to FALSE.}

\item{...}{Other arguments passed to eeg_ar_thresh}
}
\description{
Reject data based on a simple absolute threshold. This marks any
timepoint from any electrode.
}
\section{Methods (by class)}{
\itemize{
\item \code{eeg_data}: Reject data using a simple threshold.

\item \code{eeg_epochs}: Reject data using a simple threshold.
}}

\author{
Matt Craddock \email{matt@mattcraddock.com}
}
