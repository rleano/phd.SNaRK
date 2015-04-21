# Calculate centrality script
# author: Rafael Leano
# last-update: Apr 21, 2015

args <- commandArgs(T)

if("--help" %in% args | length(args) != 3L ){
    cat("
Usage:
    centrality.r <workdir> <infile> <outfile>
    (order must be kept)
        ")
    q()
}

dir <- args[1]
infile <- args[2]
outfile <- args[3]

setwd(dir)

contents <- read.csv(infile, header=T)
m <- as.matrix(contents)
rownames(m) <- colnames(m) <- colnames(contents)

try(install.packages('igraph', repos="http://cran.fhcrc.org"))
library(igraph)
g <- graph.adjacency(m)
evcent <- evcent(g)$vector

write(evcent, outfile, sep="\n")

cat(paste("Success! wrote file [", outfile, "]", sep=""))
