# README for Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate the ability to collect, work with,
and clean a data set. The goal is to prepare tidy data that can be used for
later analysis.

This project consists of several files:

- 'README.md' - this file
- 'CodeBook.md' - A code book describing the output datasets, the data 
  transformations that were used to create the output datasets, and
  the source data.
- 'run_analysis.R' - An R script which performs the transformations.
- 'activitydata.txt' - A derived data file described in the CodeBook.
- 'summarydata.txt' - A derived data file described in the CodeBook.

## To re-generate the derived data files:

Execute the following in the top level directory:
```
source("run_analysis.R")
```

License:
========
This dataset is derived from the source dataset described in the CodeBook.
The source dataset has the following license which must be adhered to.


Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L.
Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass
Hardware-Friendly Support Vector Machine. International Workshop of Ambient
Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can
be addressed to the authors or their institutions for its use or misuse. Any
commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
