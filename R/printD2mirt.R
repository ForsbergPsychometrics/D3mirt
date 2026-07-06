#' Print Method for S3 Objects of Class `D2mirt`
#'
#' @description The print method for the [D3mirt::D2mirt()] function.
#' @param x A S3 object of class `D2mirt`.
#' @param ... Additional arguments.
#'
#' @return A printed message reporting the number of items, levels of difficulty, the number of construct vectors, and the names of the respective items contained in each construct.
#' @author Erik Forsberg
#'
#' @examples
#' \dontrun{
#' # Load data
#' data("anes0809offwaves")
#' x <- anes0809offwaves
#' x <- x[, 3:22] # Remove columns for age and gender
#'
#' # Call D2mirt()
#' mod <- D2mirt(x, modid = c("W7Q3", "W7Q20"))
#'
#' # Print model summary
#' print(mod)
#' }
#' @export
print.D2mirt <- function(x, ...){
  tab1 <- as.data.frame(x$loadings)
  tab2 <- as.data.frame(x$diff)
  tab1 <- as.data.frame(cbind(tab1, tab2))
  if (length(x$diff) > 1){
    cat(paste("\nD2mirt:", nrow(tab1), "items and", length(tab2), "levels of difficulty\n\n"))
    } else {
    cat(paste("\nD2mirt:", nrow(tab1), "items and", length(tab2), "level of difficulty\n\n"))
    }
  if (length(x$modid) == 1 ){
    cat(paste("Compensatory model\n"))
    cat(paste("Model identification item: ", paste(x$modid[1], sep = ""), "\n\n", sep = ""))
  }
  if (length(x$modid) > 1 ){
    cat(paste("Orthogonal model\n"))
    for (i in seq_along(x$modid)){
      n <- unlist(x$modid[i])
      z <- as.character(rownames(tab1[n, ]))
      cat(paste("Item vector ", i, ": ", paste(z, collapse=", ", sep = ""), "\n", sep = ""))
    }
  }
    if (!is.null(x$con.items)){
    cat(paste("Constructs\n"))
    for (i in seq_along(x$con.items)){
      n <- unlist(x$con.items[i])
      z <- as.character(rownames(tab1[n, ]))
        cat(paste("Item vector ", i, ": ", paste(z, collapse=", ", sep = ""), "\n", sep = ""))
  }
  }
   if (!is.null(x$con.sphe)){
      cat(paste("Constructs\n"))
      for (i in seq_along(x$con.sphe)){
        n <- unlist(x$con.sphe[i])
          cat(paste("Polar coordinate vector ", i, ": ", paste(n[1], ", ", collapse="", sep = ""), paste(n[2], collapse="", sep = ""), "\n", sep = ""))
      }
  }
  cat(paste("\n"))
}
