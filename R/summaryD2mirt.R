#' Summary Method for S3 Objects of Class `D2mirt`
#'
#' @description The summary method for the [D3mirt::D2mirt()] function.
#' @param object A S3 object of class `D2mirt`.
#' @param digits The number of digits shown per estimate. The default is `digits = 4`.
#' @param ... Additional arguments.
#'
#' @return A brief model description followed by tables containing \emph{a} and \emph{d} parameters, multidimensional discrimination (MDISC), multidimensional item difficulty (MDIFF), direction cosines, and degrees for vector angles for items.
#' If constructs were used in the estimation process, the summary function will also show tables for direction cosines, degrees for construct vectors, and directional discrimination (DDISC) parameters.
#'
#' @author Erik Forsberg
#' @examples
#' \dontrun{
#' # Load data
#' data("anes0809offwaves")
#' x <- anes0809offwaves
#' x <- x[, 3:22] # Remove columns for age and gender
#'
#' # Call D2mirt()
#' mod <- D2mirt(x, modid = "W7Q10")
#'
#' # Call to summary
#' summary(mod)
#'
#' #' # Call to summary rounded off to 2 digits
#' summary(mod, digits = 2)
#' }
#' @export
summary.D2mirt <- function(object, digits = 4, ...){
  tab1 <- as.data.frame(object$loadings)
  tab2 <- as.data.frame(object$diff)
  tab1 <- as.data.frame(cbind(tab1, tab2))
  tab3 <- as.data.frame(object$mdiff)
  tab4 <- as.data.frame(object$disc)
  tab4 <- as.data.frame(cbind(tab4, tab3))
  tab5 <- as.data.frame(object$dir.cos)
  tab5 <- as.data.frame(cbind(tab5[, 1:2], object$angles))
  if (length(object$diff) > 1){
    cat(paste("\nD2mirt:", nrow(tab1), "items and", ncol(tab2), "levels of difficulty\n\n"))
  } else {
    cat(paste("\nD2mirt:", nrow(tab1), "items and", ncol(tab2), "level of difficulty\n\n"))
  }
  if (length(object$modid) == 1 ){
    cat(paste("Compensatory model\n"))
    cat(paste("Model identification item: ", paste(object$modid[1], sep = ""), "\n\n", sep = ""))
  }
  if (length(object$modid) > 1 ){
    cat(paste("Orthogonal model\n"))
    for (i in seq_along(object$modid)){
      n <- unlist(object$modid[[i]])
      z <- rownames(tab1)[n]
      cat(paste("Item vector ", i, ": ", paste(z, collapse=", ", sep = ""), "\n", sep = ""))
    }
    cat(paste("\n"))
  }
  if (!is.null(object$c.dir.cos)){
    cdcos <- object$c.dir.cos
    tab6 <- as.data.frame(cbind(cdcos[, 1:2], object$c.pol))
    tab7 <- as.data.frame(cbind(object$ddisc))
    if (!is.null(object$con.items)){
      cat(paste("Constructs\n"))
      for (i in seq_along(object$con.items)){
        n <- unlist(object$con.items[[i]])
        z <- rownames(tab1)[n]
        cat(paste("Item vector ", i, ": ", paste(z, collapse=", ", sep = ""), "\n", sep = ""))
      }
      cat(paste("\n"))
    }
    if (!is.null(object$con.pol)){
      cat(paste("Constructs\n"))
      for (i in seq_along(object$con.pol)){
        n <- unlist(object$con.pol[[i]])
        cat(paste0("Polar coordinate vector ", i, ": ", round(n, 4), "\n"))
      }
    }
    cat(paste("\n"))
  }
  if (!is.null(object$c.dir.cos)){
    print(round(tab1,digits))
    cat(paste("\n"))
    print(round(tab4,digits))
    cat(paste("\n"))
    print(round(tab5, digits))
    cat(paste("\n"))
    print(round(tab6, digits))
    cat(paste("\n"))
    print(round(tab7, digits))
  } else {
    print(round(tab1,digits))
    cat(paste("\n"))
    print(round(tab4,digits))
    cat(paste("\n"))
    print(round(tab5, digits))
  }
}
