if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("flowCore")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("CATALYST")

library(readxl)
library(SingleCellExperiment)
library(diffcyt)
library(HDCytoData)
library(DT)
library(ggplot2)
library(cowplot)
library(flowCore)
library(scater)
library(CATALYST)
library(uwot)




###### Input data: not activated samples
### Patients metadata excel import 
setwd("C:/Users/Kili/Desktop/new CRP data/")
md <- read_excel("meta_diffactivators.xlsx")
DT::datatable(data.frame(md))

### Markers panel excel import
#Activation markers are indicated as "state", the rest - "type". This is a very important stratification as usually lineage markers (type) are used for clustering while functional markers (state) are used for the differential expression analysis. In the furter analysis we use CD63, CD107a, PAC1 and CD62P as state markers.
panel <- read_excel("panel_umap.xlsx")
datatable(data.frame(panel))


### .fcs files df import
files <- list.files(path = "C:/Users/Kili/Desktop/new CRP data/original FCS/baseline", pattern = "\\.fcs$", full.names = TRUE)

fs <- read.flowSet(files, transformation = FALSE, truncate_max_range = FALSE)
fs = fs[,panel$fcs_colname]

### Saving the data for further analysis in Python
outDir = "C:/Users/Kili/Desktop/new CRP data/FCS after R protocol/baseline"
for (i in 1:length(fs)){
  write.flowSet(fs[i], outDir)
}




## Activated samples
md <- read_excel("meta_diffactivators_activated.xlsx")
DT::datatable(data.frame(md))

### Markers panel
#Activation markers are indicated as "state", the rest - "type". This is a very important stratification as usually lineage markers (type) are used for clustering while functional markers (state) are used for the differential expression analysis. In the furter analysis we use CD63, CD107a, PAC1 and CD62P as state markers and the rest as type markers.
panel <- read_excel("panel_umap.xlsx")
datatable(data.frame(panel))

### .fcs files
files <- list.files(path = "C:/Users/Kili/Desktop/new CRP data/original FCS/activated/", pattern = "\\.fcs$", full.names = TRUE)
fs <- read.flowSet(files, transformation = FALSE, truncate_max_range = FALSE)
fs = fs[,panel$fcs_colname]


#Saving the data for further analysis in Python
outDir = "C:/Users/Kili/Desktop/new CRP data/FCS after R protocol/activated"
for (i in 1:length(fs)){
  write.flowSet(fs[i], outDir)}


