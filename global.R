getExp <- function(lang = "ENG") {

  myExp <- read.delim2("exp.tsv")
  n <- nrow(myExp)

  col <-  which(colnames(myExp) == lang)
  myExp <- myExp[, c(1:4, col, col + 1, col + 2, col + 3)]
  myExp$id <- 1:n
  
  #nice output
  myExp$content <- character(n)
  for (i in 1:n) {
    myExp$content[i] <- paste0(strong(myExp[i,5]),
                               p(myExp[i,7]))
  }

  #set group lang
  groupDF <- data.frame(id = unique(myExp$group), content = unique(myExp[,6]))
  
  return(list(ts = myExp[,c(9,1,2,3,10,4)],
              dt = myExp[,c(1,2,6,5,7,8)],
              grp = groupDF))
}

getSource <- function(what = "app.R"){
  
  src <- readLines(what)
  out <- ""
  for (i in 1:length(src)) {
    out <- paste(out, src[i], sep = "\n")
  }
  
  return(out)
}

getField <- function(l){
  
  fld <- read.delim2("field.tsv") %>%  subset(lang == l)
  lst <- fld$value %>% as.character() %>% as.list()
  names(lst) <- fld$field
  return(lst)
}
