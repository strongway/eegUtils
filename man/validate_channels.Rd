% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/channel_management.R
\name{validate_channels}
\alias{validate_channels}
\title{Chan_info checker}
\usage{
validate_channels(chan_info, sig_names = NULL)
}
\arguments{
\item{chan_info}{A channel info structure}

\item{sig_names}{signal names from eegUtils signals}
}
\description{
Performs several checks on the structure of channel info: 1) Checks that
"electrode" is character, not factor. 2) rounds any numeric values to 2
decimal places. 3) Checks for any missing channels in the chan_info if signal names are supplied; populates
them with NA if it finds any
}
\keyword{internal}
