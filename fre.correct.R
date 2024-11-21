# This code defines a shiny app with a UI and server component.
# This app is purpose is to help user correct the freshwater reservoir effect of radiocarbon dates 
# when the maximum (FRE) of the region is known.
# The UI component contains input widgets for the maximum FRE of the region, the maximum FRE standard 
# deviation, the 14C date standard deviation, the percentage of aquatic resource in the diet, and its
# standard deviation. The server component calculates the FRE offset, FRE offset sd, the corrected 
# date and standard deviation, and generates the output plot and table based on user input.
# To run the app, save the code as a .R file and run it in RStudio or any R environment that supports
# Shiny applications.

# install.packages("shiny")
# install.packages("readr")

# library(shiny)
# library(readr)

# Define the UI and its components.
ui <- fluidPage(
  titlePanel("Freshwater Reservoir Effect correction of radiocarbon dates for contexts where \n
             the maximum FRE of the region is known"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("max_fre", "Maximum FRE of the region", NULL),
      numericInput("max_fre_sd", "Standard deviation of the region's maximum FRE", NULL),
      numericInput("date_14C", "14C date", NULL),
      numericInput("date_14C_sd", "14C standard deviation", NULL),
      numericInput("perc_aquatic", "Percentage of aquatic resource in diet", NULL),
      numericInput("perc_aquatic_sd", "Standard deviation of the percentage of aquatic resource in diet", NULL),
      actionButton("calculate", "Calculate")
    ),
    mainPanel(
      plotOutput("plot"),
      tableOutput("table")
    )
  )
)

# Perform the calculations for the FRE correction.
server <- function(input, output, session) {
  
  observeEvent(input$file, {
    data <- read_csv(input$file$datapath)
    updateNumericInput(session, "max_fre", value = data$max_fre)
    updateNumericInput(session, "max_fre_sd", value = data$max_fre_sd)
    updateNumericInput(session, "date_14C", value = data$date_14C)
    updateNumericInput(session, "date_14C_sd", value = data$date_14C_sd)
    updateNumericInput(session, "perc_aquatic", value = data$perc_aquatic)
    updateNumericInput(session, "perc_aquatic_sd", value = data$perc_aquatic_sd)
  })
  
  observeEvent(input$calculate, {
    # Perform calculations
    fw_correction <- input$perc_aquatic * input$max_fre / 100
    fw_correction_sd <- (input$perc_aquatic_sd / input$perc_aquatic) * fw_correction
    corrected_date <- input$date_14C - fw_correction
    corrected_date_sd <- sqrt(input$date_14C_sd^2 + fw_correction_sd^2)
    
    # Store results in a data frame
    results <- data.frame(FRE_offset = fw_correction,
                          FRE_offset_sd = fw_correction_sd,
                          Corrected_14C_date = corrected_date,
                          Corrected_14C_date_SD = corrected_date_sd)
    
    # Update the output table
    output$table <- renderTable(results)
    
    # Update the output plot
    output$plot <- renderPlot({
      plot(results$Corrected_14C_date,
           main = "FRE Corrected Radiocarbon Dates",
           xlab = "Sample Index",
           ylab = "Corrected 14C Date",
           ylim = c(min(results$Corrected_14C_date - 2 * results$Corrected_14C_date_SD),
                    max(results$Corrected_14C_date + 2 * results$Corrected_14C_date_SD)),
           pch = 19, cex = 2, col = "red")
      
      # Add the error bars
      segments(x0 = 1:length(results$Corrected_14C_date),
               y0 = results$Corrected_14C_date - results$Corrected_14C_date_SD,
               x1 = 1:length(results$Corrected_14C_date),
               y1 = results$Corrected_14C_date + results$Corrected_14C_date_SD)
    })
  })
}

# Run the Shiny app for the correction of FRE.
shinyApp(ui = ui, server = server)
