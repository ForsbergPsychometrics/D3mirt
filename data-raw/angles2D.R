## code to prepare `angles2D` dataset goes here
a <- matrix(c(
  1, 0,                          # 0°
  sqrt(3)/2, 1/2,                # 30°
  sqrt(2)/2, sqrt(2)/2,          # 45°
  1/2, sqrt(3)/2,                # 60°
  0, 1,                          # 90°
  -1/2, sqrt(3)/2,               # 120°
  -sqrt(2)/2, sqrt(2)/2,         # 135°
  -sqrt(3)/2, 1/2,               # 150°
  -1, 0,                         # 180°
  -sqrt(3)/2, -1/2,              # 210°
  -sqrt(2)/2, -sqrt(2)/2,        # 225°
  -1/2, -sqrt(3)/2,              # 240°
  0, -1,                         # 270°
  1/2, -sqrt(3)/2,               # 300°
  sqrt(2)/2, -sqrt(2)/2,         # 315°
  sqrt(3)/2, -1/2                # 330°
), ncol = 2, byrow = TRUE)

# Verification
rowSums(a^2)

a <- cbind(a, rep(0.5, 16))
s <- data.frame(Theta = c(0, 30, 45, 60, 90, 120, 135, 150, 180,
                          -150, -135, -120, -90, -60, -45, -30))
z <- cbind(a, s)

rownames(z) <- c(1:16)
colnames(z) <- c("a1", "a2", "d", "Theta")
angles2D <- z
usethis::use_data(angles2D, overwrite = TRUE)
