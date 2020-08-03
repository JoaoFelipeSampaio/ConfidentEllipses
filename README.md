# ConfidentEllipses
A script wrote in R to help you develop a graphic of Confident Ellipses applied to a Principal Component Analysis results, using Dplyr and ggplot2 libraries
The document have comments related to any line of code wrote, so, with you have any problem in develop this, please, send me a message. 

# Call the Library used in this project
library(ggplot2)
library(dplyr)

You can initiate your work using File.choose or can set a directory of work. In this case I used Setwd.
For data, I used a .CSV document. 
I created a subset of it, called "i" because for PCA you need to input only data with Structure equal to "Num or Int". 
In my case, the two first collumns have Factor data

For Principal Component Analysis I use "Prcomp" from the basic "stats" package.

The follow instructions was implemented to extract the first two Principal Components.

# Principal Component extraction of the analysis
center <- prin_comp$center
scale <- prin_comp$scale
hm <- as.matrix(dados[,-c(1,2)])
PCA1<- drop(scale(hm, center = center, scale = scale) %*% prin_comp$rotation[,1])
PCA2<- drop(scale(hm, center = center, scale = scale) %*% prin_comp$rotation[,2])

After extraction of the Principal Components, I created a Data.frame and applied colnames for this new subset

In my research, I needed to choose only some labels of my data to create the Graphic of Confident Ellipses using PCA
For this, using Dplyr library, I filter the labels needed to work. Remember, you can do this for your data to, it's more simple than try to implement it directly on the graph
# But, with you don't want to filter and want to create a graph with all labels, just jump this step and go directly to the Plot

After choose the interest labels of my work, I started to create the Confident Ellipses graph using ggplot2 tools. 
For this, you can use x11() to better visualize the final output. 
Warning, "Systemsex" is the name of my factor column, please, change it for your factor of interest. 
With you only input the data without use "scale_shape_manual" and "scale_color_manual", your output graph will be ploted in a standart way, using the levels of your factor to create it. 
In my case, I put the shape I want for my labels and choose manually the colors to.
Shape: Refers to form of the points in the graph
Color: Refers to the colors applied for the labels of your factor

# Plot Confident Ellipses graph with ggplot2 library
#Plotar gráfico de Elipses de Confiança
x11()
ggplot(data=df, aes(x=PC1, y=PC2, color=Systemsex, shape=Systemsex))+
  geom_point()+
  stat_ellipse()+
  scale_shape_manual(values = c(0,4,1,3,5,8,2,6,9,10))+
  scale_color_manual(values = c("blue","orange2","hotpink",
                                "black","saddlebrown","red",
                                "limegreen","brown","darkgrey","purple"))+
  theme(legend.position="bottom",
        panel.background = element_blank(), legend.title = element_blank())
