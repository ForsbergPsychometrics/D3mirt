#' 3D DMIRT Model Estimation
#'
#' @description Descriptive multidimensional item response theory model estimation (DMIRT; Reckase, 2009, 1985, Reckase and McKinley, 1991) for dichotomous and polytomous items restricted to three dimensions.
#'
#' @param x A data frame with items in rows and model parameters in columns containing raw response data as integer values or factor loadings.
#' Input can also be an S4 object of class 'SingleGroupClass' exported from [mirt::mirt] (Chalmers, 2012).
#' Regarding the data frame, the number of columns must be more than or equal to 4, i.e., three columns with (\emph{a}) parameters and at least one column for difficulty (\emph{d}) parameters.
#' @param modid Use either the two model identification items from [D3mirt::modid] as a combined vector or use nested list of item indicators to fit an orthogonal model (see examples below).
#' The default is `modid = NULL`.
#' @param model The user has the option of imputing a model specification schema used in the call to [mirt::mirt] (Chalmers, 2012).
#' The default is `model = NULL`.
#' @param con.items Optional. Nested lists with integer values as item indicators to identify constructs. The default is `con.items = NULL`.
#' @param con.sphe Optional. Nested lists of spherical angles to identify constructs. The default is `con.sphe = NULL`.
#' @param itemtype What item type to use in the function call. Available options are `"2PL"` and `"graded"`. The default is `itemtype = "graded"`.
#' @param method.mirt Estimation algorithm for [mirt::mirt] (Chalmers, 2012) to fit the model. The default is `method.mirt = "QMCEM"`.
#' @param method.fscores Factor estimation algorithm for [mirt::fscores] (Chalmers, 2012) for extracting respondent trait scores. The default is `method.fscores = "EAP"`.
#' @param QMC Integration method for [mirt::fscores] (Chalmers, 2012). The default is `QMC = TRUE`.
#'
#' @importFrom mirt mirt
#' @importFrom mirt fscores
#' @importFrom mirt coef
#'
#' @details The `D3mirt()` function takes in model parameters from a compensatory three-dimensional multidimensional two-parameter logistic model (M2PL) or a multidimensional graded
#' response model (MGRM), either in the form of a data frame with item data, or a data frame with factor loadings or an S4 object of class 'SingleGroupClass' exported from [mirt::mirt] (Chalmers, 2012) function fitted in accordance with descriptive item response theory model specifications (see package vignette).
#' The function returns DMIRT estimates that can be visualized with [D3mirt::plot] that graph vector arrows representing item response characteristics in a three-dimensional space.
#' Regarding the former, this includes visualization of the single multidimensional discrimination (MDISC) parameter and the multidimensional difficulty (MDIFF) parameters (Reckase, 2009, 1985; Reckase & McKinley, 1991).
#' The function also returns respondent trait scores that can be plotted with [D3mirt::plot] as spheres located in the three-dimensional latent space.
#' In turn, this allows for studying respondent profiles using the plot function (for more on profiles, see function documentation on [D3mirt::plot]).
#'
#' There are two types of models available for D3mirt analysis. The default model is the basic DMIRT model (Reckase, 2009, 1985, Reckase & McKinley, 1991), based on the MDISC, that relaxes the assumption of unidimensionality in the items while restricting the latent space to be orthogonal.
#' To use the default option requires first selecting two items to identify the model. This can be done manually with the `modid` argument in the function call to `D3mirt`.
#' However, it is advisable to use the dedicated function [D3mirt::modid] included in the package for this purpose (for more on model identification see function documentation for [D3mirt::modid]).
#' In contrast, the optional orthogonal model constrains the items to be strictly parallel with the axes (see example section below).
#' Consequently, this option allows the user to investigate the model under the assumption that the items are strictly unidimensional and orthogonally oriented in the latent space.
#' In this context "orthogonal" refers to the perpendicular orientation of the item vectors the model specification creates.
#' Note that using the optional model will result in reporting unidimensional discrimination parameters (DISC) and the shift in item orientation will affect respondent locations in the latent space.
#' It is also possible to specify a unique model with the help of the `model` argument in the function call to `D3mirt` if written in mirt (Chalmers, 2012) syntax (for an example, see the appendix in the package vignette).
#'
#' The user also has the option of including constructs in the estimation.
#' Constructs, in this context, refer to the assumption that a subset of items or a particular angle in the latent space holds some higher-order latent variable of interest.
#' Constructs are visualized when plotting as solid black arrows running across the model space.
#' In addition, if constructs are used, the output will also contain the directional discrimination (DDISC) parameters for all items assessed in the direction indicated by the construct vectors.
#' This makes it possible to compare item discrimination under the assumption that the items are unidimensional, measuring the same latent variable indicated by the angle of the construct vector.
#'
#' To include constructs, the user can create one or more nested lists that indicate what items belong to what construct (from one item to all items in the set; see the examples section below).
#' From this, the `D3mirt()` function calculates the average direction by adding and normalizing the direction cosines using the items in the nested lists.
#' Constructs can also be indicated using spherical coordinates stored in nested lists.
#' This allows the user to freely add any number of constructs at any angle in the latent space to study the item discrimination.
#'
#' For more on theory and how to interpret statistical estimates, please see the package vignette.
#'
#'
#'
#' @return A S3 object of class `D3mirt` with lists of \emph{a} and \emph{d} parameters from the M2PL or MGRM estimation, multidimensional difficulty (MDIFF), multidimensional discrimination (MDISC), direction cosines and degrees for vector angles, construct lists, vector coordinates, and respondent trait scores.
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
#' # Call to D3mirt(), including optional nested lists for three constructs
#' # Item W7Q16 is not included in any construct because of model violations
#' # Constructs can also be defined using interval notation, i.e., c(1:10) and so on.
#'
#' con <- list(c(1,2,3,4,5,6,7,8,9,10),
#'             c(11,12,13,14),
#'             c(15,17,18,19,20))
#' mod <- D3mirt(x, modid = c("W7Q3", "W7Q20"), con.items = con)
#'
#' # Show summary of results
#' summary(mod)
#'
#' # Call to D3mirt(), including optional constructs with the help of spherical coordinates
#' # Spherical coordinates are indicated using nested list structures with angles
#' # First angle indicates the rotation in the xz-plane
#' # The second angle is the angle away from the y-axis.
#' # The specification below indicates three constructs located at a 45-degree angle
#' # between the three axes in the positive orientation.
#' # It is possible to assign factor loadings and difficulty parameters from mod to a new data frame
#' # This skips fitting the compensatory model and makes fitting the model with D3mirt() instant
#' # Note that trait scores will not be included in the exported S3 object when using this option
#' y <- cbind(mod$loadings, mod$diff)
#' con <- list(c(0, 45),
#'             c(45, 90),
#'             c(90, 45))
#' mod <- D3mirt(y, con.sphe = con)
#'
#' # Show summary of results
#' summary(mod)
#'
#' # Call D3mirt() using the orthogonal optional model
#' # often requires removing items with poor fit
#' # In this example item W7Q16 is removed from the data frame
#' y <- data.frame(x[,-16])
#'
#' # Items are constrained to the x, y, and z-axes using
#' # nested lists with positive integers as item indicators
#' # Note that integers indicate where the items are located in the data frame
#' mod <- D3mirt(y, modid = list(c(1:10),
#'                             c(15:19),
#'                             c(11:14)))
#'
#' # Show summary of results
#' summary(mod)
#' }
#' @export
D3mirt <- function(x, modid = NULL, model = NULL, con.items = NULL, con.sphe = NULL, itemtype = "graded", method.mirt = "QMCEM", method.fscores = "EAP", QMC = TRUE){
  if (!(itemtype == "graded" || itemtype == "2PL")) stop("The item model must be GRM or 2PL")
  if (!is.null(con.items) && !is.null(con.sphe)) stop("Use either items or spherical coordinates for constructs, not both")
  if (isS4(x)){
    trait <- mirt::fscores(x, method = method.fscores, full.scores = TRUE, full.scores.SE = FALSE, QMC = TRUE)
    k <- x@Data$K[1]-1
    x <- data.frame(mirt::coef(x, simplify=TRUE)$"items"[,1:(3+k)])
    x <- as.matrix(x)
  } else if (any(!x == round(x))){
    x <- as.matrix(x)
    trait <-  NULL
  } else {
    if(!is.null(modid)){
      if (length(modid) > 3) stop("The model identification argument contains too many elements")
      if (length(modid) < 2) stop("The model identification argument contains too few elements")
      mod <- NULL
      mod <- c(paste("F1 = 1 -", ncol(x), "\n",
                     paste("F2 = 1 -", ncol(x), "\n"),
                     paste("F3 = 1 -", ncol(x), "\n")))
      if (length(modid) == 2) {
        t <- c(paste("START=(", modid[1], ", a2, 0)", "\n"),
               paste("START=(", modid[1], ", a3, 0)", "\n"),
               paste("START=(", modid[2], ", a3, 0)", "\n"),
               paste("FIXED=(", modid[1], ", a2)", "\n"),
               paste("FIXED=(", modid[1], ", a3)", "\n"),
               paste("FIXED=(", modid[2], ", a3)", "\n"))
      }
      if (length(modid) == 3) {
        t <- NULL
        l1 <- unlist(modid[1])
        l2 <- unlist(modid[2])
        l3 <- unlist(modid[3])
        for (i in seq_along(l1)){
          t <-append(t, paste("START=(", colnames(x[l1[i]]), ", a2, 0)", "\n"))
          t <-append(t, paste("START=(", colnames(x[l1[i]]), ", a3, 0)", "\n"))
          t <-append(t, paste("FIXED=(", colnames(x[l1[i]]), ", a2)", "\n"))
          t <-append(t, paste("FIXED=(", colnames(x[l1[i]]), ", a3)", "\n"))
        }
        for (i in seq_along(l2)){
          t <-append(t, paste("START=(", colnames(x[l2[i]]), ", a1, 0)", "\n"))
          t <-append(t, paste("START=(", colnames(x[l2[i]]), ", a3, 0)", "\n"))
          t <-append(t, paste("FIXED=(", colnames(x[l2[i]]), ", a1)", "\n"))
          t <-append(t, paste("FIXED=(", colnames(x[l2[i]]), ", a3)", "\n"))
        }
        for (i in seq_along(l3)){
          t <-append(t, paste("START=(", colnames(x[l3[i]]), ", a1, 0)", "\n"))
          t <-append(t, paste("START=(", colnames(x[l3[i]]), ", a2, 0)", "\n"))
          t <-append(t, paste("FIXED=(", colnames(x[l3[i]]), ", a1)", "\n"))
          t <-append(t, paste("FIXED=(", colnames(x[l3[i]]), ", a2)", "\n"))
        }
      }
      mod <- append(mod, t)
      model <- paste(mod, sep="",collapse="")
    }
    if (is.null(model)) stop("The model must be identified, use model identification items or constrain all items to parallell with the axes")
    if (length(unique(x[, 1])) > 2 && itemtype == "2PL") stop("Use the GRM as item model if the items have more than two response options")
    if (length(unique(x[, 1])) == 2 && itemtype == "graded") warning("Use the 2PL as item model if the items have two response options")
    x <- mirt::mirt(x, model = model, itemtype = itemtype, SE = TRUE, method = method.mirt)
    trait <- mirt::fscores(x, method = method.fscores, full.scores = TRUE, full.scores.SE = FALSE, QMC = QMC)
    k <- x@Data$K[1]-1
    x <- data.frame(mirt::coef(x, simplify=TRUE)$"items"[,1:(3+k)])
    x <- as.matrix(x)
  }
  if (ncol(x) < 4) stop("The data frame must have at least 4 columns")
  a <- x[, 1:3, drop = FALSE]
  ndiff <- ncol(x)-3
  diff <- x[, (4):(3+ndiff), drop = FALSE]
  mdisc <- sqrt(rowSums(a^2))
  md <- mdisc%*%matrix(rep(1,3), nrow=1, ncol=3)
  dcos <- as.matrix(a/md, ncol = 3)
  theta <- NULL
  for (i in seq(nrow(dcos))){
    c <- dcos[i, 1]
    d <- dcos[i, 3]
    if (c < 0 && d >= 0){
      t <- 180 + atan(dcos[i,3]/dcos[i,1])*(180/pi)
      theta <- as.matrix(rbind(theta, t), ncol = 1)
    } else if (c < 0 && d < 0){
      t <- -180 + atan(dcos[i,3]/dcos[i,1])*(180/pi)
      theta <- as.matrix(rbind(theta, t), ncol = 1)
    } else {
      t <- atan(dcos[i,3]/dcos[i,1])*(180/pi)
      theta <- as.matrix(rbind(theta, t), ncol = 1)
    }
  }
  phi <- acos(dcos[,2])*(180/pi)
  sph <- cbind(theta, phi)
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
    csph <- NULL
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
      for (i in seq(nrow(cdcos))){
        c <- cdcos[i,1]
        d <- cdcos[i,3]
        if (c < 0 && d >= 0){
          t <- 180 + atan(cdcos[i,3]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        } else if (c < 0 && d < 0){
          t <- -180 + atan(cdcos[i,3]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        } else {
          t <- atan(cdcos[i,3]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        }
      }
      phi <- acos(cdcos[,2])*(180/pi)
      sphe <- cbind(theta, phi)
      csph <- as.matrix(rbind(csph,sphe), ncol = 2)
      disc <-  apply(a, 1, function(x) x %*% t(cdcos))
      ddisc <- as.matrix(cbind(ddisc, disc), ncol = 1)
    }
  }
  if (!is.null(con.sphe)){
    if(!is.list(con.sphe)) stop("The speherical coordinates for constructs must be of type list")
    con <- NULL
    csph <- NULL
    ncos <- NULL
    cdcos <- NULL
    ddisc <- NULL
    for (i in seq_along(con.sphe)){
      l <- unlist(con.sphe[i])
      if(l[1] > 180) stop("The theta angle must be between +/- 180 degrees")
      if(l[1] < -180) stop("The theta angle must be between +/- 180 degrees")
      if(l[2] > 180) stop("The phi angle must be between 0 and 180 degrees")
      if(l[2] < 0) stop("The phi angle must be between 0 and 180 degrees")
      r <- l[1]*(pi/180)
      t <- l[2]*(pi/180)
      j <- sin(t)*cos(r)
      k <- sin(t)*sin(r)
      m <- cos(t)
      cdcos <- as.matrix(cbind(j,m,k), ncol = 3)
      maxnorm <- (1.1*max(vector1))*cdcos
      minnorm <- (0.6*min(vector1))*cdcos
      con <- as.matrix(rbind(con,rbind(minnorm, maxnorm)), ncol = 3)
      ncos <- as.matrix(rbind(ncos,cdcos), ncol = 3)
      theta <- NULL
      for (i in seq(nrow(cdcos))){ # finns bara en rad i cdcos?
        c <- cdcos[i,1]
        d <- cdcos[i,3]
        if (c < 0 && d >= 0){
          t <- 180 + atan(cdcos[i,3]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        } else if (c < 0 && d < 0){
          t <- -180 + atan(cdcos[i,3]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        } else {
          t <- atan(cdcos[i,3]/cdcos[i,1])*(180/pi)
          theta <- as.matrix(rbind(theta, t), ncol = 1)
        }
      }
      phi <- acos(cdcos[,2])*(180/pi)
      sphe <- cbind(theta, phi)
      csph <- as.matrix(rbind(csph,sphe), ncol = 2)
      disc <-  apply(a, 1, function(x) x %*% t(cdcos))
      ddisc <- as.matrix(cbind(ddisc, disc), ncol = 1)
    }
  }
  a <- as.data.frame(a)
  for (i in ncol(a)){
    colnames(a) <- paste("a", 1:i, sep = "")
  }
  diff <- as.data.frame(diff)
  for (i in ncol(diff)){
    colnames(diff) <- paste("d", 1:i, sep = "")
  }
  mdiff <- as.data.frame(mdiff)
  for (i in ncol(mdiff)){
    colnames(mdiff) <- paste("MDIFF", 1:i, sep = "")
  }
  disc <- as.data.frame(mdisc)
  if (length(modid) == 2){
    colnames(disc) <- c("MDISC")
  }
  if (length(modid) == 3){
    colnames(disc) <- c("DISC")
  }
  dcos <- as.data.frame(dcos)
  colnames(dcos) <- c("Cos X", "Cos Y", "Cos Z")
  sph <- as.data.frame(sph)
  colnames(sph) <- c("Theta", "Phi")
  if (ndiff == 1){
    dir.vec <- vector1
    scal.vec <- vector2
  } else {
    dir.vec <- split.data.frame(vector1, cut(seq_len(nrow(vector1)), ndiff))
    scal.vec <- split.data.frame(vector2, cut(seq_len(nrow(vector2)), ndiff))
  }
  if (!is.null(con.items) || !is.null(con.sphe)){
    ncos <- as.data.frame(ncos)
    colnames(ncos) <- c("Cos X","Cos Y", "Cos Z")
    csph <- as.data.frame(csph)
    colnames(csph) <- c("Theta", "Phi")
    for (i in nrow(csph)){
      rownames(csph) <- paste("C", 1:i, sep = "")
    }
    ddisc <- as.data.frame(ddisc)
    for (i in ncol(ddisc)){
      colnames(ddisc) <- paste("DDISC", 1:i, sep = "")
    }
  }
  if (!is.null(con.items)){
    D3mirt <- list(loadings = a, modid = modid, diff = diff, disc = disc, mdiff = mdiff, dir.cos = dcos, angles = sph, c.dir.cos = ncos , c.spherical = csph, ddisc = ddisc,
                   dir.vec = dir.vec, scal.vec = scal.vec, con.items = con.items,  c.vec = con, fscores = trait)
  } else if (!is.null(con.sphe)){
    D3mirt <- list(loadings = a, modid = modid, diff = diff, disc = disc, mdiff = mdiff, dir.cos = dcos, angles = sph, c.dir.cos = ncos , c.spherical = csph, ddisc = ddisc,
                   dir.vec = dir.vec, scal.vec = scal.vec, con.sphe = con.sphe,  c.vec = con, fscores = trait)
  } else if (!is.null(trait)) {
    D3mirt <- list(loadings = a, modid = modid, diff = diff, disc = disc, mdiff = mdiff, dir.cos = dcos, angles = sph, diff = diff,
                   dir.vec = dir.vec, scal.vec = scal.vec, fscores = trait)
  } else {
    D3mirt <- list(loadings = a, modid = modid, diff = diff, disc = disc, mdiff = mdiff, dir.cos = dcos, angles= sph, diff = diff,
                   dir.vec = dir.vec, scal.vec = scal.vec)
  }
  class(D3mirt) <- "D3mirt"
  D3mirt
}
