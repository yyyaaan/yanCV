library(shinymaterial)

VAR_COL_1 <- "blue-grey"
VAR_COL_2 <- "cyan" 

material_page(
 
  title = "",
  nav_bar_color = VAR_COL_1,
  nav_bar_fixed = FALSE,
  

  # side nav ----------------------------------------------------------------


  material_side_nav(
    fixed = FALSE,
    image_source = "theme.png",
    
    material_side_nav_tabs(
      side_nav_tabs = c("1st Nav" = "tab1", "2nd Nav" = "tab2", 
                        "3rd Nav" = "tab3", "4th Nav" = "tab4"),
      icons = c("donut_small", "assignment_ind", "assessment", "code")
    ),
    
    tags$p(class="center-align","Copyright Yan PAN 2018")
  ),
  

  # 1st ---------------------------------------------------------------------

  material_side_nav_tab_content(
    side_nav_tab_id = "tab1",
    tags$p("hello")
  ),

  # 2nd ---------------------------------------------------------------------

  material_side_nav_tab_content(
    side_nav_tab_id = "tab2",
    tags$p("hello tab 2")
  ),

  # 3rd ---------------------------------------------------------------------

  material_side_nav_tab_content(
    side_nav_tab_id = "tab3",
    tags$p("hello tab 3")
  )

)
