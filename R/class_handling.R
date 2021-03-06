#' Function to create an S3 object of class "eeg_data".
#'
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @param data Raw data - signals from electrodes/channels.
#' @param srate Sampling rate in Hz.
#' @param chan_info String of character names for electrodes.
#' @param timings Timing information - samples and sample /sampling rate.
#' @param continuous Whether the data is continuous or epoched. (Deprecated.)
#' @param reference Reference channel information, including names of reference
#'   channels, excluded channels etc.
#' @param events Event table
#' @param epochs Information about the epochs contained in the data.
#' @keywords internal

eeg_data <- function(data,
                     srate,
                     events = NULL,
                     chan_info = NULL,
                     timings = NULL,
                     continuous,
                     reference = NULL,
                     epochs = NULL) {

  if (!missing(continuous)) {
    message("Continuous parameter is deprecated and ignored.")
  }

  if (srate < 1) {
    stop("Sampling rate must be above 0")
  }
  value <- list(signals = data,
                srate = srate,
                events = events,
                chan_info = chan_info,
                timings = timings,
                reference = reference,
                epochs = epochs)
  class(value) <- "eeg_data"
  value
}


#' Check eeg_data structure
#'
#' Check for missing fields and add them if necessary.
#'
#' @keywords internal
validate_eeg_data <- function(.data) {

  nrow_sig <- nrow(.data$signals)
  nrow_time <- nrow(.data$timings)

  if (!identical(nrow_sig, nrow_time)) {
    stop("nrow for signals and time must be identical",
         call. = FALSE)
  }

  if (exists(.data$signals)) {
    check_numeric <- apply(.data$signals,
                           2,
                           is.numeric)
    if (!all(check_numeric)) {
      warning(paste("Non-numeric channels: ",
                    channel_names(.data)[!check_numeric]))
    }
  }

  if (!exists(.data$reference)) {
    .data$reference <- append(.data,
                              list(reference = NULL))
  }

  if (!is.null(.data$epochs)) {
    .data$epochs <-
      tibble::new_tibble(list(epoch = 1,
                              participant_id = character(1),
                              recording = character(1)),
                         nrow = 1,
                         class = "epoch_info")
  }

  class(.data) <- "eeg_data"
  .data
}

#' Object creator for eeg_tfr objects.
#'
#' @param data TFR transformed data
#' @param srate Sampling rate in Hz.
#' @param events Event tables
#' @param chan_info Standard channel information.
#' @param reference Reference information
#' @param timings Timing information.
#' @param freq_info Frequencies and other useful information
#' @param dimensions List of which dimension is which
#' @param epochs Epoch information
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @keywords internal
eeg_tfr <- function(data,
                    srate,
                    events,
                    chan_info = NULL,
                    reference,
                    timings = NULL,
                    freq_info,
                    dimensions,
                    epochs = NULL) {

  value <- list(signals = data,
                srate = srate,
                events = events,
                chan_info = chan_info,
                reference = reference,
                timings = timings,
                freq_info = freq_info,
                dimensions = dimensions,
                epochs = epochs)
  class(value) <- "eeg_tfr"
  value
}

#' Function to create an object of class eeg_psd
#'
#' @param data PSD transformed data
#' @param srate Sampling rate in Hz.
#' @param chan_info String of character names for electrodes.
#' @param timings Timing information - samples and sample /samplirng rate.
#' @param freqs vector of frequencies
#' @param dimensions List of which dimension is which
#' @param epochs Epoch information
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @keywords internal
eeg_psd <- function(data,
                    srate,
                    events,
                    chan_info = NULL,
                    timings = NULL,
                    freqs,
                    dimensions,
                    epochs) {

  value <- list(signals = data,
                srate = srate,
                chan_info = chan_info,
                timings = timings,
                freqs = freqs
                )
  class(value) <- "eeg_psd"
  value
}


#' Function to create an object of class \code{eeg_GA}
#'
#' @noRd

eeg_GA <- function(data,
                   srate,
                   chan_info,
                   timings,
                   indivs) {

  value <- list(signals = data,
                srate = srate,
                chan_info = chan_info,
                timings = timings,
                indivs = indivs)
  class(value) <- "eeg_GA"
  value
}


#' Function to create an S3 object of class "eeg_epochs".
#'
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @param data Raw data - signals from electrodes/channels.
#' @param srate Sampling rate in Hz.
#' @param chan_info String of character names for electrodes.
#' @param timings Timing information - samples and sample /sampling rate.
#' @param reference Reference channel information, including names of reference
#'   channels, excluded channels etc.
#' @param events Event table
#' @param epochs Information about the epochs contained in the data.
#' @export

