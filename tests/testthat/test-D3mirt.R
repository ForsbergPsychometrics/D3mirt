test_that("Test unit D3mirt and plot", {
  data("angles")
  x <- D3mirt(angles[,1:4])
  testthat::expect_snapshot(x)
  testthat::expect_snapshot(print(x))
  testthat::expect_snapshot(summary(x))
  sph <- angles[5:6]
  mdisc <- x$mdisc
  mdiff <- x$mdiff
  spherical <- x$spherical
  id <- rbind(angles[1,1:3], angles[8, 1:3], angles[9, 1:3], angles[13,1:3])
  for (i in nrow(mdisc)){
    testthat::expect_identical(mdisc[i,1], 1)
  }
  for (i in nrow(mdiff)){
    testthat::expect_identical(mdiff[i,1], -0.5)
  }
  for (i in nrow(spherical)){
    testthat::expect_identical(spherical[i,1], sph[i,1])
    testthat::expect_identical(spherical[i,2], sph[i,2])
  }
  for (i in nrow(spherical)){
    s <- D3mirt(angles[1:4], con.items = list(i))
    testthat::expect_identical(s$c.spherical[1,1], sph[i,1])
    testthat::expect_identical(s$c.spherical[1,2], sph[i,2])
  }
  for (i in nrow(angles)){
    s <- D3mirt(angles[1:4], con.sphe = list(c(sph[i,1], sph[i,2])))
    testthat::expect_equal(s$c.dir.cos[1,1], angles[i,1])
    testthat::expect_equal(s$c.dir.cos[1,2], angles[i,2])
    testthat::expect_equal(s$c.dir.cos[1,3], angles[i,3])
  }
  p <- plot(x, title = "Plot Test 1.1")
  testthat::expect_snapshot(p)
  x <- D3mirt(angles[,1:4], con.sphe = con <- list(c(0, 45), c(45, 90), c(90, 45)))
  p <- plot(x, constructs = TRUE, item.names = FALSE, construct.lab = c("Con 1", "Con 2", "Con3"), title = "Plot Test 1.2")
  testthat::expect_snapshot(p)
  testthat::expect_snapshot(p)
  testthat::expect_snapshot(print(p))
  testthat::expect_snapshot(summary(p))
})
