library(ggplot2)
library(dplyr)
library(tidyr)
library(ggthemes)
#install.packages('fmsb')
library(fmsb)
#install.packages('ggforce')
library(ggforce)
library(plotrix)

Producer <- c('Samsung', 'Huawei', 'Xiami', 'LG', 'Apple' )
usa_un <- c(10, 15, 20, 25, 30)
usa <- usa_un/sum(usa_un)
uk_un <- c(8, 12, 12, 28, 40)
uk <- uk_un/sum(uk_un)

market_share <- data.frame(Producer, usa, uk)
market_share_narrow <-gather(market_share, "Country", "Share", usa, uk)
market <-market_share_narrow %>% mutate(pct=Share*100)

# Stacked bar plot jest dobrą alternatywą dla diagramów kołowych, widać, do jakiej wartości sumują się składowe, 
# ale utrudnia porównanie odpowiadających sobie składowych, w tym przypadku jaka jest różnica pomiędzy składową 
# D dla obu słupków
market_stacked <- market %>% 
  ggplot(aes(x=Country, fill=Producer, y=Share)) +
  geom_bar(stat='identity', position='stack', width=0.4)  +
  scale_y_continuous(labels = scales::percent) +
  ggtitle('Smartphone market share in USA and UK') +
  theme_hc() +
  scale_fill_hc()

# Jeśli ważne jest porównanie pomiędzy poszczególnymi składowymi, to lepiej ustawić je obok siebie przy zerze
# kosztem tego, że nie widać, że składowe sumują się do 100%
market_dodge <- market %>% 
  ggplot(aes(x=Producer, fill=Country, y=Share)) +
  geom_bar(stat='identity', position='dodge', width=0.4)  +
  scale_y_continuous(labels = scales::percent) +
  ggtitle('Smartphone market share in USA and UK') +
  theme_hc() +
  scale_fill_hc()

uk_usa_difference <- market_share %>% 
  filter(Producer == 'LG') %>% 
  mutate(diff = (uk - usa) *100) %>% 
  pull(diff)


party = c('A', 'B')
support = c(28.09, 28.25)/100
political_support = data.frame(party, support)

scale_not_in_zero <- political_support %>% 
  ggplot(aes(x=party, y=support, fill=party)) + 
  geom_bar(stat='identity') + 
  scale_y_continuous(labels = scales::percent_format(accuracy = 0.1)) +
  coord_cartesian( 
    ylim = c((0.99)*support[1], support[2]*(1+0.003))
  ) +
  ggtitle('Support for party A and B') +
  theme_hc() +
  scale_fill_hc()
#scale_y_continuous(limits=c(0.379, 0.39))

scale_in_zero <- political_support %>% 
  ggplot(aes(x=party, y=support, fill=party)) + 
  geom_bar(stat='identity') + 
  ggtitle('Support for party A and B') +
  scale_y_continuous(labels = scales::percent_format(accuracy = 0.1)) +
  theme_hc() +
  scale_fill_hc()

#x_gap <- c('mxnet', 'deeplearning4j', 'Caffe', 'Pytorch', 'Tensorflow', 'Keras')
x_gap <- 1:6 #c('mxnet', 'deeplearning4j', 'Caffe', 'Pytorch', 'Tensorflow', 'Keras')
twogrp<-c( 125,120,112, 5, 4,3)
twogrp_df = data.frame(x_gap, twogrp)
gap_in_scale <- function() {
  gap.barplot(twogrp, xaxlab=x_gap,gap=c(8,111),xlab="Category",ytics=c(3,6,17,120),
              ylab="Occurrences",main="Barplot with gap")
}
gap_in_scale()

y_gap <-twogrp
data_gap = data.frame(x_gap, y_gap) 
data_gap %>% ggplot(aes(x=x_gap, y=y_gap, fill=as.factor(x_gap))) +
  geom_bar(stat='identity') +
  theme_hc() +
  scale_fill_hc()



zoomed_plot <- ggplot(data_gap) + 
  aes(x = x_gap, y = y_gap, fill=as.factor(x_gap)) +
  geom_bar(stat = "identity") +
  facet_zoom(ylim = c(0, 10), xlim=c(3.7,6.35)) +
  labs(x = "Category", y = "Occurrences", fill="") +
  scale_fill_hc() +
  theme_hc()



set.seed(1)
school_subjects <-as.data.frame(matrix( sample( 2:20 , 10 , replace=T) , ncol=10))
colnames(school_subjects) <- c("math" , "english" , "biology" , "music" , "R-coding", "data-viz" , "french" , "physic", "statistic", "sport" )

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
school_subjects <-rbind(rep(20,10) , rep(0,10) , school_subjects)

# Custom the radarChart !
par(mar=c(0,0,0,0))
plot_radar_chart <- function(){
  radarchart( school_subjects, axistype=1, 
              
              #custom polygon
              pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 , 
              
              #custom the grid
              cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
              
              #custom labels
              vlcex=1.3 
  )
}

# Barplot
barplot_school_subjects <- school_subjects %>% slice(3) %>% t() %>% as.data.frame() %>% add_rownames() %>% arrange(V1) %>% mutate(rowname=factor(rowname, rowname)) %>%
  ggplot( aes(x=rowname, y=V1)) +
  geom_segment( aes(x=rowname ,xend=rowname, y=0, yend=V1), color="grey") +
  geom_point(size=5, color="#69b3a2") +
  coord_flip() +
  theme_hc() +
  theme(
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_blank(),
    axis.text = element_text( size=18 ),
    legend.position="none"
  ) +
  ylim(0,20) +
  ylab("mark") +
  xlab("")

