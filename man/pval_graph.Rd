% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pval_graph.R
\name{pval_graph}
\alias{pval_graph}
\title{does survival analysis}
\usage{
pval_graph(input_folder, output_folder)
}
\arguments{
\item{input_folder}{location of survival files}

\item{output_folder}{the output folder}
}
\description{
Reads file with features(PC's) in columns and samples in rows. And an annotation file.You pick a max # of features. Using caret
runs a prediction iteratively from 2 to max.features. Picks best predictor with least featurs. Returns samples correctly predicted
leaves out those samples incorrectly predicted.
}
