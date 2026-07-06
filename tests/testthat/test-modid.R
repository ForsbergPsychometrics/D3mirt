test_that("Test unit modid", {
  data("angles3D")
  id <- rbind(angles3D[1,1:3], angles3D[8, 1:3], angles3D[9, 1:3], angles3D[13,1:3])
  x <- modid(id, efa= FALSE)
  testthat::expect_snapshot(x)
  testthat::expect_snapshot(print(x))
  testthat::expect_snapshot(summary(x))
})
