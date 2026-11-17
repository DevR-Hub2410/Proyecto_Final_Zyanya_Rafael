# 04_estimacion.R
# Estimacion de la media de satisfaccion laboral (JobSat, escala 0-10)

ruta <- "resource"
muestra <- read.csv(file.path(ruta, "data", "muestra.csv"), stringsAsFactors = FALSE)

# --- Estadisticos de la muestra ---
n <- nrow(muestra)
media <- mean(muestra$JobSat) # Estimacion puntual de la media poblacional 
desv <- sd(muestra$JobSat)
error_est <- desv / sqrt(n) # error estandar de la media 

# --- Intervalo de confianza del 95% (t de Student) ---
confianza <- 0.95
t_critico <- qt(1 - (1 - confianza) / 2, df = n - 1)
margen <- t_critico * error_est
ic_inferior <- media - margen 
ic_superior <- media + margen 
c(media = media, inferior = ic_inferior, superior = ic_superior, margen = margen)

# --- Verificacion con la funcion de R ---
t.test(muestra$JobSat, conf.level = 0.95)$conf.int

# --- Guardar tabla ---
tabla_ic <- data.frame(n = n, media = round(media, 3), desviacion = round(desv, 3),
                       error_estandar = round(error_est, 4), 
                       ic_inferior = round(ic_inferior, 3),
                       ic_superior = round(ic_superior, 3),
                       margen = round(margen, 3))
write.csv(tabla_ic, file.path(ruta, "result", "ic_media_global.csv"), row.names = FALSE)

# --- IC de la media por modalidad --- 
grupos <- split(muestra$JobSat, muestra$modalidad)

ic_grupo <- function(x, confianza = 0.95) {
  n <- length(x)
  m <- mean(x)
  s <- sd(x)
  margen <- qt(1 - (1 - confianza) / 2, df = n - 1) * s / sqrt(n)
  c(n = n, media = m, desviacion = s,
    ic_inferior = m - margen, ic_superior = m + margen, margen = margen)
}

tabla_ic_mod <- as.data.frame(t(sapply(grupos, ic_grupo)))
tabla_ic_mod$modalidad <- rownames(tabla_ic_mod)
tabla_ic_mod <- tabla_ic_mod[, c("modalidad", "n", "media", "desviacion", "ic_inferior", "ic_superior", "margen")]
tabla_ic_mod[, -1] <- round(tabla_ic_mod[, -1], 3)
tabla_ic_mod

write.csv(tabla_ic_mod, 
          file.path(ruta, "result", "ic_media_por_modalidad.csv"),
          row.names = FALSE)

# --- Verificacion didactica: media real de la poblacion vs. cada IC ---
poblacion <- read.csv(file.path(ruta, "data", "datos_limpios.csv"), stringsAsFactors = FALSE)
media_pob <- tapply(poblacion$JobSat, poblacion$modalidad, mean)
verif <- data.frame(modalidad = names(media_pob),
                    media_poblacional = round(as.numeric(media_pob), 3))
verif <- merge(tabla_ic_mod[, c("modalidad", "ic_inferior", "ic_superior")],
               verif, by = "modalidad")
verif$captura <- verif$media_poblacional >= verif$ic_inferior & verif$media_poblacional <= verif$ic_superior
verif 
