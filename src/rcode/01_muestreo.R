# 02_muestreo.R
# Muestreo aleatorio simple sobre la poblacion de desarrolladores profesionales 

ruta <- "Proyecto_Final_Zyanya_Rafael/resource"
poblacion <- read.csv(file.path(ruta, "data", "datos_limpios.csv"), stringsAsFactors = FALSE)
N <- nrow(poblacion) # tamaño de la poblacion 

# --- Tamaño de muestra: n = (z * sigma / E)^2 ---
z <- 1.96 # 95% de confianza
sigma <- sd(poblacion$JobSat) # valor de referencia 
E <- 0.1 # margen de error deseado 
n_calculado <- ceiling((z * sigma /E)^2)
n_calculado 
n <- 1500 # tamaño eledigo (redondeo hacia arriba)

# --- Muestreo aleatorio simple sin reemplazo ---
set.seed(2026) # semilla fija: el resultado se puede reproducir 
indices <- sample(seq_len(N), size = n)
muestra <- poblacion[indices, ]
nrow(muestra)

# --- Representatividad: porcentaje po modalidad (poblacion vs muestra) ---
tabla_rep <- cbind(
  Poblacion = round(100 * prop.table(table(poblacion$modalidad)), 1),
  Muestra = round(100 * prop.table(table(muestra$modalidad)), 1)
)
tabla_rep

# --- Guardar resultados ---
write.csv(muestra, file.path(ruta, "data", "muestra.csv"), row.names = FALSE)
write.csv(tabla_rep, file.path(ruta, "result", "representatividad_modalidad.csv"))