#' Standard Angles 2D Data Frame
#'
#' A test unit data frame consisting of 42 rows and 4 columns with standard angles in Cartesian coordinates as item loadings (columns denoted `a1` and `a2`) oriented in both positive and negative directions in a two-dimensional space.
#' The distance from the origin is set by `d = 0,5` (3rd column) on all rows, which refers to the parameter related to difficulty in the compensatory model.
#' The last two columns contain the angles converted to polar coordinates with `Theta` representing the polar angle.
#' Running the data frame in `D2mirt()` converts the angles into polar coordinates and can be used to check functionality in the package.
#'
#'
#' @examples data(angles2D)
"angles2D"
