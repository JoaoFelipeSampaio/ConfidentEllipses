#Call the Library used in this project
library(ggplot2)
library(dplyr)

#Set a directory of work
setwd("C:/Users/G450/Desktop/Zoootecnia/Tópicos especiais em suinocultura/Artigo FanerótipoXBiometria/SuinosMoura_DadosAtualizados")
getwd()

# Input data for analysis
# Inserindo Dados para a Análise
dados <- read.csv("PCAquantitativoRletras.csv", sep = ";")
i <- dados[,-c(1,2)]
str(dados)
attach(dados)

#Principal Component Analysis (PCA)
#Análise de Componentes Principais
prin_comp <-prcomp(i,scale = T)
prin_comp

# Principal Component extraction of the analysis
# Extração das componentes principais (Features)
center <- prin_comp$center
scale <- prin_comp$scale
hm <- as.matrix(dados[,-c(1,2)])
PCA1<- drop(scale(hm, center = center, scale = scale) %*% prin_comp$rotation[,1])
PCA2<- drop(scale(hm, center = center, scale = scale) %*% prin_comp$rotation[,2])

# Creating a Data Frame with the Extracted Principal Components
df <- data.frame (Systemsex,PCA1, PCA2) #SystemSex was a factor of my research, here you can change for a specific factor
# This was applied using "attach" command in the Input Data
colnames(df) <- c('Systemsex', 'PC1', 'PC2')


# Choose only the interest labels for the graphic analysis in PCA using Dplyr library
# Escolher apenas as categorias necessárias para a análise gráfica de PCA usando a biblioteca Dplyr
df <- df%>%filter(Systemsex == "Institutional - Sow" | Systemsex == "Institutional - Boar" |
                    Systemsex == "Subsistence - Sow" | Systemsex == "Subsistence - Boar")


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



