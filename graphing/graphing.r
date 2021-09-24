# In RStudio, Ctrl+A then Run

library(ggplot2)
library(dplyr)

setwd("~/GitHub/nzpolls/graphing") # replace with own working directory

# Read data
csvData <- read.csv("local-data.csv")
pollingData <- arrange(csvData, desc(as.Date(endDate, '%Y-%m-%d')))

# Plot data
spansize <- 0.65 # higher = smoother
ggplot(pollingData, aes(x = as.Date(endDate, '%Y-%m-%d'))) +
  theme_bw() +

  # Labour
  geom_point(aes(y = LAB, colour = "LAB"), size = 2, alpha = 0.3) +
  geom_smooth(aes(y = LAB, colour = "LAB"), span = spansize, se = FALSE) +
  # National
  geom_point(aes(y = NAT, colour = "NAT"), size = 2, alpha = 0.3) +
  geom_smooth(aes(y = NAT, colour = "NAT"), span = spansize, se = FALSE) +
  # Green
  geom_point(aes(y = GRN, colour = "GRN"), size = 2, alpha = 0.3) +
  geom_smooth(aes(y = GRN, colour = "GRN"), span = spansize, se = FALSE) +
  # ACT
  geom_point(aes(y = ACT, colour = "ACT"), size = 2, alpha = 0.3) +
  geom_smooth(aes(y = ACT, colour = "ACT"), span = spansize, se = FALSE) +
  # NZ First
  geom_point(aes(y = NZF, colour = "NZF"), size = 2, alpha = 0.3) +
  geom_smooth(aes(y = NZF, colour = "NZF"), span = spansize, se = FALSE) +
  # Maori
  geom_point(aes(y = MRI, colour = "MRI"), size = 2, alpha = 0.3) +
  geom_smooth(aes(y = MRI, colour = "MRI"), span = spansize, se = FALSE) +
  # TOP
  geom_point(aes(y = TOP, colour = "TOP"), size = 2, alpha = 0.3) +
  geom_smooth(aes(y = TOP, colour = "TOP"), span = spansize, se = FALSE) +
  # New Conservative
  geom_point(aes(y = NCP, colour = "NCP"), size = 2, alpha = 0.3) +
  geom_smooth(aes(y = NCP, colour = "NCP"), span = spansize, se = FALSE) +

  # Y-axis
  scale_y_continuous(limits = c(0, 60), breaks = c(0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60), minor_breaks = waiver(), expand = c(0, 0)) +
  # X-axis
  scale_x_date(date_breaks = "4 months", date_labels = "%b '%y", minor_breaks = "1 month") +
  # Axis styling
  theme(
    axis.text.x = element_text(angle = 0, vjust = 0.5, size = 10),
    axis.text.y = element_text(size = 12),
    axis.title.y = element_text(size = 12)
  ) +
  # Axis labels
  labs(y = "Party vote (%)", x = NULL) +
  # Colors and key
  scale_color_manual(
    name = "",
    # Legend
    labels = c("Labour", "National", "ACT", "Greens", "NZ First", "Maori", "TOP", "New Conservative"),
    # Color mapping
    values = c(
      # For color values see https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf p.3
      "LAB" = "red3",
      "NAT" = "blue3",
      "ACT" = "yellow3",
      "GRN" = "darkgreen",
      "NZF" = "gray4",
      "MRI" = "brown3",
      "TOP" = "mediumspringgreen",
      "NCP" = "steelblue3"
    )
  ) +
  theme(
    legend.position = "bottom",
    legend.text = element_text(size = 12)
  )

# Save graph
ggsave(
  "polling-graph.svg",
  width = 12,
  height = 7
)
