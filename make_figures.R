# ==============================================================================
# Recreates the images used in README.md (saved to figures/).
# Run from the repository root:  Rscript make_figures.R
# ==============================================================================

library(ggplot2)
library(rpart)
library(rpart.plot)

dir.create("figures", showWarnings = FALSE)

# Two colours that stay distinguishable for colour-blind readers
col_no  <- "#eb6834"   # orange
col_yes <- "#2a78d6"   # blue

clean_theme <- theme_minimal(base_size = 13) +
  theme(panel.grid.minor   = element_blank(),
        panel.grid.major.x = element_blank(),
        plot.title         = element_text(face = "bold"),
        plot.background    = element_rect(fill = "white", colour = NA),
        legend.position    = "top")

titanic <- read.csv("data/titanic.csv", stringsAsFactors = TRUE)
titanic$Survived <- factor(titanic$Survived, levels = c(0, 1), labels = c("No", "Yes"))
titanic$Pclass   <- factor(titanic$Pclass, labels = c("1st", "2nd", "3rd"))

# ---- 1. Survival by class and sex ---------------------------------------------
p1 <- ggplot(titanic, aes(x = Pclass, fill = Survived)) +
  geom_bar(position = "fill", width = 0.7, colour = "white", linewidth = 0.6) +
  facet_grid(. ~ Sex) +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = c(No = col_no, Yes = col_yes)) +
  labs(title = "Titanic: share of passengers who survived",
       subtitle = "Women and first-class passengers had the best odds",
       x = "Passenger class", y = NULL, fill = "Survived") +
  clean_theme
ggsave("figures/titanic_survival.png", p1, width = 8, height = 4.5, dpi = 150)

# ---- 2. Decision tree on the Titanic data -------------------------------------
titanic$Name <- NULL
set.seed(123)
index <- sample(1:nrow(titanic), size = round(0.8 * nrow(titanic)))
tree  <- rpart(Survived ~ ., data = titanic[index, ], method = "class",
               control = rpart.control(maxdepth = 3, minsplit = 20, minbucket = 7, cp = 0.01))

png("figures/titanic_tree.png", width = 1400, height = 800, res = 150)
prp(tree, type = 2, extra = 104, box.palette = c(col_no, col_yes), faclen = 0,
    main = "Classification tree: who survived the Titanic?")
dev.off()

# ---- 3. Breast cancer: two features that separate the classes -----------------
cancer <- read.csv("data/breast_cancer.csv", stringsAsFactors = TRUE)
cancer$diagnosis <- factor(cancer$diagnosis, levels = c("B", "M"),
                           labels = c("Benign", "Malignant"))

p3 <- ggplot(cancer, aes(x = radius_mean, y = concave.points_mean, colour = diagnosis)) +
  geom_point(size = 2.2, alpha = 0.75) +
  scale_colour_manual(values = c(Benign = col_yes, Malignant = col_no)) +
  labs(title = "Breast cancer: tumour size vs shape",
       subtitle = "Malignant tumours are larger and have more concave points",
       x = "Mean radius", y = "Mean concave points", colour = NULL) +
  clean_theme +
  theme(panel.grid.major.x = element_line(colour = "grey90"))
ggsave("figures/breast_cancer_scatter.png", p3, width = 7, height = 4.5, dpi = 150)
