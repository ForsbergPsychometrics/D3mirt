#' D3mirt Model Identification
#'
#' @description `modid()` performs model identification for descriptive multidimensional item response theory (DMIRT) models by indicating what items, from a set or scale, to use to identify the DMIRT model.
#'
#' @param x A data frame with item data or item factor loadings that fit the multidimensional graded response model (MGRM) or the multidimensional 2-parameter logistic model (M2PL).
#' @param efa Logical, if the data should be explored with exploratory factor analysis (EFA). The default is `efa = TRUE`.
#' @param factors The number of factors for the exploratory factor analysis. The default is `factors = 3`.
#' @param lower The lower bound for the item pool calculated using the standard deviation of scaled item factor loadings. The default is `lower = 0.5`.
#' @param upper The upper bound for filtering absolute sum scores less than or equal to the indicated value. The default is `upper = .10`
#' @param fac.order Optional. Users can override the automatic sorting of factors by manually indicating factor order with integer values, e.g., `c(2,1,3)` to start with the second factor (or column) in data frame x, followed by the first factor (or column) in x, and then lastly the third factor (or column).
#' The default is `fac.order = NULL`.
#' @param itemtype The item model for the exploratory factor analysis. Note, only item type 'graded' (for the MGRM) or '2PL' (for the M2PL) are allowed. The default is `itemtype = "graded"`. See [mirt::mirt] (Chalmers, 2012) for more on item models.
#' @param method A string indicating what integration algorithm to use for the EFA. The default is `method = 'EM'`. See [mirt::mirt] (Chalmers, 2012) for more on methods.
#' @param rotate A string indicating what rotation method to use for the EFA. The default is `rotate = "oblimin"`. See [mirt::mirt] (Chalmers, 2012) for more on rotations.
#' @param ... Any additional arguments passed to mirt().
#'
#' @importFrom mirt mirt
#'
#' @details Before performing DMIRT analysis, it is necessary to identify the compensatory model (Reckase, 2009).
#' For a three-dimensional model, this implies that two items must be chosen and their loadings restricted as follows.
#' The first item is fixed not to load on the second and third axes (y and z), while the second item is fixed not to load on the third axis (z).
#' If this can be achieved, it is possible to create a three-dimensional DMIRT model that reflects the data correctly.
#'
#' The `modid()` function can help by suggesting what items to use for the latter purpose.
#' The function does this by first performing an EFA on the data and then selecting the strongest loading items, following the order of strength of the factors and following the statistical assumptions described above.
#' This orders the entire model so that the strongest loading item, from the strongest factor, always aligns with the x-axis, and the other items follow thereon.
#' Note that the `modid()` function is not limited to three-dimensional analysis and can be used to identify a DMIRT model on any number of dimensions.
#'
#' Because `D3mirt` analysis is based on the M2PL and the MGRM, it is recommended to use multidimensional item response theory EFA methods, such as the EFA option in [mirt::mirt] (Chalmers, 2012) with `itemtype = 'graded'` or `'2PL'`, so that the EFA is performed with the proper item model.
#' For this reason, the `mirt()` function is integrated into `modid()` so that the user needs only to provide the data frame containing empirical item data in the first argument in the call to the function.
#' Accordingly, in the default mode (`efa = TRUE`), using raw item data, the function performs an EFA with three factors as default (`factors = 3`), and finishes with the model identification.
#'
#' However, it is also possible to use the `modid()` function without performing the EFA by setting `efa = FALSE` if, for instance, a data frame with factor loadings is already available.
#' This allows the function to move directly to the model identification step.
#'
#' Note, the EFA is only used to find model identification items that meet the necessary DMIRT model specification requirements.
#' The EFA model itself is discarded after this step in the procedure and the user can, therefore, try different rotation methods and compare the results.
#'
#' Running the function prints the number of items and factors together with the suggested model identification items to the console and the summary function is used to inspect the full results.
#' The latter includes data frames that hold all the model identification items (`Item.1...Item.n`) selected by `modid()` together with the items absolute sum score (`ABS`), one frame for the sum of squares for factors sorted in descending order, and one frame for item factor loadings.
#' The order of the factors follows the model identification items so that item 1 comes from the strongest factor, item 2 from the second strongest factor, and so on.
#'
#' Model identification items should preferably (a) have an absolute sum score of less than or equal to .10 and (b) have the highest factor loading scores on the factor of interest.
#' Of these two criteria, (a) should be given the strongest weight in the selection decision.
#' If these conditions cannot be met, the user is advised to proceed with caution since the loading scores, therefore, imply that an adequate orthogonal structure may not be empirically attainable.
#' For more details on the model identification process and troubleshooting, please see the package vignette.
#'
#' @return A S3 object of class `modid` with lists of items and absolute sum scores, sorted by the latter, and sum of squared factor loadings and frame with raw factor loadings with columns ordered on explained variance (high to low) or according to user settings.
#' @author Erik Forsberg
#' @references Chalmers, R., P. (2012). mirt: A Multidimensional Item Response Theory Package for the R Environment. \emph{Journal of Statistical Software, 48}(6), 1-29.\cr
#' https://doi.org/10.18637/jss.v048.i06
#' @references Reckase, M. D. (2009). \emph{Multidimensional Item Response Theory}. Springer.
#'
#' @examples
#' \donttest{
#' # Load data
#' data("anes0809offwaves")
#' x <- anes0809offwaves
#' x <- x[,3:22] # Remove columns for age and gender
#'
#' # Identify the DMIRT model using a three-factor EFA
#' id <- modid(x)
#'
#' # Call to summary
#' summary(id)
#'
#' # Call to modid with increased lower and upper bound
#' # Assign loadings to a data frame and set efa to false
#' x <- id$loadings
#' id <- modid(x, efa = FALSE, lower = 1, upper = 1 )
#' summary(id)
#'
#' # Override factor order by reversing columns in the original data frame
#' id <- modid(x, efa = FALSE, fac.order = c(3,2,1))
#' summary(id)
#' }
#' @export
modid <- function(x, efa = TRUE, factors = 3, lower = 0.5, upper = .10, fac.order = NULL, itemtype = "graded", method = "EM", rotate = "oblimin", ...){
  if (efa == TRUE){
  if (!(itemtype %in% c("graded", "2PL"))) stop ("The item model must be of type GRM or 2PL")
  x <- as.matrix(x)
  if(any(!x == round(x))) warning("Set efa to FALSE if the data frame contains factor loadings")
  e <- mirt::mirt(x, model = factors, itemtype = itemtype, method = method, ...)
  f <- mirt::summary(e, rotate = rotate, verbose = FALSE)
  x <- unclass(f$rotF)
  x <- as.matrix(x)
  }
  if (is.null(fac.order)){
    y <- x[,order(colSums(x^2), decreasing = TRUE)]
  } else {
    if(any(!fac.order == round(fac.order))) stop("The factor order must be indicated with integer values")
    if (any(duplicated(fac.order))) stop("The factor order argument has duplicate elements")
    if (!length(fac.order) == ncol(x)) stop("The number of factor indicators and the number of factors do not match")
    if(any(!fac.order <= ncol(x))) stop("The factor argument has at least one factor indicator that is higher than the total number of factors")
    y <- x[, fac.order]
  }
  f <- NULL
  for (i in seq(ncol(y)-1)){
    v <- data.frame(y[,i, drop = FALSE])
    colnames(v) <- paste("Item", i, sep = " ")
    ABS <- data.frame(rowSums(abs(y[, -(1:i), drop = FALSE])))
    colnames(ABS) <- paste("ABS")
    a <- data.frame(cbind(v, ABS))
    a <- a[order(a[, 1], decreasing = TRUE),]
    s <- scale(a[, 1, drop = FALSE], center= TRUE, scale=TRUE)
    s <- subset(s, s >= (s[1, 1] - lower))
    n <- nrow(s)
    b <- a[seq_len(n), ]
    b <- b[(b[, 2]) <= upper, ]
    if (nrow(b) == 0) stop ("The model identification failed, try changing factor rotation method or adjusting lower or upper bound")
    c <- b[order(b[, 2]), ]
    f[[i]] <- c
  }
  if (is.null(fac.order)){
    ss <- sort(colSums(x^2), decreasing = TRUE)
  } else {
    ss <- colSums((x^2)[, fac.order])
  }
  modid <- list(id = f, ss.loadings = ss, loadings = y)
  class(modid) <- "modid"
  modid
}
