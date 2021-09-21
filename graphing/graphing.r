library(ggplot2)
library(dplyr)

setwd("Documents/GitHub/nzpolls/graphing") # replace with own working directory

pollingData <- read.csv("local-data.csv")
spansize <- 0.65

pollingData <- pollingData %>%
  arrange(desc(as.Date(endDate, '%Y-%m-%d')))

# Colours: use https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf p.3
LAB_color <- "red3"
NAT_color <- "blue4"
ACT_color <- "yellow3"
GRN_color <- "green4"
NZF_color <- "gray4"
MRI_color <- "orangered2"
TOP_color <- "seagreen2"
NCP_color <- "skyblue2"

primary_votes <- ggplot(pollingData, aes(x = as.Date(endDate, '%Y-%m-%d'))) +
  theme_bw() +
  
  # Labour
  geom_point(aes(y = LAB), colour = LAB_color, size = 2, alpha = 0.3) +
  geom_smooth(aes(y = LAB, colour = "LAB"), span = spansize, se = FALSE) +
  # National
  geom_point(aes(y = NAT), colour = NAT_color, size = 2, alpha = 0.3) +
  geom_smooth(aes(y = NAT, colour = "NAT"), span = spansize, se = FALSE) +
  # Green
  geom_point(aes(y = GRN), colour = GRN_color, size = 2, alpha = 0.3) +
  geom_smooth(aes(y = GRN, colour = "GRN"), span = spansize, se = FALSE) +
  # ACT
  geom_point(aes(y = ACT), colour = ACT_color, size = 2, alpha = 0.3) +
  geom_smooth(aes(y = ACT, colour = "ACT"), span = spansize, se = FALSE) +
  # NZ First
  geom_point(aes(y = NZF), colour = NZF_color, size = 2, alpha = 0.3) +
  geom_smooth(aes(y = NZF, colour = "NZF"), span = spansize, se = FALSE) +
  # Maori
  geom_point(aes(y = MRI), colour = MRI_color, size = 2, alpha = 0.3) +
  geom_smooth(aes(y = MRI, colour = "MRI"), span = spansize, se = FALSE) +
  # TOP
  geom_point(aes(y = TOP), colour = TOP_color, size = 2, alpha = 0.3) +
  geom_smooth(aes(y = TOP, colour = "TOP"), span = spansize, se = FALSE) +
  # New Conservative
  geom_point(aes(y = NCP), colour = NCP_color, size = 2, alpha = 0.3) +
  geom_smooth(aes(y = NCP, colour = "NCP"), span = spansize, se = FALSE) +
  
  # Y-axis
  scale_y_continuous(limits = c(0, 60), minor_breaks = NULL, expand = c(0, 0)) +
  # X-axis
  scale_x_date(date_breaks = "4 months", date_labels = "%b '%y", minor_breaks = NULL) +
  # Axis styling
  theme(
    axis.text.x = element_text(angle = 0, vjust = 0.5, size = 12),
    axis.text.y = element_text(size = 12),
    axis.title.y = element_text(size = 12)
  ) +
  # Axis labels
  labs(y = "Party vote (%)", x = NULL) +
  # Color mapping
  scale_color_manual(
    name = "",
    labels = c("Labour", "National", "ACT", "Greens", "NZ First", "Maori", "TOP", "New Conservative"),
    values = c("LAB" = LAB_color, "NAT" = NAT_color, "ACT" = ACT_color, "GRN" = GRN_color, "NZF" = NZF_color, "MRI" = MRI_color, "TOP" = TOP_color, "NCP" = NCP_color)
  )

# Display
primary_votes + theme(legend.position = "bottom", legend.box = "horizontal", legend.text = element_text(size = 12))
