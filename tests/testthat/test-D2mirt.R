test_that("Test unit D2mirt and plot", {
  data("angles2D")
  x <- D2mirt(angles2D[,1:3],
              con.items = list(c(2:4), c(6:8), c(10:12),
              c(14:16)))
  testthat::expect_snapshot(x)
  testthat::expect_snapshot(print(x))
  testthat::expect_snapshot(summary(x))
  testthat::expect_snapshot(information(x, digits = 6))
  pol <- data.frame(angles2D[, 4])
  mdisc <- x$mdisc
  mdiff <- x$mdiff
  polar <- x$angles
  for (i in nrow(mdisc)){
    testthat::expect_identical(mdisc[i,1], 1)
  }
  for (i in nrow(mdiff)){
    testthat::expect_equal(mdiff[i,1], -0.5)
  }
  for (i in nrow(polar)){
    testthat::expect_equal(polar[i,1], pol[i,1])
  }
  for (i in nrow(polar)){
    s <- D2mirt(angles2D[1:3], con.items = list(i))
    testthat::expect_equal(s$c.pol[1,1], pol[i,1])
  }
  for (i in nrow(angles2D)){
    s <- D2mirt(angles2D[1:3], con.pol = pol[i,1])
    testthat::expect_equal(s$c.dir.cos[1,1], angles2D[i,1])
  }
  p <- plot(x, title = "Plot Test 1.1")
  testthat::expect_snapshot(p)
  x <- D2mirt(angles2D[,1:3], con.pol = c(45, 120, -150, -60))
  p <- plot(x, constructs = TRUE, item.names = FALSE, c.lab = c(1:4), title = "Plot Test 1.2")
  testthat::expect_snapshot(p)
  testthat::expect_snapshot(x)
  testthat::expect_snapshot(print(x))
  testthat::expect_snapshot(summary(x))
  testthat::expect_snapshot(information(x, CI = 0.90, digits = 6))
})
