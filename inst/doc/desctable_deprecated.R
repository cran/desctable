## ---- echo = F, message = F, warning = F--------------------------------------
library(desctable)

options(DT.options = list(#scrollX = T,
                          info = F,
                          search = F,
                          dom = "Brtip",
                          fixedColumns = T))
knitr::opts_chunk$set(message = F, warning = F, screenshot.force = F)

## -----------------------------------------------------------------------------
iris %>%
  desctable()

desctable(mtcars)

## -----------------------------------------------------------------------------
iris %>%
  desctable() %>%
  pander()

mtcars %>%
  desctable() %>%
  datatable()

## -----------------------------------------------------------------------------
# Strictly equivalent to iris %>% desctable() %>% datatable()
iris %>%
  desctable(stats = stats_auto) %>%
  datatable()

## ---- echo = F----------------------------------------------------------------
print(stats_auto)

## -----------------------------------------------------------------------------
mtcars %>%
  desctable(stats = list("N" = length, "Mean" = mean, "SD" = sd)) %>%
  datatable()

## -----------------------------------------------------------------------------
mtlabels <- c(mpg  = "Miles/(US) gallon",
              cyl  = "Number of cylinders",
              disp = "Displacement (cu.in.)",
              hp   = "Gross horsepower",
              drat = "Rear axle ratio",
              wt   = "Weight (1000 lbs)",
              qsec = "¼ mile time",
              vs   = "V/S",
              am   = "Transmission",
              gear = "Number of forward gears",
              carb = "Number of carburetors")

mtcars %>%
  dplyr::mutate(am = factor(am, labels = c("Automatic", "Manual"))) %>%
  desctable(labels = mtlabels) %>%
  datatable()

## -----------------------------------------------------------------------------
iris %>%
  group_by(Species) %>%
  desctable() -> iris_by_Species

iris_by_Species

## -----------------------------------------------------------------------------
str(iris_by_Species)

## -----------------------------------------------------------------------------
# With pander output
mtcars %>%
  group_by(cyl) %>%
  desctable() %>%
  pander()

## -----------------------------------------------------------------------------
# With datatable output
iris %>%
  group_by(Petal.Length > 5) %>%
  desctable() %>%
  datatable()

## ---- message = F, warning = F------------------------------------------------
mtcars %>%
  dplyr::mutate(am = factor(am, labels = c("Automatic", "Manual"))) %>%
  group_by(vs, am, cyl) %>%
  desctable() %>%
  datatable()

## -----------------------------------------------------------------------------
# Strictly equivalent to iris %>% group_by(Species) %>% desctable() %>% datatable()
iris %>%
  group_by(Species) %>%
  desctable(tests = tests_auto) %>%
  datatable()

## ---- echo = F----------------------------------------------------------------
print(tests_auto)

## -----------------------------------------------------------------------------
iris %>%
  group_by(Petal.Length > 5) %>%
  desctable(tests = list(.auto   = tests_auto,
                         Species = ~chisq.test)) %>%
  datatable()

## -----------------------------------------------------------------------------
mtcars %>%
  dplyr::mutate(am = factor(am, labels = c("Automatic", "Manual"))) %>%
  group_by(am) %>%
  desctable(tests = list(.default = ~wilcox.test,
                         mpg      = ~t.test)) %>%
  datatable()

## -----------------------------------------------------------------------------
iris %>%
  group_by(Petal.Length > 5) %>%
  desctable(tests = list(.auto = tests_auto,
                         Petal.Width = ~oneway.test(., var.equal = T)))

