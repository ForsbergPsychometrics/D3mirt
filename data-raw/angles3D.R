## code to prepare `angles3D` dataset goes here
a <- matrix(c(1, 0, 0,
              0, 1, 0,
              0, 0, 1,
              .5, .5, .5), ncol = 4)

b <- matrix(c(-1, 0, 0,
              0, -1, 0,
              0, 0, -1,
              .5, .5, .5), ncol = 4)

c <- matrix(c(1/2, sqrt(2)/2, sqrt(3)/2,
              sqrt(3)/2, sqrt(2)/2, 1/2,
              0, 0, 0,
              .5, .5, .5), ncol = 4)

d <- matrix(c(-1/2, -sqrt(2)/2, -sqrt(3)/2,
              sqrt(3)/2, sqrt(2)/2, 1/2,
              0, 0, 0,
              .5, .5, .5), ncol = 4)

e <- matrix(c(0, 0, 0,
              1/2, sqrt(2)/2, sqrt(3)/2,
              sqrt(3)/2, sqrt(2)/2, 1/2,
              .5, .5, .5), ncol = 4)

f <- matrix(c(0, 0, 0,
              1/2, sqrt(2)/2, sqrt(3)/2,
              -sqrt(3)/2, -sqrt(2)/2, -1/2,
              .5, .5, .5), ncol = 4)

g <- matrix(c(1/2, sqrt(2)/2, sqrt(3)/2,
              -sqrt(3)/2, -sqrt(2)/2, -1/2,
              0, 0, 0,
              .5, .5, .5), ncol = 4)

h <- matrix(c(-1/2, -sqrt(2)/2, -sqrt(3)/2,
              -sqrt(3)/2, -sqrt(2)/2, -1/2,
              0, 0, 0,
              .5, .5, .5), ncol = 4)

i <- matrix(c(0, 0, 0,
              -1/2, -sqrt(2)/2, -sqrt(3)/2,
              sqrt(3)/2, sqrt(2)/2, 1/2,
              .5, .5, .5), ncol = 4)


j <- matrix(c(0, 0, 0,
              -1/2, -sqrt(2)/2, -sqrt(3)/2,
              -sqrt(3)/2, -sqrt(2)/2, -1/2,
              .5, .5, .5), ncol = 4)

k <- matrix(c(sqrt(1/3), -sqrt(1/3), -sqrt(1/3), sqrt(1/3),
              sqrt(1/3), sqrt(1/3), sqrt(1/3), sqrt(1/3),
              sqrt(1/3), sqrt(1/3), -sqrt(1/3), -sqrt(1/3),
              .5, .5, .5, .5), ncol = 4)

l <- matrix(c(sqrt(1/3), -sqrt(1/3), -sqrt(1/3), sqrt(1/3), #
              -sqrt(1/3), -sqrt(1/3), -sqrt(1/3), -sqrt(1/3),
              sqrt(1/3), sqrt(1/3), -sqrt(1/3), -sqrt(1/3),
              .5, .5, .5, .5), ncol = 4)

m <- matrix(c(sqrt(2)/2, -sqrt(2)/2, -sqrt(2)/2, sqrt(2)/2,
              0, 0, 0, 0,
              sqrt(2)/2, sqrt(2)/2, -sqrt(2)/2, -sqrt(2)/2,
              .5, .5, .5, .5), ncol = 4)

s <- data.frame(Theta = c(0, NaN, 90, 180, NaN, -90, 0, 0,
                          0, 180, 180, 180, 90, 90, 90,
                          -90, -90, -90, 0, 0, 0, 180,
                          180, 180, 90, 90, 90, -90, -90,
                          -90, 45, 135, -135, -45, 45,
                          135, -135, -45, 45, 135, -135, -45),
                 Phi = c(90, 0,  90,  90, 180,  90,  30,  45,
                         60,  30,  45,  60, 60, 45,
                         30, 60, 45, 30, 150, 135, 120,
                         150, 135, 120, 120, 135, 150, 120,
                         135, 150,  54.73561,  54.73561,
                         54.73561,  54.73561, 125.26439,
                         125.26439, 125.26439, 125.26439,
                         90,  90,  90, 90))

z <- rbind(a, b, c, d, e, f, g, h, i, j, k, l, m)
z <- cbind(z, s)

rownames(z) <- c(1:42)
colnames(z) <- c("a1", "a2", "a3", "d", "Theta", "Phi")
angles3D <- z

usethis::use_data(angles3D, overwrite = TRUE)
