test_that("Test unit modid", {
  data("angles")
  id <- rbind(angles[1,1:3], angles[8, 1:3], angles[9, 1:3], angles[13,1:3])
  x <- modid(id, efa= FALSE)
  testthat::expect_snapshot(x)
  testthat::expect_snapshot(print(x))
  testthat::expect_snapshot(summary(x))
})
