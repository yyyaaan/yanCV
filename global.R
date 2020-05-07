library(shinymaterial)
library(shiny)
library(timevis)
library(shinyjs)
library(DT)
options(stringsAsFactors = FALSE)


myColors <- c("red", "pink", "purple", "deep-purple", "indigo", "blue", "light-blue",
              "cyan", "teal", "green", "light-green", "lime", "yellow", "amber",
              "orange", "deep-orange", "brown", "grey", "blue-grey")
myColors.rgb <- c("rgba(244, 67, 54, 0.1)", "rgba(233, 30, 99, 0.1)", "rgba(156, 39, 176, 0.1)", "rgba(103, 58, 183, 0.1)", "rgba(63, 81, 181, 0.1)", "rgba(33, 150, 243, 0.1)", "rgba(3, 169, 244, 0.1)",
                  "rgba(0, 188, 212, 0.1)", "rgba(0, 150, 136, 0.1)", "rgba(76, 175, 80, 0.1)", "rgba(139, 195, 74, 0.1)", "rgba(205, 220, 57, 0.1)", "rgba(255, 235, 59, 0.1)", "rgba(255, 193, 7, 0.1)",
                  "rgba(255, 152, 0, 0.1)", "rgba(255, 87, 34, 0.1)", "rgba(121, 85, 72, 0.1)", "rgba(158, 158, 158, 0.1)", "rgba(96, 125, 139, 0.1)")

syncData <- function(){
  # get Google Sheet (online)
  all <- gsheet::gsheet2tbl("https://docs.google.com/spreadsheets/d/1CoMi_EfK950iXk_iuCSujY6Sq6e38VnYExXDo4sMONA/edit#gid=1164046835")
  saveRDS(all, file = "all.rds")
  
  # get coursera info (copy <body> elements to coursera file)
  library(rvest)
  contents <- read_html("coursera") %>% html_nodes(".rc-AccomplishmentCard")
  
  coursera <- data.frame( 
    label = contents %>% html_nodes(".linkedin-detail-label") %>% html_text(),
    value = contents %>% html_nodes(".linkedin-detail-value") %>% html_text())
  coursera <- data.frame(
    name  = coursera[coursera$label == 'Name:', 'value'],
    issue = coursera[coursera$label == 'Issue Date:', 'value'],
    id    = coursera[coursera$label == 'Credential ID:', 'value'],
    by    = contents %>% html_nodes(".caption-text") %>% html_text())
  
  coursera$detail = paste("by", coursera$by, "on Coursera.org,", coursera$issue)
  coursera$link   = paste0("coursera.org/verify/", coursera$id)
  coursera$link   = paste0('<a href = "http://', coursera$link, '" target = "_blank"> Verify at ', coursera$link, '</a>')
  coursera$img    = paste0("coursera_", coursera$id, ".jpg")
  
  saveRDS(coursera, file = "coursera.rds")
}

getField <- function(lang = "CHN"){
  
  fld <- readRDS("all.rds") %>% subset(language == lang | language == "ALL")
  namedList <- list()
    # pack the vectors
  for (curKey in unique(fld$key)) {
    curValue <- fld %>% subset(key == curKey)
    namedList[[length(namedList) + 1]] <- curValue$value
  }
    # name the list
  names(namedList) <- unique(fld$key)
  return(namedList)
}

createCollection <- function(main = "Collection", items){
  theItems <- list()
  for (i in 1:length(items)) {
    iCol <- sample(1:19, 1)
    itemSplit <- strsplit(items[i], " - ")[[1]]
    
    theItems[[i]] <- tags$a(
      href = "#",
      class = "collection-item avatar",
      tags$i(class = paste("material-icons", myColors[iCol], "circle"), itemSplit[1]),
      tags$span(class = "title", itemSplit[2]),
      tags$p(style = "color: grey", itemSplit[3])
    )
  }
  
  tagList(
    tags$span(class = "card-title", main),
    tags$div(class = "collection", tagList(theItems))
  )
}

createEvent <- function(title = "Title", summary = "summary", detail = "detail", 
                        main_icon = "language", labels = c("NA"), img_src = ""){

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
  )
  
  tags$div(
    class = "timeline-event", 
    tags$div(class = "card timeline-content", cardImage, cardContent, cardReveal),
    timeIcon
  )
}
