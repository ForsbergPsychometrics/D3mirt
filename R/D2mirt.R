#' 2D DMIRT Model Estimation
#'
#' @description Descriptive multidimensional item response theory model estimation (DMIRT; Reckase, 2009, 1985, Reckase and McKinley, 1991) for dichotomous and polytomous items restricted to two dimensions.
#'
#' @param x A data frame with items in rows and model parameters in columns containing raw response data as integer values or factor loadings.
#' Input can also be an S4 object of class 'SingleGroupClass' exported from [mirt::mirt] (Chalmers, 2012).
#' The data frame with factor loadings must have two columns with loading parameters and at least one column for difficulty parameters.
#' @param modid Use either the two model identification items from [D3mirt::modid] as a combined vector or use nested list of item indicators to fit an orthogonal model (see examples below).
#' The default is `modid = NULL`.
#' @param model The user has the option of imputing a model specification schema used in the call to [mirt::mirt] (Chalmers, 2012).
#' The default is `model = NULL`.
#' @param con.items Optional. Nested lists with integer values as item indicators to identify constructs. The default is `con.items = NULL`.
#' @param con.pol Optional. Polar angles to identify constructs indicated using integers (e.g., 45 for a single 45 degrees construct and c(30, 45, 60) for three construct angles in polar coordinate form). The default is `con.pol = NULL`.
#' @param cap Lower bound for standard error to avoid dividing by infinity. The default is `cap = 0.0001`.
#' @param itemtype What item type to use in the function call. Available options are `"2PL"` and `"graded"`. The default is `itemtype = "graded"`.
#' @param method.mirt Estimation algorithm for [mirt::mirt] (Chalmers, 2012) to fit the model. The default is `method.mirt = "QMCEM"`.
#' @param method.fscores Factor estimation algorithm for [mirt::fscores] (Chalmers, 2012) for extracting respondent trait scores. The default is `method.fscores = "EAP"`.
#' @param QMC Integration method for [mirt::fscores] (Chalmers, 2012). The default is `QMC = TRUE`.
#' @param ... Any additional arguments passed to mirt().
#'
#' @importFrom mirt mirt
#' @importFrom mirt fscores
#' @importFrom mirt coef
#'
#' @details The `D2mirt()` is a two-dimensional version of the `D3mirt()` function and takes in model parameters from a compensatory two-dimensional multidimensional two-parameter logistic model (M2PL) or a multidimensional graded
#' response model (MGRM). See [D3mirt::D3mirt] or package vignette for more details on function calls and options.
#'
#'
#' @return A S3 object of class `D2mirt` with lists of \emph{a} and \emph{d} parameters from the M2PL or MGRM estimation, multidimensional difficulty (MDIFF), multidimensional discrimination (MDISC), direction cosines and degrees for vector angles, construct lists, vector coordinates, and respondent trait scores.
#' @author Erik Forsberg
#' @references Chalmers, R., P. (2012). mirt: A Multidimensional Item Response Theory Package for the R Environment. \emph{Journal of Statistical Software, 48}(6), 1-29.\cr
#' https://doi.org/10.18637/jss.v048.i06
#' @references Reckase, M. D. (2009). \emph{Multidimensional Item Response Theory}. Springer.
#' @references Reckase, M. D. (1985). The Difficulty of Test Items That Measure More Than One Ability. \emph{Applied Psychological Measurement, 9}(4), 401-412.\cr
#' https://doi.org/10.1177/014662168500900409
#' @references Reckase, M. D., & McKinley, R. L. (1991). The Discriminating Power of Items That Measure More Than One Dimension. \emph{Applied Psychological Measurement, 15}(4), 361-373.\cr
#' https://doi.org/10.1177/014662169101500407
#'
#' @examples
#' \donttest{
#' # Load data
#' data("anes0809offwaves")
#' x <- anes0809offwaves
#' x <- x[, 3:22] # Remove columns for age and gender
#'
#' # Call to modid() using two dimensions
#' a <- modid(x, factors = 2)
#'
#' # Show summary of results
#' summary(a)
#'
#' # Call to D2mirt() using W7Q10 as model identification item
#' mod <- D2mirt(x, modid="W7Q10")
#'
#' # Show summary of results
#' summary(mod)
#'
#' # Call to D2mirt with three construct vectors indicated with polar angles
#' # Note that indicating constructs using items is the same as with D3mirt()
#' mod <- D2mirt(x, modid="W7Q10", con.pol = c(30, 45, 60))
#'
#' # Show summary of results
#' summary(mod)
#'
#' # Call D2mirt() using the orthogonal optional model
#' # In this example item W7Q16 is removed from the data frame
#' y <- data.frame(x[,-16])
#'
#' # Items are constrained to the x and y-axes using
#' # Nested lists with positive integers as item indicators
#' # Note that integers indicate where the items are located in the data frame
#' mod <- D2mirt(y, modid = list(c(1:14),
#'                             c(15:19)))
#'
#' # Show summary of results
#' summary(mod)
#' }
#' @export
D2mirt <- function(x, modid = NULL, model = NULL, con.items = NULL, con.pol = NULL, cap = 0.0001, itemtype = "graded", method.mirt = "QMCEM", method.fscores = "EAP", QMC = TRUE, ...){
  if (!(itemtype == "graded" || itemtype == "2PL")) stop("The item model must be GRM or 2PL")
  if (!is.null(con.items) && !is.null(con.pol)) stop("Use either items or polar coordinates for constructs, not both")
  if (isS4(x)){
    trait <- mirt::fscores(x, method = method.fscores, full.scores = TRUE, full.scores.SE = FALSE, QMC = TRUE)
    k <- x@Data$K[1]-1
    x <- data.frame(mirt::coef(x, simplify=TRUE)$"items"[,1:(2+k)])
    x <- as.matrix(x)
  } else if (any(!x == round(x))){
    x <- as.matrix(x)
    trait <-  NULL
  } else {
    if(!is.null(modid)){
      if (length(modid) > 2) stop("The model identification argument contains too many elements")
      mod <- NULL
      mod <- c(paste("F1 = 1 -", ncol(x), "\n",
               paste("F2 = 1 -", ncol(x), "\n")))
      if (length(modid) == 1) {
        t <- c(paste("START=(", modid[1], ", a2, 0)", "\n"),
               paste("FIXED=(", modid[1], ", a2)", "\n"))
      }

      mod <- c(paste("F1 = 1 -", ncol(x), "\n",
               paste("F2 = 1 -", ncol(x), "\n")))
      if (length(modid) == 2) {
        t <- NULL
        l1 <- unlist(modid[1])
        l2 <- unlist(modid[2])
        for (i in seq_along(l1)){
          t <-append(t, paste("START=(", colnames(x[l1[i]]), ", a2, 0)", "\n"))
          t <-append(t, paste("FIXED=(", colnames(x[l1[i]]), ", a2)", "\n"))
        }
        for (i in seq_along(l2)){
          t <-append(t, paste("START=(", colnames(x[l2[i]]), ", a1, 0)", "\n"))
          t <-append(t, paste("FIXED=(", colnames(x[l2[i]]), ", a1)", "\n"))
        }
      }
      mod <- append(mod, t)
      model <- paste(mod, sep="",collapse="")
    }
    if (is.null(model)) stop("The model must be identified, use model identification items or constrain all items to parallell with the axes")
    if (length(unique(x[, 1])) > 2 && itemtype == "2PL") stop("Use the GRM as item model if the items have more than two response options")
    if (length(unique(x[, 1])) == 2 && itemtype == "graded") warning("Use the 2PL as item model if the items have two response options")
    y <- mirt::mirt(x, model = model, itemtype = itemtype, SE = FALSE, method = method.mirt)
    trait <- mirt::fscores(y, method = method.fscores, full.scores = TRUE, full.scores.SE = FALSE, QMC = QMC)
    trait <- as.matrix(cbind(trait, F3 = rep(0, nrow(x))))
    k <- y@Data$K[1]-1
    y <- data.frame(mirt::coef(y, simplify=TRUE)$"items"[,1:(2+k)])
    x <- as.matrix(y)
  }
  if (ncol(x) < 3) stop("The data frame must have at least 3 columns")
  a <- x[, 1:2, drop = FALSE]
  a3 <- c(rep(0,nrow(a)))
  a <- as.matrix(cbind(a, a3))
  ndiff <- ncol(x)-2
  diff <- x[, (3):(2+ndiff), drop = FALSE]
  mdisc <- sqrt(rowSums(a^2))
  info <- 0.25 * (mdisc^2)
  infocap <- pmax(info, cap)
  infose <- 1/sqrt(infocap)
  md <- mdisc%*%matrix(rep(1,3), nrow=1, ncol=3)
  dcos <- as.matrix(a/md, ncol = 3)
  theta <- NULL
  for (i in seq(nrow(dcos))){
    c <- dcos[i, 1]
    d <- dcos[i, 2]
    if (c < 0 && d >= 0){
      t <- 180 + atan(dcos[i,2]/dcos[i,1])*(180/pi)
      theta <- as.matrix(rbind(theta, t), ncol = 1)
    } else if (c < 0 && d < 0){
      t <- -180 + atan(dcos[i,2]/dcos[i,1])*(180/pi)
      theta <- as.matrix(rbind(theta, t), ncol = 1)
    } else {
      t <- atan(dcos[i,2]/dcos[i,1])*(180/pi)
      theta <- as.matrix(rbind(theta, t), ncol = 1)
    }
  }
  pol <- as.vector(theta)
  vector1 <- NULL
  vector2 <- NULL
  mdiff <- NULL
  for (i in seq_len(ndiff)){
    d <- diff[,i]
    dist <- -d/mdisc
    xyz <- dist*dcos
    uvw1 <- mdisc*dcos+xyz
    uvw2 <- dcos+xyz
    vec1 <- do.call(rbind,list(xyz,uvw1))[order(sequence(vapply(list(xyz,uvw1),nrow, integer(1)))),]
    vec2 <- do.call(rbind,list(xyz,uvw2))[order(sequence(vapply(list(xyz,uvw2),nrow, integer(1)))),]
    vector1 <- as.matrix(rbind(vector1,vec1), ncol = 3)
    vector2 <- as.matrix(rbind(vector2,vec2), ncol = 3)
    mdiff <- as.matrix(cbind(mdiff, dist), ncol = 1)
  }
  if (!is.null(con.items)){
    if (!is.list(con.items)) stop("The construct argument must be of type list")
    if (max(range(con.items)) > nrow(x)) stop("The construct list contains too many item indicators")
    con <- NULL
    cpol <- NULL
    ncos <- NULL
    ddisc <- NULL
    for (i in seq_along(con.items)){
      l <- unlist(con.items[i])
      cosk <- NULL
      for (i in seq_along(l)){
        n <- l[i]
        m <- dcos[n,]
        cosk <- as.matrix(rbind(cosk,m), ncol = 3)
      }
      cscos <- matrix(colSums(cosk), ncol = 3)
      cdcos <- 1/sqrt(rowSums(cscos^2))*cscos
      maxnorm <- (1.1*max(vector1))*cdcos
      minnorm <- (0.6*min(vector1))*cdcos
      con <- as.matrix(rbind(con,rbind(minnorm, maxnorm)), ncol = 3)
      ncos <- as.matrix(rbind(ncos,cdcos), ncol = 3)
      theta <- NULL
      ac <- NULL
      for (i in seq(nrow(cdcos))){
        c <- cdcos[i,1]
        d <- cdcos[i,2]
        if (c < 0 && d >= 0){
          t <- 180 + atan(cdcos[i,2]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        } else if (c < 0 && d < 0){
          t <- -180 + atan(cdcos[i,2]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        } else {
          t <- atan(cdcos[i,2]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        }
      }
      cpol <- as.matrix(rbind(cpol,theta), ncol = 1)
      disc <-  apply(a, 1, function(x) x %*% t(cdcos))
      ddisc <- as.matrix(cbind(ddisc, disc), ncol = 1)
    }
    ddinfo <- 0.25 * (ddisc^2)
    ddinfocap <- pmax(ddinfo, cap)
    ddinfose <- 1/sqrt(ddinfocap)
  }
  if (!is.null(con.pol)){
    con <- NULL
    cpol <- NULL
    ncos <- NULL
    cdcos <- NULL
    ddisc <- NULL
    for (i in seq_along(con.pol)){
      l <- unlist(con.pol[i])
      if(l[1] > 180) stop("The theta angle must be between +/- 180 degrees")
      if(l[1] < -180) stop("The theta angle must be between +/- 180 degrees")
      r <- l[1]*(pi/180)
      j <- cos(r)
      k <- sin(r)
      cdcos <- as.matrix(cbind(j,k, 0), ncol = 3)
      maxnorm <- (1.1*max(vector1))*cdcos
      minnorm <- (0.6*min(vector1))*cdcos
      con <- as.matrix(rbind(con,rbind(minnorm, maxnorm)), ncol = 3)
      ncos <- as.matrix(rbind(ncos,cdcos), ncol = 3)
      theta <- NULL
      ac <- NULL
      for (i in seq(nrow(cdcos))){
        c <- cdcos[i,1]
        d <- cdcos[i,2]
        if (c < 0 && d >= 0){
          t <- 180 + atan(cdcos[i,2]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        } else if (c < 0 && d < 0){
          t <- -180 + atan(cdcos[i,2]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        } else {
          t <- atan(cdcos[i,2]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        }
      }
      cpol <- as.matrix(rbind(cpol, theta), ncol = 1)
      disc <-  apply(a, 1, function(x) x %*% t(cdcos))
      ddisc <- as.matrix(cbind(ddisc, disc), ncol = 1)
    }
    ddinfo <- 0.25 * (ddisc^2)
    ddinfocap <- pmax(ddinfo, cap)
    ddinfose <- 1/sqrt(ddinfocap)
  }
  a <- as.data.frame(a[, 1:2])
  colnames(a) <- c("a1", "a2")
  diff <- as.data.frame(diff)
  for (i in ncol(diff)){
    colnames(diff) <- paste("d", 1:i, sep = "")
  }
  mdiff <- as.data.frame(mdiff)
  for (i in ncol(mdiff)){
    colnames(mdiff) <- paste("MDIFF", 1:i, sep = "")
  }
  disc <- as.data.frame(mdisc)
  info <- as.data.frame(info)
  infose <- as.data.frame(infose)
  colnames(info) <- c("Info")
  colnames(infose) <- c("SE")
  if (length(modid) == 2){
    colnames(disc) <- c("DISC")
  } else {
    colnames(disc) <- c("MDISC")
  }
  dcos <- as.data.frame(dcos)
  colnames(dcos) <- c("Cos X", "Cos Y", "Cos Z")
  pol<- as.data.frame(pol)
  colnames(pol) <- c("Theta")
  if (ndiff == 1){
    dir.vec <- vector1
    scal.vec <- vector2
  } else {
    dir.vec <- split.data.frame(vector1, cut(seq_len(nrow(vector1)), ndiff))
    scal.vec <- split.data.frame(vector2, cut(seq_len(nrow(vector2)), ndiff))
  }
  if (!is.null(con.items) || !is.null(con.pol)){
    ncos <- as.data.frame(ncos)
    colnames(ncos) <- c("Cos X","Cos Y", "Cos Z")
    cpol <- as.data.frame(cpol)
    colnames(cpol) <- c("Theta")
    for (i in nrow(cpol)){
      rownames(cpol) <- paste("C", 1:i, sep = "")
    }
    ddisc <- as.data.frame(ddisc)
    ddinfo <- as.data.frame(ddinfo)
    ddinfose <- as.data.frame(ddinfose)
  for (i in ncol(ddisc)){
    colnames(ddisc) <- paste("DDISC", 1:i, sep = "")
  }
  for (i in ncol(ddinfo)){
    colnames(ddinfo) <- paste("Info", 1:i, sep = "")
  }
  for (i in ncol(ddinfose)){
    colnames(ddinfose) <- paste("SE", 1:i, sep = "")
  }
}

  if (!is.null(con.items)){
    D2mirt <- list(loadings = a, modid = modid, diff = diff, disc = disc, info = info, infose = infose, mdiff = mdiff, dir.cos = dcos, angles = pol, c.dir.cos = ncos , c.pol = cpol, ddisc = ddisc,
                   dir.vec = dir.vec, scal.vec = scal.vec, con.items = con.items,  c.vec = con, ddinfo = ddinfo, ddinfose = ddinfose, fscores = trait)
  } else if (!is.null(con.pol)){
    D2mirt <- list(loadings = a, modid = modid, diff = diff, disc = disc, info = info, infose = infose, mdiff = mdiff, dir.cos = dcos, angles = pol, c.dir.cos = ncos , c.pol = cpol, ddisc = ddisc,
                   dir.vec = dir.vec, scal.vec = scal.vec, con.pol = con.pol,  c.vec = con, ddinfo = ddinfo, ddinfose = ddinfose, fscores = trait)
  } else if (!is.null(trait)) {
    D2mirt <- list(loadings = a, modid = modid, diff = diff, disc = disc, info = info, infose = infose, mdiff = mdiff, dir.cos = dcos, angles = pol, diff = diff,
                   dir.vec = dir.vec, scal.vec = scal.vec, fscores = trait)
  } else {
    D2mirt <- list(loadings = a, modid = modid, diff = diff, disc = disc, info = info, infose = infose, mdiff = mdiff, dir.cos = dcos, angles = pol, diff = diff,
                   dir.vec = dir.vec, scal.vec = scal.vec)
  }
  class(D2mirt) <- "D2mirt"
  D2mirt
}
