# Shared helper: update a flat key-value JSON metrics file
update_metrics <- function(new_metrics, filepath) {
  existing <- list()
  if (file.exists(filepath)) {
    lines <- readLines(filepath, warn = FALSE)
    content <- paste(lines, collapse = "\n")
    m <- gregexpr('"([^"]+)"\\s*:\\s*([^,\\n}]+)', content)
    if (length(m[[1]]) > 0 && m[[1]][1] != -1) {
      for (pair in regmatches(content, m)[[1]]) {
        kv <- strsplit(pair, ':\\s*')[[1]]
        key <- gsub('^\\s*"|"\\s*$', '', kv[1])
        val <- gsub('^\\s*|\\s*$', '', kv[2])
        existing[[key]] <- val
      }
    }
  }
  for (k in names(new_metrics)) existing[[k]] <- new_metrics[[k]]
  keys <- names(existing)
  n_metrics <- length(existing)
  lines <- "{"
  for (i in seq_along(existing)) {
    val <- existing[[i]]
    if (is.character(val) && !grepl('^[0-9.eE\\-+]+$', val)) {
      # Escape quotes within strings
      val <- gsub('"', '\\\\"', val)
      val <- paste0('"', val, '"')
    }
    lines <- paste0(lines, '\n  "', keys[i], '": ', val)
    if (i < n_metrics) lines <- paste0(lines, ",")
  }
  lines <- paste0(lines, "\n}")
  writeLines(lines, filepath)
}
