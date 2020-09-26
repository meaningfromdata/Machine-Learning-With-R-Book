library(tidyverse)
library(mlr)

data(diabetes, package = "mclust")
diabetesTib <- as_tibble(diabetes)

diabetesTib

summary(diabetesTib)

# scatterplot of insulin vs glucose colored by class 
# class: Chemical, Overt, Normal
ggplot(diabetesTib, aes(glucose, insulin, col = class)) + 
  geom_point() +
  theme_bw()

# scatterplot of sspg vs insulin colored by class 
# class: Chemical, Overt, Normal
ggplot(diabetesTib, aes(sspg, insulin, col = class)) + 
  geom_point() +
  theme_bw()

# scatterplot of sspg vs glucose colored by class 
# class: Chemical, Overt, Normal
ggplot(diabetesTib, aes(sspg, glucose, col = class)) + 
  geom_point() +
  theme_bw()

# define classification task
diabetesTask <- makeClassifTask(data = diabetesTib, target = "class")

# list classifier algorithms/models in mlr
listLearners()$class

# define learner as knn
# set (# of neighbors) k = 2
knn <- makeLearner("classif.knn", par.vals = list("k" = 2))

# train the model
knnModel <- train(knn, diabetesTask)

# make model predictions on same data we trained it with
# bad practice, but this is part of pedagogical narrative
# in the chapter
knnPred <- predict(knnModel, newdata = diabetesTib)

# get performance metrics for knn model
# here using mean misclassification error (mmce) and
# accuracy (acc)
performance(knnPred, measures = list(mmce, acc))
