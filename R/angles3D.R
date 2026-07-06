#' Standard Angles 3D Data Frame
#'
#' A test unit data frame consisting of 42 rows and 6 columns with standard angles in Cartesian coordinates as item loadings (columns denoted `a1`, `a2`, and `a3`) oriented in both positive and negative directions in a three-dimensional space.
#' The distance from the origin is set by `d = 0,5` (4th column) on all rows, which refers to the parameter related to difficulty in the compensatory model.
#' The last two columns contain the angles converted to spherical coordinates with `Theta` representing the polar angle and `Phi` representing the azimuthal angle.
#' Running the data frame in `D3mirt()` converts the angles into spherical coordinates and can be used to check functionality in the package.
#' Note, `Nan`, i.e., "not-a-number", appears in the `D3mirt()` output because the \eqn{\arctan} function (used when changing to spherical coordinates) is not defined when cosine equals zero.
#'
#'
#' @examples data(angles3D)
"angles3D"
