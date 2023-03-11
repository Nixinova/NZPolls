# In RStudio, Ctrl+A then Run

library(ggplot2)
library(dplyr)

setwd("~/GitHub/nzpolls/graphing") # replace with own working directory

# Read data
csvData <- read.csv("local-data.csv")
pollingData <- arrange(csvData, desc(as.Date(endDate, '%Y-%m-%d')))

# Plot data
spansize <- 0.5 # higher = smoother
ggplot(pollingData, aes(x = as.Date(endDate, '%Y-%m-%d'))) +
  theme_bw() +

# Left
geom_point(aes(y = left, colour = "Left"), size = 2, alpha = 0.3) +
  geom_smooth(aes(y = left, colour = "Left"), span = spansize, se = FALSE) +
# Right
geom_point(aes(y = right, colour = "Right"), size = 2, alpha = 0.3) +
  geom_smooth(aes(y = right, colour = "Right"), span = spansize, se = FALSE) +
# Other
geom_point(aes(y = other, colour = "Other"), size = 2, alpha = 0.3) +
  geom_smooth(aes(y = other, colour = "Other"), span = spansize, se = FALSE) +

# Y-axis
scale_y_continuous(limits = c(0, 70), breaks = c(0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70), minor_breaks = waiver(), expand = c(0, 0)) +
# X-axis
scale_x_date(date_breaks = "4 months", date_labels = "%b '%y", minor_breaks = "1 month") +
# Axis styling
theme(
    plot.background = element_rect(fill = "white", color = NA),
    axis.text.x = element_text(angle = 0, vjust = 0.5, size = 10),
    axis.text.y = element_text(size = 12),
    axis.title.y = element_text(size = 12)
  ) +
# Axis labels
labs(y = "Combined party vote (%)", x = NULL) +
# Colors and key
scale_color_manual(
    name = "",
# Legend
    labels = c(
      "Left" = "LAB+GRN+MRI",
      "Right" = "NAT+ACT"
    ),
# Color mapping
    values = c(
      "Left" = "#B85300",
      "Right" = "#5000B8",
      "Other" = "#333333"
    )
  ) +
  theme(
    legend.position = "bottom",
    legend.text = element_text(size = 12)
  )

# Save as 800x500 SVG
