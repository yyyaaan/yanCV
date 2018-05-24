library(shinymaterial)
library(timevis)

VAR_COL_1 <- "blue-grey"
VAR_COL_2 <- "cyan" 

material_page(
 
  title = "",
  nav_bar_color = VAR_COL_1,
  nav_bar_fixed = FALSE,
  tags$head(tags$style("
      .modal{background-color: transparent; width: 100%; max-height: 100% }
      .collection .collection-item.avatar{min-height: 30px}
  ")),
  

  # side nav ----------------------------------------------------------------


  material_side_nav(
    fixed = TRUE,
    image_source = "theme.png",
    
    material_side_nav_tabs(
      side_nav_tabs = c("1st Nav" = "tab1", "2nd Nav" = "tab2", 
                        "3rd Nav" = "tab3", "Source" = "tab4"),
      icons = c("donut_small", "assignment_ind", "assessment", "code")
    ),
    
    tags$hr(),
    material_radio_button("lang", "Languages",
                          choices = c(" English" = "ENG", " Suomeksi" = "FIN"," 简体中文" = "CHN")),
             
    tags$br(),
    tags$p(class="center-align","Copyright Yan PAN 2018")
  ),
  

  # 1st ---------------------------------------------------------------------

  material_side_nav_tab_content(
    side_nav_tab_id = "tab1",
    tags$div(
      class = "container",
      tags$p("hello tab 1")
    )
  ),

  # 2nd ---------------------------------------------------------------------

  material_side_nav_tab_content(
    side_nav_tab_id = "tab2",
    material_row(
      material_column(width = 10, offset = 2, uiOutput("title"))
    ),
    material_row(
      material_column(width = 12, material_card("", timevisOutput("myExp")))
    ),
    material_row(
      tags$div(class="col s12 m8", 
               material_card(textOutput("expt"), dataTableOutput("myExpDT"))),
      tags$div(class = "col s12 m4",
        tags$ul(class="collection",
                tags$li(class = "teal lighten-4 collection-item avatar",
                        tags$i(class = "circle teal material-icons", "dashboard"),
                        uiOutput("At")),
                tags$li(class = "collection-item",uiOutput("A")),
                tags$li(class = "amber lighten-4 collection-item avatar",
                        tags$i(class = "circle amber material-icons", "credit_card"),
                        uiOutput("Bt")),
                tags$li(class = "collection-item",uiOutput("B")),
                tags$li(class = "red  lighten-4 collection-item avatar",
                        tags$i(class = "circle red material-icons", "developer_mode"),
                        uiOutput("Ct")),
                tags$li(class = "collection-item",uiOutput("C"))
        )
      )
    )
  ),

  # 3rd ---------------------------------------------------------------------

  material_side_nav_tab_content(
    side_nav_tab_id = "tab3",
    tags$div(
      class = "container",
      tags$p("hello tab 3")
    )
  ),
  

  # 4th ---------------------------------------------------------------------
  
  material_side_nav_tab_content(
    side_nav_tab_id = "tab4",
    material_row(
      tags$div(class="col s12 m6",
               material_card("ui.R", tags$pre(includeText("ui.R")))),
      tags$div(class="col s12 m6",
               material_card("server.R", tags$pre(includeText("server.R")))),
      tags$div(class="col s12 m6",
               material_card("global.R", tags$pre(includeText("global.R"))))
    )
  )
)
