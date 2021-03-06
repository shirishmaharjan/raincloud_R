# LIBRARIES ----

library(ggdist)
library(tidyquant)
library(tidyverse)

# DATA -----

mpg

# RAINCLOUD PLOTS ----
# - Very powerful for visualizing modality of distributions

mpg %>%
    filter(cyl %in% c(4,6,8)) %>%
    ggplot(aes(x = factor(cyl), y = hwy, fill = factor(cyl))) +

    # add half-violin from {ggdist} package
    ggdist::stat_halfeye(
        ## custom bandwidth
        adjust = 0.5,
        ## move geom to the right
        justification = -.2,
        ## remove slab interval
        .width = 0,
        point_colour = NA
    ) +
    geom_boxplot(
        width = .12,
        ## remove outliers
        outlier.color = NA,
        alpha = 0.5
    ) +
    # Add dot plots from {ggdist} package
    ggdist::stat_dots(
        ## orientation to the left
        side = "left",
        ## move geom to the left
        justification = 1.1,
        ## adjust grouping (binning) of observations
        binwidth = .25
    ) +
    # Adjust theme
    scale_fill_tq() +
    theme_tq() +
    labs(
        title = "Raincloud Plot",
        subtitle = "Showing the Bi-Modal Distribution of 6 Cylinder Vehicles",
        x = "Engine Size (No. of Cylinders)",
        y = "Highway Fuel Economy (MPG)",
        fill = "Cylinders"
    ) +
    coord_flip()

### Coordinate_flip examples

ggplot(diamonds, aes(x=cut, y= price)) + geom_boxplot()

# using coord_flip()

ggplot(diamonds,
       aes(x=cut, y= price,
       fill= cut)) +
    geom_boxplot() +
    coord_flip() +
    theme_bw()

