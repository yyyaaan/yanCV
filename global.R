# https://www.materialpalette.com/
myColors <- c("red", "pink", "purple", "deep-purple", "indigo", "blue", "light-blue",
              "cyan", "teal", "green", "light-green", "lime", "yellow", "amber",
              "orange", "deep-orange", "brown", "grey", "blue-grey")
myColors.rgb <- c("rgba(244, 67, 54, 0.1)", "rgba(233, 30, 99, 0.1)", "rgba(156, 39, 176, 0.1)", "rgba(103, 58, 183, 0.1)", "rgba(63, 81, 181, 0.1)", "rgba(33, 150, 243, 0.1)", "rgba(3, 169, 244, 0.1)",
                  "rgba(0, 188, 212, 0.1)", "rgba(0, 150, 136, 0.1)", "rgba(76, 175, 80, 0.1)", "rgba(139, 195, 74, 0.1)", "rgba(205, 220, 57, 0.1)", "rgba(255, 235, 59, 0.1)", "rgba(255, 193, 7, 0.1)",
                  "rgba(255, 152, 0, 0.1)", "rgba(255, 87, 34, 0.1)", "rgba(121, 85, 72, 0.1)", "rgba(158, 158, 158, 0.1)", "rgba(96, 125, 139, 0.1)")


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

getField <- function(l){
  
  fld <- read.delim2("field.tsv") %>%  subset(lang == l)
  lst <- fld$value %>% as.character() %>% as.list()
  names(lst) <- fld$field
  return(lst)
}

createEvent <- function(title = "Title", summary = "summary", detail = "detail", 
                        main_icon = "language", labels = c("NA"), img_src = "qr.png"){

  iCol <- sample(1:19, 1)
  
  chipLabel <- lapply(labels, function(x) tags$div(class="chip", x))
  
  cardContent <- tags$div(
    class = "card-content",
    tags$span(
      class = "card-title activator grey-text text-darken-4", 
      title, 
      tags$i(class = "material-icons right", "more_vert")
    ),
    tags$p(chipLabel),
    tags$p(summary)
  )
  
  cardReveal <- tags$div(
    class = "card-reveal",
    tags$span(
      class = "card-title grey-text text-darken-4", 
      title, 
      tags$i(class = "material-icons right", "close")
    ),
    tags$p(chipLabel),
    tags$p(detail)
  )
  
  cardImage <- tags$div(
    class = "card-image waves-effect waves-block waves-light",
    #tags$img(class = "activator", src = img_src)
    tags$div(class = "activator", style = paste("background-color:", myColors.rgb[iCol], ";"), tags$img(src = img_src))
  )
  
  timeIcon <- tags$div(
    class = paste("timeline-badge", myColors[iCol], "white-text"),
    tags$i(class = "material-icons", main_icon)
    # p("2018")
  )
  
  tags$div(
    class = "timeline-event", 
    tags$div(class = "card timeline-content", cardImage, cardContent, cardReveal),
    timeIcon
  )
}

length(myColors)