eeg_epochs <- function(data,
                       srate,
                       events = NULL,
                       chan_info = NULL,
                       timings = NULL,
                       reference = NULL,
                       epochs = NULL) {
  if (srate < 1) {
    stop("Sampling rate must be above 0")
  }
  value <- list(signals = data,
                srate = srate,
                events = events,
                chan_info = chan_info,
                timings = timings,
                reference = reference,
                epochs = epochs)
  class(value) <- c("eeg_epochs", "eeg_data")
  value
}

validate_eeg_epochs <- function(.data) {

  nrow_sig <- nrow(.data$signals)
  nrow_time <- nrow(.data$timings)

  if (!identical(nrow_sig, nrow_time)) {
    stop("nrow for signals and time must be identical",
         call. = FALSE)
  }

  if (exists("signals", .data)) {
    check_numeric <- apply(.data$signals,
                           2,
                           is.numeric)
    if (!all(check_numeric)) {
      warning(paste("Non-numeric channels: ",
                    channel_names(.data)[!check_numeric]))
    }
  }

  if (!exists("reference", .data)) {
    .data$reference <- append(.data,
                              list(reference = NULL))
  }

  if (is.null(.data$epochs)) {
    epochs <- unique(.data$events$epoch)
    .data$epochs <- tibble::new_tibble(list(epoch = 1,
                                            participant_id = character(),
                                            recording = character(),
                                            epoch_label = character()),
                                       nrow = 1,
                                       class = "epoch_info")
  }

  class(.data) <- c("eeg_epochs",
                    "eeg_data")
  .data
}

update_eeg_epochs <- function(.data) {

  validate_eeg_epochs(.data)

}


#' Function to create an S3 object of class "eeg_evoked"
#'
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @param data evoked data
#' @param chan_info Electrode locations etc
#' @param timings vector of timepoints
#' @param ... Other parameters
#' @keywords internal

eeg_evoked <- function(data,
                       chan_info,
                       timings,
                       srate,
                       epochs,
                       ...) {
  value <- list(signals = data,
                chan_info = chan_info,
                timings = timings,
                srate = srate,
                epochs = epochs)
  class(value) <- c("eeg_evoked")
  value
}

#' Function to create an S3 object of class "eeg_stats".
#'
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @param statistic Calculated statistic (e.g. t-statistic)
#' @param pvals calculated p-values for that statistic
#' @param chan_info String of character names for electrodes.
#' @param timings Unique timepoints remaining in the data.
#' @keywords internal

eeg_stats <- function(statistic,
                      chan_info,
                      pvals,
                      timings) {

  value <- list(statistic = statistic,
                pvals = pvals,
                chan_info = chan_info,
                timings = timings)
  class(value) <- "eeg_stats"
  value
}


#' Function to create an S3 object of class "eeg_ICA".
#'
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @param mixing_matrix ICA mixing matrix
#' @param unmixing_matrix ICA unmixing matrix
#' @param signals ICA components
#' @param timings Unique timepoints remaining in the data.
#' @param events event table
#' @param chan_info String of character names for electrodes.
#' @param srate Sampling rate
#' @param epochs Epoch information
#' @keywords internal
eeg_ICA <- function(mixing_matrix,
                    unmixing_matrix,
                    signals,
                    timings,
                    events,
                    chan_info,
                    srate,
                    epochs) {

  value <- list(mixing_matrix = mixing_matrix,
                unmixing_matrix = unmixing_matrix,
                signals = signals,
                timings = timings,
                events = events,
                chan_info = chan_info,
                srate = srate,
                epochs = epochs)
  class(value) <- c("eeg_ICA", "eeg_epochs")
  value
}

set_type <- function(x, label) attr(x, "type") <- label

#' Check if object is of class "eeg_data".
#'
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @param x Object to check.
#' @keywords internal

is.eeg_data <- function(x) inherits(x, "eeg_data")

#' Check if object is of class "eeg_epochs".
#'
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @param x Object to check.
#' @keywords internal

is.eeg_epochs <- function(x) inherits(x, "eeg_epochs")

#' Check if object is of class \code{eeg_evoked}
#'
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @param x Object to check.
#' @keywords internal
is.eeg_evoked <- function(x) inherits(x, "eeg_evoked")

#' Check if object is of class \code{eeg_stats}
#'
#' @param x Object to check.
#' @keywords internal
is.eeg_stats <- function(x) inherits(x, "eeg_stats")

#' Check if object is of class \code{eeg_ICA}
#'
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @param x Object to check.
#' @keywords internal

is.eeg_ICA <- function(x) inherits(x, "eeg_ICA")

#' Check if object is of class eeg_tfr
#'
#' @author Matt Craddock \email{matt@@mattcraddock.com}
#' @param x Object to check.
#' @keywords internal
is.eeg_tfr <- function(x) inherits(x, "eeg_tfr")
