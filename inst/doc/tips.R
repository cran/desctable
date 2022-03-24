## ---- echo = F, message = F, warning = F--------------------------------------
library(desctable)

## -----------------------------------------------------------------------------
labels <- c(mpg   = "Miles/(US) gallon",
            cyl   = "Number of cylinders",
            disp  = "Displacement (cu.in.)",
            hp    = "Gross horsepower",
            drat  = "Rear axle ratio",
            wt    = "Weight (1000 lbs)",
            qsec  = "1/4 mile time",
            vs    = "Engine",
            am    = "Transmission",
            gear  = "Number of forward gears",
            CARBURATOR = "Number of carburetors")

mtcars %>%
  desc_table(.labels = labels) %>%
  desc_output("DT")

## ---- eval = F----------------------------------------------------------------
#  stats_auto <- function(data) {
#    data %>%
#      lapply(is.numeric) %>%
#      unlist() %>%
#      any -> numeric
#  
#    data %>%
#      lapply(is.factor) %>%
#      unlist() %>%
#      any() -> fact
#  
#    stats <- list("Min"  = min,
#                  "Q1"   = ~quantile(., .25),
#                  "Med"  = stats::median,
#                  "Mean" = mean,
#                  "Q3"   = ~quantile(., .75),
#                  "Max"  = max,
#                  "sd"   = stats::sd,
#                  "IQR"  = IQR)
#  
#    if (fact & numeric)
#      c(list("N" = length,
#             "%" = percent),
#        stats)
#    else if (fact & !numeric)
#      list("N" = length,
#           "%" = percent)
#    else if (!fact & numeric)
#      stats
#  }

## -----------------------------------------------------------------------------
stats = list(N = length,
             Mean = mean,
             SD = sd)

mtcars %>%
  desc_table(!!!stats) %>%
  desc_output("DT")


## -----------------------------------------------------------------------------
stats2 = list(N = length,
              mean,
              sd)

mtcars %>%
  desc_table(!!!stats2) %>%
  desc_output("DT")


## -----------------------------------------------------------------------------
default_stats <- function(data)
{
  list(N = length,
       mean,
       sd)
}

## ---- eval = F----------------------------------------------------------------
#  tests_auto <- function(var, grp) {
#    grp <- factor(grp)
#  
#    if (nlevels(grp) < 2)
#      ~no.test
#    else if (is.factor(var)) {
#      if (tryCatch(is.numeric(fisher.test(var ~ grp)$p.value), error = function(e) F))
#        ~fisher.test
#      else
#        ~chisq.test
#    } else if (nlevels(grp) == 2)
#      ~wilcox.test
#    else
#      ~kruskal.test
#  }

## -----------------------------------------------------------------------------
mtcars %>%
  group_by(am) %>%
  desc_table(mean, sd) %>%
  desc_tests(.default = ~t.test) %>%
  desc_output("DT")

## ---- warning = F-------------------------------------------------------------
mtcars %>%
  group_by(am) %>%
  desc_table(mean, sd, median, IQR) %>%
  desc_tests(.default = ~t.test, carb = ~wilcox.test) %>%
  desc_output("DT")

## -----------------------------------------------------------------------------
iris %>%
  group_by(Species) %>%
  desc_table(mean, sd) %>%
  desc_tests() %>%
  desc_output("DT", digits = 10)

## -----------------------------------------------------------------------------
iris %>%
  group_by(Species) %>%
  desc_table(mean, sd) %>%
  desc_output("DT", filter = "top")

