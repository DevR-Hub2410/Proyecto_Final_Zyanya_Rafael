# -- Ubicacion del archivo donde se almaceno la muestra
path <- "Proyecto_4_Rafael_Zyanya"
muestra <- read.csv(file.path(path, "data", "muestra.csv"), stringsAsFactors = FALSE)

# Obtener los valores de las variables que utilizaremos en el analisis
jobsat <- muestra$JobSat
modalidad <- muestra$modalidad

# =====================================
# JobSat
# =====================================

# Frecuencia de satisfaccion laboral
n_jobsat <- table(factor(jobsat, levels = 0:10))
n_jobsat

N_jobsat <- cumsum(n_jobsat)
N_jobsat

f_jobsat <- prop.table(n_jobsat)
f_jobsat

F_jobsat <- cumsum(f_jobsat)

por_jobsat <- f_jobsat * 100
por_jobsat

# tabla de frecuencias
tabla_jobsat <- data.frame(
  Satisfaccion = names(n_jobsat),
  Frecuencia_absoluta = as.vector(n_jobsat),
  Frecuencia_acumulada = as.vector(N_jobsat),
  Frecuencia_relativa = as.vector(f_jobsat),
  Frecuencia_relativa_acumulada = as.vector(F_jobsat),
  Porcentaje = as.vector(por_jobsat)
)

View(tabla_jobsat)

# Medidas de tendencia central para jobsat
media <- mean(jobsat, na.rm = TRUE)
mediana <- median(jobsat, na.rm = TRUE)

jobsat_tabla <- table(jobsat)
moda <- names(jobsat_tabla[jobsat_tabla == max(jobsat_tabla)])

# Medidas de dispersion de jobsat
minimo <- min(jobsat, na.rm = TRUE)
maximo <- max(jobsat, na.rm = TRUE)
rango <- maximo - minimo
varianza <- var(jobsat, na.rm = TRUE)
desviacion_estandar <- sd(jobsat, na.rm = TRUE)

cuartiles <- quantile(jobsat, probs = c(0.25, 0.50, 0.75), na.rm = TRUE)
rango_intercuartil <- IQR(jobsat, na.rm = TRUE)

tabla_medidas <- data.frame(
  Medida = c(
    "Media",
    "Mediana",
    "Moda",
    "Minimo",
    "Maximo",
    "Rango",
    "Varianza",
    "Desviacion estandar",
    "Primer cuartil (Q1)",
    "Segundo cuartil (Q2)",
    "Tercer cuartil (Q3)",
    "Rango intercuartilico"
  ),
  Valor = c(
    round(media, 3),
    round(mediana, 3),
    paste(moda, collapse = ", "),
    minimo,
    maximo,
    rango,
    round(varianza, 3),
    round(desviacion_estandar, 3),
    cuartiles[1],
    cuartiles[2],
    cuartiles[3],
    rango_intercuartil
  )
)

View(tabla_medidas)

# =============================================
# Modalidad
# =============================================

# Aqui solo se calculara frecuencia porque modalidad es una variable cualitativa
n_mod <- table(modalidad)
n_mod

N_mod <- cumsum(n_mod)
N_mod

f_mod <- prop.table(n_mod)
f_mod

F_mod <- cumsum(f_mod)

por_mod <- f_mod * 100
por_mod

tabla_mod <- data.frame(
  Modalidad = names(n_mod),
  Frecuencia_absoluta = as.vector(n_mod),
  Frecuencia_relativa = as.vector(f_mod),
  Porcentaje = as.vector(por_mod)
)

View(tabla_mod)

# --- Guardar tablas --- 
dir.create(file.path(path, "resultados", "tablas"), recursive = TRUE, showWarnings = FALSE)
write.csv(tabla_jobsat, file.path(path, "resultados", "tablas", "frecuencias_jobsat.csv"), row.names = FALSE)
write.csv(tabla_medidas, file.path(path, "resultados", "tablas", "medidas_jobsat.csv"), row.names = FALSE)
write.csv(tabla_mod, file.path(path, "resultados", "tablas", "frecuencias_modalidad.csv"), row.names = FALSE)

# =====================================
# Comparacion descriptiva por modalidad
# =====================================
media_mod <- tapply(jobsat, modalidad, mean)
tabla_comp <- data.frame(
  Modalidad = names(media_mod),
  n = as.vector(table(modalidad)),
  Media = round(as.vector(media_mod), 2),
  Mediana = as.vector(tapply(jobsat, modalidad, median)), 
  Desviacion_estandar = round(as.vector(tapply(jobsat, modalidad, sd)), 2),
  Q1 = as.vector(tapply(jobsat, modalidad, quantile, probs = 0.25)), 
  Q3 = as.vector(tapply(jobsat, modalidad, quantile, probs = 0.75))
)
tabla_comp 
write.csv(tabla_comp, file.path(path, "resultados", "tablas", "comparacion_por_modalidad.csv"), row.names = FALSE)

# =====================================
# Figuras
# =====================================
dir.create(file.path(path, "resultados", "figuras"), recursive = TRUE, showWarnings = FALSE)

png(file.path(path, "resultados", "figuras", "barras_jobsat.png"), width = 900, height = 600)
barplot(n_jobsat,
        main = "Distribucion de la satisfaccion laboral (n = 1500)",
        xlab = "Satisfaccion laboral (escala 0 - 10)", 
        ylab = "Numero de desarrolladores", col = "steelblue")
dev.off()

png(file.path(path, "resultados", "figuras", "cajas_jobsat_modalidad.png"), width = 1000, height = 600)
par(mar = c(5, 11, 4, 2))
boxplot(jobsat ~ modalidad, horizontal = TRUE, las = 1, col = "lightgray", 
        main = "Satisfaccion laboral segun modalidad de trabajo", 
        xlab = "Satisfaccion laboral (escala 0 - 10)", ylab = "")
dev.off()