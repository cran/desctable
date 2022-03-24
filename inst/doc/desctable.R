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
  desc_table()

## -----------------------------------------------------------------------------
mtcars %>%
  desc_table(N = length,
             mean,
             sd)

## -----------------------------------------------------------------------------
iris %>%
  desc_table(N = length,
             "%" = percent,
             Q1 = ~ quantile(., .25),
             Med = median,
             Q3 = ~ quantile(., .75))

## -----------------------------------------------------------------------------
iris %>%
  group_by(Species) %>%
  desc_table()

## -----------------------------------------------------------------------------
mtcars %>%
  group_by(am) %>%
  desc_table() %>%
  desc_output("df")

## -----------------------------------------------------------------------------
mtcars %>%
  group_by(am) %>%
  desc_table() %>%
  desc_output("pander")

## -----------------------------------------------------------------------------
mtcars %>%
  group_by(am) %>%
  desc_table() %>%
  desc_output("DT")

## -----------------------------------------------------------------------------
iris %>%
  group_by(Petal.Length > 5) %>%
  desc_table() %>%
  desc_tests() %>%
  desc_output("DT")

## -----------------------------------------------------------------------------
iris %>%
  group_by(Petal.Length > 5) %>%
  desc_table(mean, sd, median, IQR) %>%
  desc_tests(Sepal.Width = ~t.test) %>%
  desc_output("DT")

## -----------------------------------------------------------------------------
iris %>%
  group_by(Petal.Length > 5) %>%
  desc_table(mean, sd, median, IQR) %>%
  desc_tests(Sepal.Width = ~t.test(., var.equal = T)) %>%
  desc_output("DT")

