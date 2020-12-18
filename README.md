---
output: pdf_document
---


# Data:  Australian Collaborative Land Use and Management Program (ACLUMP)

`dataACLUMP` is an R package that when installed, 
downloads the data from the
 [ACLUMP website](https://www.agriculture.gov.au/abares/aclump/land-use/catchment-scale-land-use-of-australia-update-december-2018) and stores in the form of a data package.


## Installation
To install  the package, execute:

```r
devtools::install_github("DanielBonnery/dataACLUMP")
```

Note that installation is slow, because part of the installation process is downloading and converting big data files.

## Documentation
To see the list of datasets, execute:

```r
data(package="dataACLUMP")
```


To see the documentation for one particular dataset, execute:

```r
help("shapefile_currency_clum_50m1218m",package="dataACLUMP")
```

## How was the data pulled ?
The data is the direct download of zipped shapefiles, converted to sp and objects by applying [rgdal::readOGR] .

To pull the data again, execute:

```r
alldata<-dataACLUMP::get_data_from_web()
```

## How to use the data ?
To see an example of data use, execute:


```r
demo(simpledemo,package = "dataACLUMP")
```


![map from ACLUMP](figs/map.png)
