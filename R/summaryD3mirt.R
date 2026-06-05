#' Summary Method for S3 Objects of Class `D3mirt`
#'
#' @description The summary method for the [D3mirt::D3mirt()] function.
#' @param object A S3 object of class `D3mirt`.
#' @param ... Additional arguments.
#' @param digits The number of digits shown per estimate. The default is `digits = 4`.
#'
#' @return Tables containing \emph{a} and \emph{d} parameters, multidimensional discrimination (MDISC), multidimensional item difficulty (MDIFF), direction cosines, and degrees for vector angles for items.
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
#' # Call D3mirt() with constructs
#' con <- list(c(1,2,3,4,5,6,7,8,9,10),
#'             c(11,12,13,14),
#'             c(15,17,18,19,20))
#' mod <- D3mirt(x, modid = c("W7Q3", "W7Q20"), con.items = con)
#'
#' # Call to summary
#' summary(mod)
#'
#' #' # Call to summary rounded off to 2 digits
#' summary(mod, digits = 2)
#' }
#' @export
summary.D3mirt <- function(object, ..., digits = 4){
  tab1 <- as.data.frame(object$loadings)
  tab2 <- as.data.frame(object$diff)
  tab1 <- as.data.frame(cbind(tab1, tab2))
  tab3 <- as.data.frame(object$mdiff)
  tab4 <- as.data.frame(object$disc)
  tab4 <- as.data.frame(cbind(tab4, tab3))
  tab5 <- as.data.frame(cbind(object$dir.cos, object$angles))
  if (length(object$diff) > 1){
    cat(paste("\nD3mirt:", nrow(tab1), "items and", ncol(tab2), "levels of difficulty\n\n"))
  } else {
    cat(paste("\nD3mirt:", nrow(tab1), "items and", ncol(tab2), "level of difficulty\n\n"))
  }
  if (length(object$modid) == 2 ){
    cat(paste("Compensatory model\n"))
    cat(paste("Model identification items: ", paste(object$modid[1],", ", sep = ""), paste (object$modid[2], sep = "") , "\n\n", sep = ""))
  }
  if (length(object$modid) > 2 ){
    cat(paste("Orthogonal model\n"))
    for (i in seq_along(object$modid)){
      n <- unlist(object$modid[i])
      z <- as.character(rownames(tab1[n, ]))
      cat(paste("Item vector ", i, ": ", paste(z, collapse=", ", sep = ""), "\n", sep = ""))
    }
    cat(paste("\n"))
  }
  if (!is.null(object$c.dir.cos)){
    tab6 <- as.data.frame(cbind(object$c.dir.cos, object$c.spherical))
    tab7 <- as.data.frame(cbind(object$ddisc))
    if (!is.null(object$con.items)){
      cat(paste("Constructs\n"))
      for (i in seq_along(object$con.items)){
        n <- unlist(object$con.items[i])
        z <- as.character(rownames(tab1[n, ]))
        cat(paste("Item vector ", i, ": ", paste(z, collapse=", ", sep = ""), "\n", sep = ""))
      }
      cat(paste("\n"))
    }
    if (!is.null(object$con.sphe)){
      cat(paste("Constructs\n"))
      for (i in seq_along(object$con.sphe)){
        n <- unlist(object$con.sphe[i])
        cat(paste("Spherical coordinate vector ", i, ": ", paste(n[1], ", ", collapse="", sep = ""), paste(n[2], collapse="", sep = ""), "\n", sep = ""))
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
