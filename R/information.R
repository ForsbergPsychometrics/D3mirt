#' Item Information and Standard Errors
#'
#' @description A information and standard error analysis function for [D3mirt::D3mirt()] and [D3mirt::D2mirt()].
#' @param x An x of class `D3mirt` or `D2mirt`.
#' @param CI Critical value for the confidence interval based on percentage. The default is `CI = 0.95`.
#' @param digits The number of digits shown per estimate. The default is `digits = 4`.
#' @param ... Additional arguments.
#'
#' @importFrom stats median qnorm sd
#'
#' @details The `information()` function extracts item information and standard errors from S3 objects returned by `D3mirt()` or `D2mirt()`.
#' The number of decimal places in the output is controlled by the `digits` argument.
#'
#' Standard item information, denoted \eqn{I_i} for item \eqn{i}, is defined as
#'
#' \deqn{I_i(\theta) := P_i(\theta) Q_i(\theta)a_i^2,}
#'
#' where \eqn{P_i(\theta)} is the probability of a correct response and \eqn{Q_i(\theta)} the complement on ability \eqn{\theta}.
#' Taking measurement direction in account gives
#'
#' \deqn{I_i(\theta, \omega) := P_i(\theta) Q_i(\theta) \bigg ( \sum^n a_i \cos \omega \bigg )^2,}
#'
#' in which the summation is the DDISC index on \eqn{n} dimensions and measurement angle \eqn{\omega}.
#' The standard error represents the inverse of the information function and is defined as
#'
#' \deqn{SE(\hat{a}_i) := \frac{1}{\sqrt{I(\hat{a}_i)}},}
#'
#' in which \eqn{\hat{a}_i} is the discrimination estimator.
#' The MDISC and DDISC parameters are presented with an confidence interval based on the standard error, defined as
#'
#' \deqn{CI = \hat{a}_i \pm z \times SE(\hat{a}_i),}
#'
#' for critical value \eqn{z}, set by user.
#'
#' Note that MDISC estimates represent the maximum discrimination of an item at its optimal angle in the multidimensional space.
#' Because this orientation differs for every item, MDISC values are not directly comparable.
#' Consequently, summarizing MDISC estimates using measures of central tendency (such as the mean or median) can yield misleading interpretations if assumed to represent a sum of unidimensional information.
#' In contrast, DDISC estimates are projected onto a specific, fixed construct vector.
#' Because they are constrained to a single shared orientation, DDISC estimates—and their associated information values—can be meaningfully compared and aggregated under the assumption of unidimensionality.
#' It should also be mentioned that the calculation of the standard error is capped to avoid extreme value problems (see documentation in [D3mirt::D3mirt()] and [D3mirt::D2mirt()]).
#'
#'
#' @return A brief model description followed by descriptives for MDISC and DDISC constructs, such as total sum of information, and the arithmetic mean of item information and standard error.
#' Tables containing MDISC, DDISC, and standard errors for all items.
#'
#' @author Erik Forsberg
#' @examples
#' \dontrun{
#' # mod is an S3 x from D3mirt or D2mirt
#' information(mod)
#' }
#' @export
information <- function(x, CI = 0.95, digits = 4, ...) {
  UseMethod("information")
}
#' @export
information.D2mirt <- function(x, CI = 0.95, digits = 4, ...){
  alpha <- 1 - CI
  area <- alpha / 2
  z <- qnorm(1 - area)
    if (length(x$diff) > 1){
      cat(paste("\nD2mirt:", nrow(x$disc), "items and", ncol(x$mdiff), "levels of difficulty\n\n"))
    } else {
      cat(paste("\nD2mirt:", nrow(x$disc), "items and", ncol(x$mdiff), "level of difficulty\n\n"))
    }
    if (length(x$modid) == 1  || is.null(x$modid)){
      if (!is.null(x$modid)){
        cat(paste("Compensatory model\n"))
        cat(paste("Model identification item: ", paste(x$modid[1], sep = ""), "\n\n", sep = ""))
      }
      tab1 <- as.data.frame(x$disc)
      tab2 <- as.data.frame(x$info)
      tab3 <- as.data.frame(x$infose)
      tabci <- NULL
      for (i in seq(nrow(x$disc))){
        lb <- tab1[i, 1] - (z * tab3[i, 1])
        ub <- tab1[i, 1] + (z * tab3[i, 1])
        ci <- cbind(lb, ub)
        tabci <- rbind(tabci, ci)
      }
      colnames(tabci) <- c("CI Lower", "CI Upper")
      tab4 <- as.data.frame(cbind(tab1, tab2, tab3, tabci))
    }
    if (length(x$modid) > 1 ){
      cat(paste("Orthogonal model\n"))
      for (i in seq_along(x$modid)){
        n <- unlist(x$modid[i])
        m <- rownames(x$disc)[n]
        if (is.null(m)) {
          m <- paste0("Item ", seq_len(nrow(x$disc)))
        }
        cat(paste("Item vector ", i, ": ", paste(m, collapse=", ", sep = ""), "\n", sep = ""))
      }
      taba1 <- as.data.frame(x$loadings[, "a1", drop = FALSE])
      taba2 <- as.data.frame(x$loadings[, "a2", drop = FALSE])
      tab2 <- as.data.frame(x$info)
      tab3 <- as.data.frame(x$infose)
      tab4 <- as.data.frame(cbind(taba1, taba2, tab2, tab3))
      cat(paste("\n"))
    }
    if (!is.null(x$c.dir.cos)){
      cdcos <- x$c.dir.cos
      tab6 <- as.data.frame(cbind(cdcos[, 1:2], x$c.pol))
      tab7 <- as.data.frame(cbind(x$ddisc))
      if (!is.null(x$con.items)){
        cat(paste("Constructs\n"))
        for (i in seq_along(x$con.items)){
          n <- unlist(x$con.items[i])
          m <- rownames(x$disc)[n]
          if (is.null(m)) {
            m <- paste0("Item ", seq_len(nrow(x$loadings)))
          }
          cat(paste("Item vector ", i, ": ", paste(m, collapse=", ", sep = ""), "\n", sep = ""))
          }
      }
      if (!is.null(x$con.pol)){
        cat(paste("Constructs\n"))
        for (i in seq_along(x$con.pol)){
          n <- unlist(x$con.pol[i])
          cat(paste0("Polar coordinate vector ", i, ": ", round(n, 4), "\n"))
        }
      }
    }
  cat(paste("\n"))
  if (length(x$modid) == 1 || is.null(x$modid)) {
    info <- as.numeric(unlist(x$info))
    se   <- as.numeric(unlist(x$infose))
    sum_info    <- sum(info, na.rm = TRUE)
    mean_info   <- mean(info, na.rm = TRUE)
    sd_info <- sd(info, na.rm = TRUE)
    median_info <- median(info, na.rm = TRUE)
    mean_se <- mean(se, na.rm = TRUE)
    sd_se <- sd(se, na.rm = TRUE)
    median_se <- median(se, na.rm = TRUE)
    tab6 <- data.frame(sum_info, mean_info, sd_info, median_info, mean_se, sd_se, median_se)
    colnames(tab6) <- c("Sum Info", "Mean", "SD", "Median", "Mean SE", "SD SE", "Median SE")
    rownames(tab6) <- paste("Model", "")
    cat("MDISC Descriptives\n")
    print(round(tab6, digits))
  } else {
    n <- length(x$modid)
    sum_info    <- numeric(n)
    mean_info   <- numeric(n)
    sd_info   <- numeric(n)
    median_info <- numeric(n)
    mean_se     <- numeric(n)
    sd_se   <- numeric(n)
    median_se   <- numeric(n)
    for (i in seq_len(n)) {
      finfo <- as.numeric(unlist(x$info[!x$loadings[, i] == 0, 1]))
      fse   <- as.numeric(unlist(x$infose[!x$loadings[, i] == 0, 1]))
      sum_info[i]    <- sum(finfo, na.rm = TRUE)
      mean_info[i]   <- mean(finfo, na.rm = TRUE)
      sd_info[i] <- sd(finfo, na.rm = TRUE)
      median_info[i] <- median(finfo, na.rm = TRUE)
      mean_se[i]     <- mean(fse, na.rm = TRUE)
      sd_se[i]     <- sd(fse, na.rm = TRUE)
      median_se[i]   <- median(fse, na.rm = TRUE)
    }
    tab6 <- data.frame(sum_info, mean_info, sd_info, median_info, mean_se, sd_se, median_se)
    colnames(tab6) <- c("Sum Info", "Mean", "SD", "Median", "Mean SE", "SD SE", "Median SE")
    rownames(tab6) <- paste("Dimension", seq_len(n))
    cat("DISC Descriptives\n")
    print(round(tab6, digits))
  }
  cat(paste("\n"))
  if (!is.null(x$ddisc)){
    n <- length(x$ddisc)
    sum_info    <- numeric(n)
    mean_info   <- numeric(n)
    sd_info   <- numeric(n)
    median_info <- numeric(n)
    mean_se     <- numeric(n)
    sd_se   <- numeric(n)
    median_se   <- numeric(n)
    for (i in seq_len(n)) {
      finfo <- as.numeric(unlist(x$ddinfo[, i]))
      fse   <- as.numeric(unlist(x$ddinfose[, i]))
      sum_info[i]    <- sum(finfo, na.rm = TRUE)
      mean_info[i]   <- mean(finfo, na.rm = TRUE)
      sd_info[i] <- sd(finfo, na.rm = TRUE)
      median_info[i] <- median(finfo, na.rm = TRUE)
      mean_se[i]     <- mean(fse, na.rm = TRUE)
      sd_se[i]     <- sd(fse, na.rm = TRUE)
      median_se[i]   <- median(fse, na.rm = TRUE)
    }
    tab7 <- data.frame(sum_info, mean_info, sd_info, median_info, mean_se, sd_se, median_se)
    colnames(tab7) <- c("Sum Info", "Mean", "SD", "Median", "Mean SE", "SD SE", "Median SE")
    rownames(tab7) <- paste("Construct", seq_len(n))
    cat("DDISC Descriptives\n")
    print(round(tab7, digits))
  }
  cat(paste("\n"))
  print(round(tab4,digits))
  if (!is.null(x$ddisc)){
    tab1 <- as.data.frame(x$ddisc)
    tab2 <- as.data.frame(x$ddinfose)
    tabd <- NULL
    for (j in seq(ncol(x$ddisc))){
      tabci <- NULL
      tabd1 <- as.data.frame(tab1[, j])
      tabd2 <- as.data.frame(tab2[, j])
      for (i in seq(nrow(x$disc))){
        lb <- tabd1[i, 1] - (z * tabd2[i, 1])
        ub <- tabd1[i, 1] + (z * tabd2[i, 1])
        ci <- cbind(lb, ub)
        tabci <- rbind(tabci, ci)
      }
      tabd <- cbind(tabd, tabci)
    }
      tab5 <- do.call(cbind, lapply(seq_along(x$ddisc), function(i) {
        cbind(x$ddisc[[i]], x$ddinfo[[i]], x$ddinfose[[i]], tabd[, (i * 2) - 1], tabd[, (i * 2)])
      }))
      colnames(tab5) <- as.vector(outer(
        c("DDISC ", "Info ", "SE ", "CI Lower ", "CI Upper "),
        1:ncol(x$ddisc),
        paste0
      ))
      rownames(tab5) <- rownames(x$disc)
  cat(paste("\n"))
  print(round(tab5,digits))
  }
}
#' @export
information.D3mirt <- function(x, CI = 0.95, ..., digits = 4){
  alpha <- 1 - CI
  area <- alpha / 2
  z <- qnorm(1 - area)
    if (length(x$diff) > 1){
      cat(paste("\nD3mirt:", nrow(x$disc), "items and", ncol(x$mdiff), "levels of difficulty\n\n"))
    } else {
      cat(paste("\nD3mirt:", nrow(x$disc), "items and", ncol(x$mdiff), "level of difficulty\n\n"))
    }
    if (length(x$modid) == 2 || is.null(x$modid)){
      if (!is.null(x$modid)){
        cat(paste("Compensatory model\n"))
        cat(paste("Model identification items: ", paste(x$modid[1],", ", sep = ""), paste (x$modid[2], sep = "") , "\n\n", sep = ""))
      }
      tab1 <- as.data.frame(x$disc)
      tab2 <- as.data.frame(x$info)
      tab3 <- as.data.frame(x$infose)
      tabci <- NULL
      for (i in seq(nrow(x$disc))){
        lb <- tab1[i, 1] - (z * tab3[i, 1])
        ub <- tab1[i, 1] + (z * tab3[i, 1])
        ci <- cbind(lb, ub)
        tabci <- rbind(tabci, ci)
      }
      colnames(tabci) <- c("CI Lower", "CI Upper")
      tab4 <- as.data.frame(cbind(tab1, tab2, tab3, tabci))
    } else if (length(x$modid) > 2 ){
      cat(paste("Orthogonal model\n"))
      for (i in seq_along(x$modid)){
        n <- unlist(x$modid[i])
        m <- rownames(x$disc)[n]
        if (is.null(m)) {
          m <- paste0("Item ", seq_len(nrow(x$disc)))
        }
        cat(paste("Item vector ", i, ": ", paste(m, collapse=", ", sep = ""), "\n", sep = ""))
      }
      taba1 <- as.data.frame(x$loadings[, "a1", drop = FALSE])
      taba2 <- as.data.frame(x$loadings[, "a2", drop = FALSE])
      taba3 <- as.data.frame(x$loadings[, "a3", drop = FALSE])
      tab2 <- as.data.frame(x$info)
      tab3 <- as.data.frame(x$infose)
      tabd <- as.data.frame(x$disc)
      tabci <- NULL
      for (i in seq(nrow(x$disc))){
        lb <- tabd[i, 1] - (z * tab3[i, 1])
        ub <- tabd[i, 1] + (z * tab3[i, 1])
        ci <- cbind(lb, ub)
        tabci <- rbind(tabci, ci)
      }
      as.matrix(tab3[1, 1], ncol = 1)
      colnames(tabci) <- c("CI Lower", "CI Upper")
      tab4 <- as.data.frame(cbind(taba1, taba2, taba3, tab2, tab3, tabci))
      cat(paste("\n"))
    }
    if (!is.null(x$c.dir.cos)){
      tab6 <- as.data.frame(cbind(x$c.dir.cos, x$c.spherical))
      tab7 <- as.data.frame(cbind(x$ddisc))
      if (!is.null(x$con.items)){
        cat(paste("Constructs\n"))
        for (i in seq_along(x$con.items)){
          n <- unlist(x$con.items[i])
          m <- rownames(x$disc)[n]
          if (is.null(m)) {
            m <- paste0("Item ", seq_len(nrow(x$disc)))
          }
          cat(paste("Item vector ", i, ": ", paste(m, collapse=", ", sep = ""), "\n", sep = ""))
        }
      }
      if (!is.null(x$con.sphe)){
        cat(paste("Constructs\n"))
        for (i in seq_along(x$con.sphe)){
          n <- unlist(x$con.sphe[i])
          cat(paste("Spherical coordinate vector ", i, ": ", paste(n[1], ", ", collapse="", sep = ""), paste(n[2], collapse="", sep = ""), "\n", sep = ""))
        }
      }
    }
  cat(paste("\n"))
  if (length(x$modid) == 2 || is.null(x$modid)) {
    info <- as.numeric(unlist(x$info))
    se   <- as.numeric(unlist(x$infose))
    sum_info    <- sum(info, na.rm = TRUE)
    mean_info   <- mean(info, na.rm = TRUE)
    sd_info <- sd(info, na.rm = TRUE)
    median_info <- median(info, na.rm = TRUE)
    mean_se <- mean(se, na.rm = TRUE)
    sd_se <- sd(se, na.rm = TRUE)
    median_se <- median(se, na.rm = TRUE)
    tab6 <- data.frame(sum_info, mean_info, sd_info, median_info, mean_se, sd_se, median_se)
    colnames(tab6) <- c("Sum Info", "Mean", "SD", "Median", "Mean SE", "SD SE", "Median SE")
    rownames(tab6) <- paste("Model", "")
    cat("MDISC Descriptives\n")
    print(round(tab6, digits))
  } else {
    n <- length(x$modid)
    sum_info    <- numeric(n)
    mean_info   <- numeric(n)
    sd_info   <- numeric(n)
    median_info <- numeric(n)
    mean_se     <- numeric(n)
    sd_se   <- numeric(n)
    median_se   <- numeric(n)
    for (i in seq_len(n)) {
      finfo <- as.numeric(unlist(x$info[!x$loadings[, i] == 0, 1]))
      fse   <- as.numeric(unlist(x$infose[!x$loadings[, i] == 0, 1]))
      sum_info[i]    <- sum(finfo, na.rm = TRUE)
      mean_info[i]   <- mean(finfo, na.rm = TRUE)
      sd_info[i] <- sd(finfo, na.rm = TRUE)
      median_info[i] <- median(finfo, na.rm = TRUE)
      mean_se[i]     <- mean(fse, na.rm = TRUE)
      sd_se[i]     <- sd(fse, na.rm = TRUE)
      median_se[i]   <- median(fse, na.rm = TRUE)
    }
    tab6 <- data.frame(sum_info, mean_info, sd_info, median_info, mean_se, sd_se, median_se)
    colnames(tab6) <- c("Sum Info", "Mean", "SD", "Median", "Mean SE", "SD SE", "Median SE")
    rownames(tab6) <- paste("Dimension", seq_len(n))
    cat("DISC Descriptives\n")
    print(round(tab6, digits))
  }
  cat(paste("\n"))
  if (!is.null(x$ddisc)){
    n <- length(x$ddisc)
    sum_info    <- numeric(n)
    mean_info   <- numeric(n)
    sd_info   <- numeric(n)
    median_info <- numeric(n)
    mean_se     <- numeric(n)
    sd_se   <- numeric(n)
    median_se   <- numeric(n)
    for (i in seq_len(n)) {
      finfo <- as.numeric(unlist(x$ddinfo[, i]))
      fse   <- as.numeric(unlist(x$ddinfose[, i]))
      sum_info[i]    <- sum(finfo, na.rm = TRUE)
      mean_info[i]   <- mean(finfo, na.rm = TRUE)
      sd_info[i] <- sd(finfo, na.rm = TRUE)
      median_info[i] <- median(finfo, na.rm = TRUE)
      mean_se[i]     <- mean(fse, na.rm = TRUE)
      sd_se[i]     <- sd(fse, na.rm = TRUE)
      median_se[i]   <- median(fse, na.rm = TRUE)
    }
    tab7 <- data.frame(sum_info, mean_info, sd_info, median_info, mean_se, sd_se, median_se)
    colnames(tab7) <- c("Sum Info", "Mean", "SD", "Median", "Mean SE", "SD SE", "Median SE")
    rownames(tab7) <- paste("Construct", seq_len(n))
    cat("DDISC Descriptives\n")
    print(round(tab7, digits))
  }
  cat(paste("\n"))
  print(round(tab4,digits))
  if (!is.null(x$ddisc)){
    tab1 <- as.data.frame(x$ddisc)
    tab2 <- as.data.frame(x$ddinfose)
    tabd <- NULL
    for (j in seq(ncol(x$ddisc))){
      tabci <- NULL
      tabd1 <- as.data.frame(tab1[, j])
      tabd2 <- as.data.frame(tab2[, j])
      for (i in seq(nrow(x$disc))){
        lb <- tabd1[i, 1] - (z * tabd2[i, 1])
        ub <- tabd1[i, 1] + (z * tabd2[i, 1])
        ci <- cbind(lb, ub)
        tabci <- rbind(tabci, ci)
      }
      tabd <- cbind(tabd, tabci)
    }
    tab5 <- do.call(cbind, lapply(seq_along(x$ddisc), function(i) {
      cbind(x$ddisc[[i]], x$ddinfo[[i]], x$ddinfose[[i]], tabd[, (i * 2) - 1], tabd[, (i * 2)])
    }))
    colnames(tab5) <- as.vector(outer(
      c("DDISC ", "Info ", "SE ", "CI Lower ", "CI Upper "),
      1:ncol(x$ddisc),
      paste0
    ))
    rownames(tab5) <- rownames(x$disc)
    cat(paste("\n"))
    print(round(tab5,digits))
  }
}
