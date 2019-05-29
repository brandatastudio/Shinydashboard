library(ggplot2)
dataset <- datawind

dataset[sapply(dataset, is.null)] <- NA


ydata = dataset[[4]]
xdata = dataset[[2]]
xcoln <- dataset[2]
ycoln <- dataset[4]

g1 <- ggplot(dataset,aes(x = xdata, y = ydata))

g1bar  <-  g1 + geom_bar( stat = "identity" , color = "darkseagreen1" , width = 0.5 ) + 
  xlab(colnames(xcoln)) + ggtitle(colnames(ycoln))  + 
  geom_text(stat = 'summary', fun.y = sum, angle = 90, hjust = -.05, size = 2, aes(label = xdata)) +
  theme(axis.text.x=element_blank(),axis.ticks.x=element_blank(),axis.title.y = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  coord_cartesian( expand = TRUE)


