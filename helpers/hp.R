#!/usr/bin/env Rscript
# Written by Luis Felipe Montemayor, sometime around March of 2026
#!/usr/bin/env Rscript
# Modified by Luis Felipe Montemayor & Gemini, March 2026
library(viridisLite)

args <- commandArgs(trailingOnly = TRUE)

if (length(args) > 0) {
    input_source <- args[1]

} else {
    if (isatty(stdin())) {
        stop("Error: No file provided and no data piped via stdin.")
    }
    input_source <- file("stdin")
}

raw_data <- read.csv(input_source, row.names = 1, check.names = FALSE)
d <- data.matrix(raw_data)

X11()
layout(t(1:2), widths = c(4, 1))
par(mar = c(1, 1, 1, 1))

image(t(d)[, rev(seq_len(nrow(d)))], col = viridis(100), axes = F)

par(mar = c(5, 1, 5, 3))
scale_range <- range(d, na.rm = TRUE)
seq_s <- seq(scale_range[1], scale_range[2], len = 100)

image(y = seq_s, z = matrix(seq_s, 1), col = viridis(100), axes = F, ann = F)
axis(4, las = 2)

while(names(dev.cur()) != "null device") Sys.sleep(0.5)
