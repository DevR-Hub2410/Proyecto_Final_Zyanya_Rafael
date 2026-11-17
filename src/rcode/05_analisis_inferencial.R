# ANOVA de un factor

ruta <- "resource"
muestra <- read.csv(file.path(ruta, "data", "muestra.csv"), stringsAsFactors = FALSE)

muestra$modalidad <- as.factor(muestra$modalidad)

datos_anova <- na.omit(muestra[, c("JobSat", "modalidad")])

# Frecuencia por modalidad
table(datos_anova$modalidad)


# 1. Modelo ANOVA
modelo <- aov(JobSat ~ modalidad, data = datos_anova)


# 2. Prueba de normalidad
shapiro.test(residuals(modelo))

qqnorm(residuals(modelo))
qqline(residuals(modelo))


# 3. Prueba de Levene (Brown-Forsythe) sin librerias

prueba_levene <- function(respuesta, grupo) {
  
  datos <- data.frame(respuesta, grupo)
  datos <- na.omit(datos)
  
  medianas <- ave(
    datos$respuesta,
    datos$grupo,
    FUN = median
  )
  
  desviaciones <- abs(datos$respuesta - medianas)
  
  modelo <- aov(desviaciones ~ grupo, data = datos)
  
  summary(modelo)
}

resultado_levene <- prueba_levene(
  datos_anova$JobSat,
  datos_anova$modalidad
)

resultado_levene

# 4. ANOVA de un factor
resultado_anova <- aov(JobSat ~ modalidad, data = datos_anova)

summary(resultado_anova)


# 5. Comparaciones multiples (Tukey)
TukeyHSD(resultado_anova)

aggregate(
  JobSat ~ modalidad,
  data = datos_anova,
  FUN = function(x) c(
    media = mean(x),
    desviacion = sd(x),
    mediana = median(x)
  )
)
