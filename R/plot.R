#' Plot Method for Objects of Class `D3mirt` and `D2mirt`
#'
#' @description For graphing of objects of class `D3mirt` or `D2mirt` from the [D3mirt::D3mirt()] or [D3mirt::D2mirt()] function, respectively, using the RGL 3D visualization device system (Adler & Murdoch, 2022).
#' @param x A S3 object of class `D3mirt` or or `D2mirt`.
#' @param console Logical, if RGL object should be printed to console (TRUE) or to external pop-up window. The default is `console = TRUE`.
#' @param scale Logical, if item vector arrow length should visualize the MDISC. If set to FALSE, the vector arrow length will be of one unit length. The default is `scale = TRUE`.
#' @param hide Logical, if items should be plotted. The default is `hide = FALSE`.
#' @param scores Logical, should output plot respondents trait scores. The default is `scores = FALSE`.
#' @param diff.level Optional. Plotting of a single level of difficulty indicated by an integer.
#' @param items Optional. The user can input a list of integers indicating what item vector arrows will be visible while the remaining item vector arrows are hidden.
#' @param item.names Logical, if item labels should be plotted. The default is `item.names = TRUE`.
#' @param item.lab Optional. String vector of item names that will override row names extracted from the data frame. Note that row names are not overwritten.
#' Instead, the string vector in `item.lab` prints item labels on the item vector arrows currently displayed following the order of item vector arrows in the graphical output.
#' For example, when plotting in the default mode (plotting all item vectors) the labels will follow the order of the items in the data frame.
#' If a selection of items is plotted with `items`, e.g., `items = c(24,34,25)`, then the item labels will be displayed following the order of the vector in `items` left to right.
#' In this case, item label 1 will be printed on item 24, item label 2 on item 34, and item label 3 on item 25, and so on.
#' @param constructs Logical, if construct vector arrows should be plotted. The default is `constructs = FALSE`.
#' @param c.lab Optional. String vector of names for constructs, similar to `item.lab`.
#' @param adjust.lab Vector of parameters for the position of the item and construct labels for the `text3d` function.
#' The first value is for horizontal adjustment, and the second is for vertical adjustment. The default is `adjust.lab = c(0.5, -0.8)`.
#' @param dist Distance (+/-) of item vector label from item vector. The default is `dist = 0`.
#' @param c.dist Distance (+/-) of construct vector label from construct vector. The default is `c.dist = 0`.
#' @param x.lab Labels for x-axis, the default is `x.lab = "X"`.
#' @param y.lab Labels for y-axis, the default is `y.lab = "Y"`.
#' @param z.lab Labels for y-axis, the default is `z.lab = "Z"`.
#' @param title The main title for the graphical device, plotted with the `title3d()` function. The default is no title.
#' @param line  Title placement for `title3d()`. The default is `line = -5`.
#' @param font A numeric font number from 1 to 5, the default is `font = 1`. See [rgl::text3d] for more on font options.
#' @param cex A numeric character expansion value to adjust font size, the default is `cex = 0.8`.
#' @param font.col Color of axes, numbers, and fonts. The default is `font.col = "black"`.
#' @param axis.scalar Scalar multiple for adjusting the length of all axes (x, y, z) in the 3D model proportionally. The default is `axis.scalar = 1.1`.
#' @param axis.length Optional. For adjusting the length of the axis manually by entering a numeric or a numeric vector.
#' For instance, c(3,2,4,3,3,2) indicate axis coordinates x = 3, -x = 3, y = 4, -y = 3, z = 3, -z = 2.
#' Note that a symmetric model can be created easily by adding a single numeric in the `axis.length` argument (e.g., `axis.length = 4`) because the function repeats the last value in the vector to cover all axes points.
#' The default is `axis.length = NULL`.
#' @param axis.points Color of axis points for the `points3d()` function. The default is `axis.points = "black"`.
#' @param axis.ticks Logical, if axis ticks from the `axis3d()` function should be plotted. The default is `axis.ticks = TRUE`.
#' @param nticks Number of ticks for `axis3d()`.
#' The function repeats the last numeric value in the vector to cover all axis.
#' The user can, therefore, adjust the number of ticks with one numeric value (e.g., `nticks = 6`) or up to three (e.g., `nticks = c(6,4,8)` corresponding to the for the x, y, and z axes respectively.
#' The default is `nticks = 4`.
#' @param width.rgl.x Width in the x direction for `par3d()`. The default is `width.rgl.x = 1040`.
#' @param width.rgl.y Width in the y direction for `par3d()`. The default is `width.rgl.y = 1040`.
#' @param view Vector with polar coordinates and zoom factor for the `view3d` function. The default is `view = c(15, 20, 0.6)` for objects of class `D3mirt` and `view = c(0, 0, 0.6)` for objects of class `D2mirt`.
#' @param show.plane Logical, if xz-plane should be visible in the graphical device. The default is `show.plane = TRUE`.
#' @param plane.col Color of the plane, the default is `plane.col = "grey80"`.
#' @param background Set background color for the graphical device, the default is `background = "white"`.
#' @param type Type of vector arrow for items, the default is `type = "rotation"`. See [rgl::arrow3d] for more options regarding arrow types.
#' @param col Vector of colors representing difficulty levels for item response functions used in `arrow3d()`. The default is `col = c("black", "grey20", "grey40", "grey60", "grey80")`.
#' @param arrow.width Width of vector arrows for `arrow3d()`. The default is `arrow.width = 0.6`.
#' @param n Number of barbs for the vector arrows from `arrow3d()`. The default is `n = 20`.
#' @param theta Opening angle of barbs for vector arrows from `arrow3d()`. The default is `theta = 0.2`.
#' @param barblen The length of the barbs for vector arrows from `arrow3d()`. The default is `barblen = 0.03`.
#' @param c.scalars Set of scalars for adjusting construct arrow length proportionally.
#' The first numeric adjusts the length in the positive direction, and the second numeric the length in the negative direction. The default is `c.scalars = c(1,1)`.
#' @param c.type Type of vector arrow for constructs. See [rgl::arrow3d] for more options regarding arrow types. The default is `c.type = "rotation"`.
#' @param c.col Colors of construct vector arrows from `arrow3d()`, the default is `c.col = c("black", "black", "black", "black", "black")`.
#' @param c.arrow.width Width of construct vector arrows for `arrow3d()`. The default is `c.arrow.width = 0.6`.
#' @param c.n Number of barbs for the construct vector arrows from the `arrow3d()` function. The default is `c.n = 20`.
#' @param c.theta Opening angle of barbs for construct vector arrows from `arrow3d()`. The default is `c.theta = 0.2`.
#' @param c.barblen The length of the barbs for construct vector arrows from `arrow3d()`. The default is `c.barblen = 0.03`.
#' @param profiles Data frame with coordinates for spheres representing a subset of respondent scores. The default is `profiles = NULL`.
#' @param levels Optional. A column with values indicating levels for sphere colors from the `sphere.col` vector. The default is `levels = NULL`.
#' @param spheres.r Radius of the spheres for `spheres3d()`. The default is `spheres.r = 0.05`.
#' @param sphere.col Color vector for `spheres3d()`. The default is `sphere.col = c("black", "grey20", "grey40", "grey60", "grey80")`.
#' @param ci Logical, if spheres should include an ellipsoid outlining a confidence region returned from the `ellipse3d()` function. The default is `ci = FALSE`.
#' @param ci.level Level of confidence for `ellipse3d()`, the default is `ci.level = 0.95`.
#' @param sd For objects of class `D2mirt` only. Standard deviation for the call to rnorm setting the width if the confidence interval in the z-direction. Note that the width is only for visualization when the model is two-dimensional. The default is `sd = 0.15`.
#' @param ellipse.col Color of the ellipse from `ellipse3d()`. The default is `ellipse.col = "grey80"`.
#' @param ellipse.alpha Opacity for the confidence region from `ellipse3d()`. The default is `ellipse.alpha = 0.20`.
#' @param ... Additional arguments passed to RGL or methods.
#'
#' @import rgl
#' @importFrom stats cov rnorm
#'
#' @details The plotting function for objects of class `D3mirt` which allows plotting of all items, a selection of items as well as plotting a single item.
#' Length of the vector arrows can be set to one unit length across all item vector arrows by setting `scale = FALSE`.
#' This removes the visualization of the MDISC parameter.
#' Note that when items are not scaled, the `plot()` function does not change the length of the model axes.
#' This often means that the axes of the model may need to be adjusted, which can be achieved proportionally with `axis.scalar` or manually with `axis.length`.
#'
#' The user has the option of adding constructs to the graphical output with `constructs = TRUE` (see the documentation for [D3mirt::D3mirt] or the package vignette regarding constructs).
#' Other options include plotting one level of difficulty at a time with the `diff.level` argument if polytomous items are used in the model.
#' Item names are displayed by default, but the user has the option of adding new item labels for the items with `item.lab`, as well as labeling constructs with `c.lab`.
#'
#' Regarding the interpretation of results, the angle of the vector arrows indicates what traits, located along the orthogonal axes, an item can be said to describe (Reckase, 2009, 1985, Reckase & McKinley, 1991).
#' For instance, an item located at 0 degrees seen from the x-axis, and 90 degrees as seen from the y and z-axis, only describes trait x.
#' Such an item is unidimensional since its direction vector lies parallel and on the x-axis.
#' In contrast, an item located at 45 degrees between all three axes in a three-dimensional model describes all three traits in the model equally well.
#' Such an item is within-multidimensional with respect to all three latent traits used in the analysis because its direction vector points in a neutral direction in the model.
#'
#' When plotting the `D3mirt` model with `plot()`, it is possible to visually observe statistical violations in the graphical output returned.
#' For instance, shorter vector arrows indicate weaker discrimination and, therefore, higher amounts of statistical violations.
#' Moreover, if a polytomous item struggles or even fails to describe any of the latent variables in the model, it can often lead to an extreme stretch of the MDIFF range.
#' This is comparable to trace lines turning horizontal in a unidimensional item response theory model.
#'
#' The plot function can also display respondent scores in the three-dimensional model space, represented as spheres whose coordinates are derived from the respondent's factor scores.
#' This allows for a profile analysis in which respondent rows are separated or selected conditioned on some external criteria.
#' To do this, the user must first extract respondent factor scores with [mirt::fscores] (Chalmers, 2012) and then use some selection process to separate or subset respondent rows.
#' The resulting data frame is used in the `profiles` argument.
#' If desired, a confidence interval can be added to the spheres by setting `ci = TRUE`.
#' A general advice is to hide vector arrows with `hide = TRUE` when analyzing respondent profiles to avoid visual cluttering.
#' For more on profile analysis (e.g., preparation and examples), see package vignette.
#'
#' The returned RGL device can, for example, be exported to the R console and saved as an interactive HTML file or as a still shoot (see examples below).
#' In the the latter case, the model perspective in the still shoot can be manually adjusted by changing the `view` argument for the function.
#'
#'
#' @return A RGL graphical device.
#' @author Erik Forsberg
#' @references Adler, D., & Murdoch, D. (2022). \emph{Rgl: 3d Visualization Using OpenGL} Computer software.
#' @references Chalmers, R., P. (2012). mirt: A Multidimensional Item Response Theory Package for the R Environment. \emph{Journal of Statistical Software, 48}(6), 1-29.\cr
#' https://doi.org/10.18637/jss.v048.i06
#' @references Reckase, M. D. (2009). \emph{Multidimensional Item Response Theory}. Springer.
#' @references Reckase, M. D. (1985). The Difficulty of Test Items That Measure More Than One Ability. \emph{Applied Psychological Measurement, 9}(4), 401-412.\cr
#' https://doi.org/10.1177/014662168500900409
#' @references Reckase, M. D., & McKinley, R. L. (1991). The Discriminating Power of Items That Measure More Than One Dimension. \emph{Applied Psychological Measurement, 15}(4), 361-373.\cr
#' https://doi.org/10.1177/014662169101500407
#'
#' @name plot-methods
#' @rdname plot-methods
#'
#' @examples
#' \donttest{
#' # Load data
#' data("anes0809offwaves")
#' x <- anes0809offwaves
#' x <- x[, 3:22] # Remove columns for age and gender
#'
#' ### D3mirt plotting ###
#' # Call D3mirt() with constructs assigned to con
#' con <- list(c(1,2,3,4,5,6,7,8,9,10),
#'             c(11,12,13,14),
#'             c(15,17,18,19,20))
#' mod <- D3mirt(x, modid = c("W7Q3", "W7Q20"), con.items = con)
#'
#' # Plot RGL device without constructs
#' plot(mod)
#'
#' # Plot RGL device with constructs visible and named
#' plot(mod, constructs = TRUE,
#'      c.lab = c("Compassion", "Fairness", "Conformity"))
#'
#* # A selection of Conformity items from the model plotted with constructs
#' plot(mod, constructs = TRUE,
#'      items = c(15, 17, 18, 19, 20),
#'      c.lab = c("Compassion", "Fairness", "Conformity"))
#'
#' # Item W7Q16 has location 16 in the data set (gender and age excluded)
#' # Below, the item is plotted together with construct to aid the visual interpretation
#' plot(mod, constructs = TRUE,
#'      items = 16,
#'      c.lab = c("Compassion", "Fairness", "Conformity"))
#'
#' # Plot RGL device on item difficulty level 5
#' plot(mod, diff.level = 5)
#'
#' # Plot RGL device with item vectors at unit length and constructs visible and named
#' plot(mod, scale = TRUE,
#'      constructs = TRUE,
#'      c.lab = c("Compassion", "Fairness", "Conformity"))
#'
#' ### D2mirt plotting ###
#' # Call D2mirt() with constructs indicated using polar coordinates
#' mod1 <- D2mirt(x, modid = "W7Q10", con.pol = c(30, 45, 60))
#'
#' # Plot RGL device with constructs visible and named
#' plot(mod1, constructs = TRUE,
#' c.lab = c("A", "B", "C"))
#'
#' # Profile Analysis
#' # Plot respondents trait scores with item vectors hidden and no constructs
#' plot(mod, hide = TRUE, scores = TRUE)
#'
#' # Plot respondents separated on gender
#' # Start by assigning the gender variable to a data frame
#' # In this example, this is done by sub-setting the gender column
#' x <- anes0809offwaves
#'
#' # Call plot() and use the gender variable column in the levels argument
#' # Respondent data on gender is in column two, x[, 2]
#' # In the function call below, both items and constructs are hidden
#' # Score levels: 1 = Blue ("male") and 2 = Red ("female")
#' plot(mod, hide = TRUE, scores = TRUE,
#'     levels = x[, 2],
#'     sphere.col = c("blue", "red"),
#'     x.lab = "Compassion",
#'     y.lab="Conformity",
#'     z.lab="Fairness")
#'
#' # Add a 95% CI to respondent factor scores on <= 30 y.o.
#' # Column bind trait scores with the age variable "W3Xage"
#' z <- data.frame(cbind(mod$fscores, x[, 1]))
#'
#' # Subset data frame z conditioned on age <= 30
#' z1 <- subset(z, z[, 4] <= 30)
#'
#' # Use rep() to create a color vector to color groups based on the nlevels() output
#' # z1 has 14 factor levels
#' colvec <- c(rep("red", 14))
#'
#' # Call plot() with profile data on age with item vector arrows hidden
#' # Use the profiles argument for the data frame containing the subset to be plotted
#' plot(mod, hide = TRUE,
#'     profiles = z1,
#'     levels = z1[, 4],
#'     sphere.col = colvec,
#'     x.lab = "Compassion",
#'     y.lab="Conformity",
#'     z.lab="Fairness",
#'     ci = TRUE,
#'     ci.level = 0.95,
#'     ellipse.col = "orange")
#'}
#' \dontrun{
#' # Plot as interactive RGL device in external window
#' plot(mod, console = FALSE)
#'
#' # Export an open RGL device to the console to be saved as HTML or image file
#' plot(mod)
#' s <- rgl::scene3d()
#' rgl::rglwidget(s,
#'                width = 1040,
#'                height = 1040)
#'
#' # Export a snapshoot of an open RGL device directly to file
#' plot(mod)
#' rgl::rgl.snapshot('RGLdevice.png',
#'                     fmt = 'png')
#' }
#' @export
#' @method plot D3mirt
plot.D3mirt <- function (x, console = TRUE, scale = TRUE, hide = FALSE, scores = FALSE,
                         diff.level = NULL, items = NULL, item.names = TRUE,  item.lab = NULL,
                         constructs = FALSE, c.lab = NULL, adjust.lab = c(0.5, -0.8), dist = 0, c.dist = 0,
                         x.lab = "X", y.lab="Y", z.lab="Z", title="", line = -5, font = 1, cex = 0.8, font.col = "black",
                         axis.scalar = 1.1, axis.length = NULL, axis.points = "black",
                         axis.ticks = TRUE, nticks = 4,  width.rgl.x = 1040, width.rgl.y= 1040, view = c(15, 20, 0.6),
                         show.plane = TRUE, plane.col = "grey80", background = "white",
                         type = "rotation", col = c("black", "grey20", "grey40", "grey60", "grey80"),
                         arrow.width = 0.6, n = 20, theta = 0.2, barblen = 0.03,
                         c.scalars = c(1,1), c.type = "rotation", c.col = c("black", "black", "black", "black", "black"), c.arrow.width = 0.6,
                         c.n = 20, c.theta = 0.2, c.barblen = 0.03, profiles = NULL, levels = NULL,
                         sphere.col = c("black", "grey20", "grey40", "grey60", "grey80"), spheres.r = 0.05,
                         ci = FALSE, ci.level = 0.95, ellipse.col = "grey80", ellipse.alpha = 0.20, ...){
  if (!isa(x, "D3mirt")) stop("The input object must be of class D3mirt")
    rgl::open3d()
  rgl::par3d(windowRect = 50 + c( 0, 0, width.rgl.x, width.rgl.y))
  rgl::bg3d(color = background)
  rgl::view3d(theta = view[1], phi = view[2], zoom = view[3])
  if (is.null(axis.length)){
    if (!is.numeric(axis.scalar)) stop("The elements in axis.scalar are not numeric")
    if (length(axis.scalar) > 1) stop ("The axis.scalar vector must be of length one")
    if (is.null(ncol(x$dir.vec))){
      ax <- x$dir.vec
      low <- as.data.frame(ax[1])
      hig <- as.data.frame(ax[length(ax)])
      xaxis.min <- min(low[,1])*axis.scalar
      xaxis.max <- max(hig[,1])*axis.scalar
      yaxis.min <- min(low[,2])*axis.scalar
      yaxis.max <- max(hig[,2])*axis.scalar
      zaxis.min <- min(low[,3])*axis.scalar
      zaxis.max <- max(hig[,3])*axis.scalar
    } else {
      ax <- x$dir.vec
      xaxis.min <- min(ax[,1])*axis.scalar
      xaxis.max <- max(ax[,1])*axis.scalar
      yaxis.min <- min(ax[,2])*axis.scalar
      yaxis.max <- max(ax[,2])*axis.scalar
      zaxis.min <- min(ax[,3])*axis.scalar
      zaxis.max <- max(ax[,3])*axis.scalar
    }
  } else {
    if (!is.numeric(axis.length)) stop("The elements in axis.length are not numeric")
    if (length(axis.length) > 6) warning("The axis.length argument contains too many indicators")
    if (length(axis.length) < 6){
      a <-  rep(axis.length[length(axis.length)], (6-length(axis.length)))
      axis.length <- append(axis.length, a)
    }
    xaxis.max <- axis.length[1]
    xaxis.min <- axis.length[2]
    yaxis.max <- axis.length[3]
    yaxis.min <- axis.length[4]
    zaxis.max <- axis.length[5]
    zaxis.min <- axis.length[6]
  }
  xaxis <- c(-abs(xaxis.min), abs(xaxis.max))
  yaxis <- c(-abs(yaxis.min), abs(yaxis.max))
  zaxis <- c(-abs(zaxis.min), abs(zaxis.max))
  rgl::segments3d(xaxis, c(0, 0), c(0, 0), color = font.col)
  rgl::segments3d(c(0, 0), yaxis, c(0, 0), color = font.col)
  rgl::segments3d(c(0, 0), c(0, 0), zaxis, color = font.col)
  if (axis.ticks == TRUE){
    if (!is.numeric(nticks)) stop("The elements in nticks are not numeric")
    if (length(nticks) > 3) warning("The nticks argument contains too many indicators")
    if (length(nticks) < 3){
      a <-  rep(nticks[length(nticks)], (3-length(nticks)))
      nticks <- append(nticks, a)
    }
    rgl::axis3d('x', pos = c(0, 0, 0), ticks = TRUE, nticks=nticks[1], cex = cex, font = font, color = font.col)
    rgl::axis3d('y', pos = c(0, 0, 0), ticks = TRUE, nticks=nticks[2], cex = cex, font = font, color = font.col)
    rgl::axis3d('z',pos = c(0, 0, 0), ticks = TRUE, nticks=nticks[3], cex = cex, font = font, color = font.col)
  }
  axes <- rbind(c(xaxis[2], 0, 0), c(0, yaxis[2], 0),
                  c(0, 0, zaxis[2]))
  rgl::points3d(axes, color = axis.points, cex = cex)
  rgl::text3d(axes, texts = c(x.lab, y.lab, z.lab), color = font.col,
              adj = c(0.5, -0.8), font = font, cex = cex)
  rgl::title3d(main= title,line= line, cex = cex, font = font, color = font.col)
  if (show.plane == TRUE) {
    rgl::material3d(color = plane.col)
    xlim <- xaxis/1.5; zlim <- zaxis /1.5
    rgl::quads3d( x = rep(xlim, each = 2), y = c(0, 0, 0, 0),
                  z = c(zlim[1], zlim[2], zlim[2], zlim[1]))
  }
  if (hide == FALSE){
    if (scale == TRUE){
      vec <- x$dir.vec
    }
    if (scale == FALSE) {
      vec <- x$scal.vec
    }
      if (!is.null(items)){
        if(any(!items <= nrow(x$loadings))) stop("The items argument contains one or more item indicators higher than the total number of items")
        if (any(duplicated(items))) stop("The items argument has duplicate elements")
        m <- items*2-1
        if (is.null(diff.level)){
          if (is.null(ncol(vec))){
            for (i in seq_along(items)){
              m <- items[i]*2-1
              vapply(seq_along(vec), function(x){
                rgl::arrow3d(vec[[x, drop = FALSE]][m,], vec[[x, drop = FALSE]][m+1,], type = type, col = col[x], width = arrow.width, n = n, theta = theta, barblen = barblen)
              }, numeric(2))
            }
          } else {
            if(ncol(vec) == 1) stop("The data only has one level of difficulty")
            vapply(m, function(x){
              rgl::arrow3d(vec[x,], vec[x+1,], type = type, col = col[1], width = arrow.width, n = n, theta = theta, barblen = barblen)
            }, numeric(2))
          }
        } else {
          if(!diff.level== round(diff.level)) stop("Difficulty level must be indicated with integer values")
          if(!is.null(ncol(vec))) stop("The data only has one level of difficulty")
          if(diff.level > ncol(x$mdiff)) stop("The argument for difficulty level is too high")
          v <- vec[[diff.level]]
             vapply(m, function(x){
            rgl::arrow3d(v[x,], v[x+1,], type = type, col = col[diff.level], width = arrow.width, n = n, theta = theta, barblen = barblen)
          }, numeric(2))

        }
      }
      else if (!is.null(diff.level)) {
        if(!diff.level== round(diff.level)) stop("Difficulty level must be indicated with integer values")
        if(!is.null(ncol(vec))) stop("The data only has one level of difficulty")
        if(diff.level > ncol(x$mdiff)) stop("The argument for difficulty level is too high")
        for (i in seq_along(diff.level)){
          d <- diff.level[i]
          v <- as.data.frame(vec[d, drop = FALSE])
          color <- col[d]
          for (i in seq(from = 1, to = nrow(v), by = 2)){
            rgl::arrow3d(v[i,], v[i+1,], type = type, col = color, width = arrow.width, n = n, theta = theta, barblen = barblen)
          }
        }
      } else {
        if (is.null(ncol(vec))){
          for (i in seq_along(vec)){
            v <- vec[[i]]
            color <- col[i]
            for (i in seq(from = 1, to = nrow(v), by=2)){
              rgl::arrow3d(v[i,], v[i+1,], type = type, col = color, width = arrow.width, n = n, theta = theta, barblen = barblen)
            }
          }
        } else {
          for (i in seq(from = 1, to = nrow(vec), by = 2)) {
            rgl::arrow3d(vec[i, ], vec[i+1, ],
                         type = type, col = col[1],
                       width = arrow.width, n = n, theta = theta, barblen = barblen)
          }
        }
      }
      if (item.names == TRUE && is.null(items)){
        if (is.null(diff.level)){
          if (is.null(item.lab)){
            inames <- rownames(x$loadings)
            if (is.null(inames)) {
              inames <- paste0("Item ", seq_len(nrow(x$loadings)))
            }
            if (is.null(ncol(vec))){
              max <-  vec[[ncol(x$mdiff)]]
            } else {
              max <-  vec
            }
            head_rows <- seq(2, nrow(x$loadings) * 2, by = 2)
            rgl::text3d(
              x = max[head_rows, 1] + dist,
              y = max[head_rows, 2] + dist,
              z = max[head_rows, 3] + dist,
              texts = inames,
              color = font.col,
              adj = adjust.lab,
              font = font,
              cex = cex
            )
          } else {
            if(!length(item.lab) <= nrow(x$loadings)) warning("There are more item labels than items")
            if(length(item.lab) < nrow(x$loadings)) warning("There are too few item labels")
            if (is.null(ncol(vec))){
              max <-  vec[[ncol(x$mdiff)]]
            } else {
              max <-  vec
            }
            head_rows <- seq(2, nrow(x$loadings) * 2, by = 2)
            rgl::text3d(
              x = max[head_rows, 1] + dist,
              y = max[head_rows, 2] + dist,
              z = max[head_rows, 3] + dist,
              texts = item.lab,
              color = font.col,
              adj = adjust.lab,
              font = font,
              cex = cex
            )
          }
        } else {
          if (is.null(item.lab)){
            inames <- rownames(x$loadings)
            if (is.null(inames)) {
              inames <- paste0("Item ", seq_len(nrow(x$loadings)))
            }
            dl <-  vec[[diff.level]]
            head_rows <- seq(2, nrow(x$loadings) * 2, by = 2)
            rgl::text3d(
              x = dl[head_rows, 1] + dist,
              y = dl[head_rows, 2] + dist,
              z = dl[head_rows, 3] + dist,
              texts = inames,
              color = font.col,
              adj = adjust.lab,
              font = font,
              cex = cex
            )
          } else {
            if(!length(item.lab) <= nrow(x$loadings)) warning("There are more item labels than items")
            if(length(item.lab) < nrow(x$loadings)) warning("There are too few item labels")
            max <-  vec[[diff.level]]
            head_rows <- seq(2, nrow(x$loadings) * 2, by = 2)
            rgl::text3d(
              x = max[head_rows, 1] + dist,
              y = max[head_rows, 2] + dist,
              z = max[head_rows, 3] + dist,
              texts = item.lab,
              color = font.col,
              adj = adjust.lab,
              font = font,
              cex = cex
            )

          }
        }
      }
  }
      if (item.names == TRUE && !is.null(items)){
        if(any(!items <= nrow(x$loadings))) stop("The items list contains one or more item indicators higher than the total number of items")
        if (is.null(diff.level)){
          if (is.null(item.lab)){
            inames <- rownames(x$loadings)
            if (is.null(ncol(vec))){
              max <-  vec[[ncol(x$mdiff)]]
            } else {
              max <-  vec
            }
            m <- items
            rgl::text3d(
              x = max[m * 2, 1] + dist,
              y = max[m * 2, 2] + dist,
              z = max[m * 2, 3] + dist,
              texts = inames[m],
              color = font.col,
              adj = adjust.lab,
              font = font,
              cex = cex
            )
          } else {
            if(!length(item.lab) <= length(items)) warning("There are more item labels than items in the items list")
            if(length(item.lab) < length(items)) warning("There are too few item labels")
            if (is.null(ncol(vec))){
              max <-  vec[[ncol(x$mdiff)]]
            } else {
              max <-  vec
            }
            m <- items
            rgl::text3d(
              x = max[m * 2, 1] + dist,
              y = max[m * 2, 2] + dist,
              z = max[m * 2, 3] + dist,
              texts = item.lab[m],
              color = font.col,
              adj = adjust.lab,
              font = font,
              cex = cex
            )
          }
        } else {
          m <- items
          if (is.null(item.lab)){
            inames <- rownames(x$loadings)
            if (is.null(inames)) {
              inames <- paste0("Item ", seq_len(nrow(x$loadings)))
            }
            dl <-  vec[[diff.level]]
            rgl::text3d(
              x = dl[m * 2, 1] + dist,
              y = dl[m * 2, 2] + dist,
              z = dl[m * 2, 3] + dist,
              texts = inames[m],
              color = font.col,
              adj = adjust.lab,
              font = font,
              cex = cex
            )
          } else {
            if(!length(item.lab) <= length(items)) warning("There are more item labels than items in the items list")
            if(length(item.lab) < length(items)) warning("There are too few item labels")
            dl <-  as.data.frame(vec[diff.level, drop = FALSE])
            rgl::text3d(
              x = dl[m * 2, 1] + dist,
              y = dl[m * 2, 2] + dist,
              z = dl[m * 2, 3] + dist,
              texts = item.lab[m],
              color = font.col,
              adj = adjust.lab,
              font = font,
              cex = cex
            )
          }
        }
  }
  if (constructs == TRUE){
    if (is.null(x$c.vec)) stop("The D3mirt object does not contain any constructs")
    cvec <- x$c.vec
    p <- seq(from = 1, to = nrow(cvec) - 1, by = 2)
    for (i in seq_along(p)) {
      s <- p[i]
      rgl::arrow3d(p0 = cvec[s, ] * c.scalars[2],
                   p1 = cvec[s + 1, ] * c.scalars[1],
                   type = c.type,
                   col = c.col[i],
                   width = c.arrow.width, n = c.n, theta = c.theta, barblen = c.barblen)
    }
    if (!is.null(c.lab) && constructs == TRUE){
      if(!length(c.lab) <= nrow(x$c.vec)) warning("There are more construct labels than constructs")
      clab <-  x$c.vec*c.scalars[1]
      n <- nrow(x$c.dir.cos)
      row <- seq_len(n) * 2
      rgl::text3d(x = clab[row, 1] + c.dist,
                  y = clab[row, 2] + c.dist,
                  z = clab[row, 3] + c.dist,
                  texts = c.lab[1:n],
                  color = font.col,
                  adj = adjust.lab, font = font, cex = cex)
    }
  }
  if (scores == TRUE || !is.null(profiles)){
    if(scores == TRUE && !is.null(profiles)) stop("Do not use the profiles argument when individual scores is set to TRUE")
    if (is.null(profiles)){
      profiles <- x$fscores
      x <- profiles[,1]
      y <- profiles[,2]
      z <- profiles[,3]
    } else {
      profiles <- as.matrix(profiles)
      x <- profiles[,1]
      y <- profiles[,2]
      z <- profiles[,3]
    }
    if (!is.null(levels)){
      grad <- function (levels, sphere.col){
        levels <- as.matrix(levels)
        levels <- as.factor(levels)
        if (nlevels(levels) > length(sphere.col)) stop ("The number of factor levels are higher than the number of available sphere colors")
        color <- sphere.col[as.numeric(levels)]
        names(color) <- as.vector(levels)
        color
      }
      rgl::spheres3d(x,y,z, radius = spheres.r, color = grad(levels, sphere.col))
      if (ci == TRUE){
        ellipse <- rgl::ellipse3d(cov(cbind(x,y,z)),
                                  centre=c(mean(x), mean(y), mean(z)), level = ci.level)
        rgl::shade3d(ellipse, col = ellipse.col, alpha = ellipse.alpha)
      }
    } else {
      rgl::spheres3d(x,y,z, radius = spheres.r, color = sphere.col[1])
      if (ci == TRUE){
        ellipse <- rgl::ellipse3d(cov(cbind(x,y,z)),
                                  centre=c(mean(x), mean(y), mean(z)), level = ci.level)
        rgl::shade3d(ellipse, col = ellipse.col, alpha = ellipse.alpha)
      }
    }
  }
  if (console == TRUE){
    rgl::rglwidget()
  }
}
#' @rdname plot-methods
#' @export
#' @method plot D2mirt
plot.D2mirt <- function (x, console = TRUE, scale = FALSE, hide = FALSE, scores = FALSE,
                         diff.level = NULL, items = NULL, item.names = TRUE,  item.lab = NULL,
                         constructs = FALSE, c.lab = NULL, adjust.lab = c(0.5, -0.8), dist = 0, c.dist = 0,
                         x.lab = "X", y.lab="Y", z.lab="Z", title="", line = -5, font = 1, cex = 0.8, font.col = "black",
                         axis.scalar = 1.1, axis.length = NULL, axis.points = "black",
                         axis.ticks = TRUE, nticks = 4,  width.rgl.x = 1040, width.rgl.y= 1040, view = c(0, 0, 0.6),
                         show.plane = TRUE, plane.col = "grey80", background = "white",
                         type = "rotation", col = c("black", "grey20", "grey40", "grey60", "grey80"),
                         arrow.width = 0.6, n = 20, theta = 0.2, barblen = 0.03,
                         c.scalars = c(1,1), c.type = "rotation", c.col = c("black", "black", "black", "black", "black"), c.arrow.width = 0.6,
                         c.n = 20, c.theta = 0.2, c.barblen = 0.03, profiles = NULL, levels = NULL,
                         sphere.col = c("black", "grey20", "grey40", "grey60", "grey80"), spheres.r = 0.05,
                         ci = FALSE, ci.level = 0.95, sd = 0.15, ellipse.col = "grey80", ellipse.alpha = 0.20, ...){
  if (!isa(x, "D2mirt")) stop("The input object must be of class D2mirt")
  rgl::open3d()
  rgl::par3d(windowRect = 50 + c( 0, 0, width.rgl.x, width.rgl.y))
  rgl::bg3d(color = background)
  rgl::view3d(theta = view[1], phi = view[2], zoom = view[3])
  if (is.null(axis.length)){
    if (!is.numeric(axis.scalar)) warning("The elements in axis.scalar are not numeric")
    if (length(axis.scalar) > 1) warning("The axis.scalar vector must be of length one")
    if (is.null(ncol(x$dir.vec))){
      ax <- x$dir.vec
      low <- as.data.frame(ax[1])
      hig <- as.data.frame(ax[length(ax)])
      xaxis.min <- min(low[,1])*axis.scalar
      xaxis.max <- max(hig[,1])*axis.scalar
      yaxis.min <- min(low[,2])*axis.scalar
      yaxis.max <- max(hig[,2])*axis.scalar
    } else {
      ax <- x$dir.vec
      xaxis.min <- min(ax[,1])*axis.scalar
      xaxis.max <- max(ax[,1])*axis.scalar
      yaxis.min <- min(ax[,2])*axis.scalar
      yaxis.max <- max(ax[,2])*axis.scalar
    }
  } else {
    if (!is.numeric(axis.length)) warning("The elements in axis.length are not numeric")
    if (length(axis.length) > 6) warning("The axis.length argument contains too many indicators")
    if (length(axis.length) < 6){
      a <-  rep(axis.length[length(axis.length)], (6-length(axis.length)))
      axis.length <- append(axis.length, a)
    }
    xaxis.max <- axis.length[1]
    xaxis.min <- axis.length[2]
    yaxis.max <- axis.length[3]
    yaxis.min <- axis.length[4]
  }
  xaxis <- c(-abs(xaxis.min), abs(xaxis.max))
  yaxis <- c(-abs(yaxis.min), abs(yaxis.max))
  zaxis <- c(0)
  rgl::segments3d(xaxis, c(0, 0), c(0, 0), color = font.col)
  rgl::segments3d(c(0, 0), yaxis, c(0, 0), color = font.col)
  if (axis.ticks == TRUE){
    if (!is.numeric(nticks)) warning("The elements in nticks are not numeric")
    if (length(nticks) > 3) warning("The nticks argument contains too many indicators")
    if (length(nticks) < 3){
      a <-  rep(nticks[length(nticks)], (3-length(nticks)))
      nticks <- append(nticks, a)
    }
    rgl::axis3d('x', pos = c(0, 0, 0), ticks = TRUE, nticks=nticks[1], cex = cex, font = font, color = font.col)
    rgl::axis3d('y', pos = c(0, 0, 0), ticks = TRUE, nticks=nticks[2], cex = cex, font = font, color = font.col)
  }
  axes <- rbind(c(xaxis[2], 0, 0), c(0, yaxis[2], 0),
                c(0, 0, zaxis))
  rgl::points3d(axes, color = axis.points, cex = cex)
  rgl::text3d(axes, text = c(x.lab, y.lab), color = font.col,
              adj = c(0.5, -0.8), font = font, cex = cex)
  rgl::title3d(main= title,line= line, cex = cex, font = font, color = font.col)
  if (hide == FALSE){
    if (scale == FALSE){
      vec <- x$dir.vec
    }
    if (scale == TRUE) {
      vec <- x$scal.vec
    }
    if (!is.null(items)){
      if(any(!items <= nrow(x$loadings))) warning("The items argument contains one or more item indicators higher than the total number of items")
      if (any(duplicated(items))) warning("The items argument has duplicate elements")
      m <- items*2-1
      if (is.null(diff.level)){
        if (is.null(ncol(vec))){
          for (i in seq_along(items)){
            m <- items[i]*2-1
            vapply(seq_along(vec), function(x){
              rgl::arrow3d(vec[[x, drop = FALSE]][m,], vec[[x, drop = FALSE]][m+1,], type = type, col = col[x], width = arrow.width, n = n, theta = theta, barblen = barblen)
            }, numeric(2))
          }
        } else {
          if(ncol(vec) == 1) stop("The data only has one level of difficulty")
          vapply(m, function(x){
            rgl::arrow3d(vec[x,], vec[x+1,], type = type, col = col[1], width = arrow.width, n = n, theta = theta, barblen = barblen)
          }, numeric(2))
        }
      } else {
        if(!diff.level== round(diff.level)) stop("Difficulty level must be indicated with integer values")
        if(!is.null(ncol(vec))) stop("The data only has one level of difficulty")
        if(diff.level > ncol(x$mdiff)) stop("The argument for difficulty level is too high")
        v <- vec[[diff.level]]
        vapply(m, function(x){
          rgl::arrow3d(v[x,], v[x+1,], type = type, col = col[diff.level], width = arrow.width, n = n, theta = theta, barblen = barblen)
        }, numeric(2))
      }
    }
    else if (!is.null(diff.level)) {
      if(!diff.level== round(diff.level)) stop("Difficulty level must be indicated with integer values")
      if(!is.null(ncol(vec))) stop("The data only has one level of difficulty")
      if(diff.level > ncol(x$mdiff)) stop("The argument for difficulty level is too high")
      for (i in seq_along(diff.level)){
        d <- diff.level[i]
        v <- as.data.frame(vec[d, drop = FALSE])
        color <- col[d]
        for (i in seq(from = 1, to = nrow(v), by = 2)){
          rgl::arrow3d(v[i,], v[i+1,], type = type, col = color, width = arrow.width, n = n, theta = theta, barblen = barblen)
        }
      }
    } else {
      if (is.null(ncol(vec))){
        for (i in seq_along(vec)){
          v <- vec[[i]]
          color <- col[i]
          for (i in seq(from = 1, to = nrow(v), by=2)){
            rgl::arrow3d(v[i,], v[i+1,], type = type, col = color, width = arrow.width, n = n, theta = theta, barblen = barblen)
          }
        }
      } else {
        for (i in seq(from = 1, to = nrow(vec), by = 2)) {
          rgl::arrow3d(vec[i, ], vec[i+1, ],
                       type = type, col = col[1],
                       width = arrow.width, n = n, theta = theta, barblen = barblen)
        }
      }
    }
    if (item.names == TRUE && is.null(items)){
      if (is.null(diff.level)){
        if (is.null(item.lab)){
          inames <- rownames(x$loadings)
          if (is.null(inames)) {
            inames <- paste0("Item ", seq_len(nrow(x$loadings)))
          }
          if (is.null(ncol(vec))){
            max <-  vec[[ncol(x$mdiff)]]
          } else {
            max <-  vec
          }
          head_rows <- seq(2, nrow(x$loadings) * 2, by = 2)
          rgl::text3d(
            x = max[head_rows, 1] + dist,
            y = max[head_rows, 2] + dist,
            z = max[head_rows, 3] + dist,
            texts = inames,
            color = font.col,
            adj = adjust.lab,
            font = font,
            cex = cex
          )
        } else {
          if(!length(item.lab) <= nrow(x$loadings)) warning("There are more item labels than items")
          if(length(item.lab) < nrow(x$loadings)) warning("There are too few item labels")
          if (is.null(ncol(vec))){
            max <-  vec[[ncol(x$mdiff)]]
          } else {
            max <-  vec
          }
          head_rows <- seq(2, nrow(x$loadings) * 2, by = 2)
          rgl::text3d(
            x = max[head_rows, 1] + dist,
            y = max[head_rows, 2] + dist,
            z = max[head_rows, 3] + dist,
            texts = item.lab,
            color = font.col,
            adj = adjust.lab,
            font = font,
            cex = cex
          )
        }
      } else {
        if (is.null(item.lab)){
          inames <- rownames(x$loadings)
          if (is.null(inames)) {
            inames <- paste0("Item ", seq_len(nrow(x$loadings)))
          }
          dl <-  vec[[diff.level]]
          head_rows <- seq(2, nrow(x$loadings) * 2, by = 2)
          rgl::text3d(
            x = dl[head_rows, 1] + dist,
            y = dl[head_rows, 2] + dist,
            z = dl[head_rows, 3] + dist,
            texts = inames,
            color = font.col,
            adj = adjust.lab,
            font = font,
            cex = cex
          )
        } else {
          if(!length(item.lab) <= nrow(x$loadings)) warning("There are more item labels than items")
          if(length(item.lab) < nrow(x$loadings)) warning("There are too few item labels")
          max <-  vec[[diff.level]]
          head_rows <- seq(2, nrow(x$loadings) * 2, by = 2)
          rgl::text3d(
            x = max[head_rows, 1] + dist,
            y = max[head_rows, 2] + dist,
            z = max[head_rows, 3] + dist,
            texts = item.lab,
            color = font.col,
            adj = adjust.lab,
            font = font,
            cex = cex
          )
        }
      }
    }
    if (item.names == TRUE && !is.null(items)){
      if(any(!items <= nrow(x$loadings))) warning("The items list contains one or more item indicators higher than the total number of items")
      if (is.null(diff.level)){
        if (is.null(item.lab)){
          inames <- rownames(x$loadings)
          if (is.null(inames)) {
            inames <- paste0("Item ", seq_len(nrow(x$loadings)))
          }
          if (is.null(ncol(vec))){
            max <-  vec[[ncol(x$mdiff)]]
          } else {
            max <-  vec
          }
          m <- items
          rgl::text3d(
            x = max[m * 2, 1] + dist,
            y = max[m * 2, 2] + dist,
            z = max[m * 2, 3] + dist,
            texts = inames[m],
            color = font.col,
            adj = adjust.lab,
            font = font,
            cex = cex
          )
        } else {
          if(!length(item.lab) <= length(items)) warning("There are more item labels than items in the items list")
          if(length(item.lab) < length(items)) warning("There are too few item labels")
          if (is.null(ncol(vec))){
            max <-  vec[[ncol(x$mdiff)]]
          } else {
            max <-  vec
          }
          m <- items
          rgl::text3d(
            x = max[m * 2, 1] + dist,
            y = max[m * 2, 2] + dist,
            z = max[m * 2, 3] + dist,
            texts = item.lab[m],
            color = font.col,
            adj = adjust.lab,
            font = font,
            cex = cex
          )
        }
      } else {
        m <- items
        if (is.null(item.lab)){
          dl <-  vec[[diff.level]]
          inames <- rownames(x$loadings)
          if (is.null(inames)) {
            inames <- paste0("Item ", seq_len(nrow(x$loadings)))
          }
          rgl::text3d(
            x = dl[m * 2, 1] + dist,
            y = dl[m * 2, 2] + dist,
            z = dl[m * 2, 3] + dist,
            texts = inames[m],
            color = font.col,
            adj = adjust.lab,
            font = font,
            cex = cex
          )
        } else {
          if(!length(item.lab) <= length(items)) warning("There are more item labels than items in the items list")
          if(length(item.lab) < length(items)) warning("There are too few item labels")
          dl <-  as.data.frame(vec[diff.level, drop = FALSE])
          rgl::text3d(
            x = dl[m * 2, 1] + dist,
            y = dl[m * 2, 2] + dist,
            z = dl[m * 2, 3] + dist,
            texts = item.lab[m],
            color = font.col,
            adj = adjust.lab,
            font = font,
            cex = cex
          )
        }
      }
    }
  }
  if (constructs == TRUE){
    if (is.null(x$c.vec)) stop("The D2mirt object does not contain any constructs")
    cvec <- x$c.vec
    p <- seq(from = 1, to = nrow(cvec) - 1, by = 2)
    for (i in seq_along(p)) {
      s <- p[i]
      rgl::arrow3d(p0 = cvec[s, ] * c.scalars[2],
                   p1 = cvec[s + 1, ] * c.scalars[1],
                   type = c.type,
                   col = c.col[i],
                   width = c.arrow.width, n = c.n, theta = c.theta, barblen = c.barblen)
    }
    if (!is.null(c.lab) && constructs == TRUE){
      if(!length(c.lab) <= nrow(x$c.vec)) warning("There are more construct labels than constructs")
      clab <-  x$c.vec*c.scalars[1]
      n <- nrow(x$c.dir.cos)
      row <- seq_len(n) * 2
      rgl::text3d(x = clab[row, 1] + c.dist,
                  y = clab[row, 2] + c.dist,
                  z = clab[row, 3] + c.dist,
                  texts = c.lab[1:n],
                  color = font.col,
                  adj = adjust.lab, font = font, cex = cex)
    }
  }
  if (scores == TRUE || !is.null(profiles)){
    if (is.null(x$fscores)) warning ("The object does not contain scores")
    if(scores == TRUE && !is.null(profiles)) stop("Do not use the profiles argument when individual scores is set to TRUE")
    if (is.null(profiles)){
      profiles <- x$fscores
      q <- profiles[,1]
      y <- profiles[,2]
      z <- profiles[,3]
    } else {
      profiles <- as.matrix(profiles)
      q <- profiles[,1]
      y <- profiles[,2]
      z <- profiles[,3]
    }
    if (!is.null(levels)){
      grad <- function (levels, sphere.col){
        levels <- as.matrix(levels)
        levels <- as.factor(levels)
        if (nlevels(levels) > length(sphere.col)) warning ("The number of factor levels are higher than the number of available sphere colors")
        color <- sphere.col[as.numeric(levels)]
        names(color) <- as.vector(levels)
        color
      }
      rgl::spheres3d(q,y,z, radius = spheres.r, color = grad(levels, sphere.col))
      if (ci == TRUE){
        z <- rnorm(nrow(profiles),0,sd)
        ellipse <- rgl::ellipse3d(cov(cbind(q,y,z)),
                                  centre=c(mean(q), mean(y), mean(z)), level = ci.level)
        rgl::shade3d(ellipse, col = ellipse.col, alpha = ellipse.alpha)
      }
    } else {
      rgl::spheres3d(q,y,z, radius = spheres.r, color = sphere.col[1])
      if (ci == TRUE){
        if (is.null(x$fscores)) warning ("The object does not contain scores")


        z <- rnorm(nrow(profiles),0,sd)
        ellipse <- rgl::ellipse3d(cov(cbind(q,y,z)),
                                  centre=c(mean(q), mean(y), mean(z)), level = ci.level)
        rgl::shade3d(ellipse, col = ellipse.col, alpha = ellipse.alpha)
      }
    }
  }
  if (console == TRUE){
    rgl::rglwidget()
  }
}
