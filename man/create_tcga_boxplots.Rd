% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_tcga_boxplots.R
\name{create_tcga_boxplots}
\alias{create_tcga_boxplots}
\title{create tcga boxplots}
\usage{
create_tcga_boxplots(dir, pattern, output_string, output_folder = "./")
}
\arguments{
\item{dir}{directory where PLSR predictions are}

\item{pattern}{pattern to grep for in files that have predictions}

\item{output_folder}{the folder to output to, default is ./ i.e. current folder}

\item{train_string}{string that has information on the training set, make sure to describe the # of featres}
}
\description{
Creates boxplots from prediction scores from pls or plsda
Makes some boxplots
}
