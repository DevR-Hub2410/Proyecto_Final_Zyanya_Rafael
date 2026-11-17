# Pruebas de hipotesis
ruta <- "resource"
muestra <- read.csv(file.path(ruta, "data", "muestra.csv"), stringsAsFactors = FALSE)

alpha  <- 0.05

# ============== Primera prueba: satisfaccion promedio entre remoto y presencial ==============

# Seleccionar unicamente las modalidades Remoto y Presencial
datos_rp <- subset(
  muestra,
  modalidad %in% c("Remoto", "Presencial")
)

# Eliminar las demas categorias que no se van a utilizar
datos_rp$modalidad <- droplevels(
  as.factor(datos_rp$modalidad)
)

# Revisar la cantidad de observaciones
table(datos_rp$modalidad)

# Prueba de medias
prueba_medias <- t.test(
  JobSat ~ modalidad,
  data = datos_rp,
  var.equal = FALSE,
  alternative = "two.sided"
)

prueba_medias
prueba_medias$p.value
if(prueba_medias$p.value < alpha) {
  print("Se rechaza H0")
} else {
  print("No se rechaza H0")
}

# ============== Segunda Prueba: proporción de satisfacción laboral alta ==============

# Contar trabajdores con una satisaccion laboral mayor o igual a 7
exitos <- sum(muestra$JobSat >= 7, na.rm = TRUE)

# Obtener tamaño de muestra valido
n <- sum(!is.na(muestra$JobSat))

# Calcular proporcion muestral
proporcion <- exitos / n

# Mostrar resultados
exitos
n
proporcion

# Prueba de proporcion
prueba_proporcion <- prop.test(
  x = exitos,
  n = n,
  p = 0.50,
  alternative = "greater"
)

prueba_proporcion
prueba_proporcion$p.value
if(prueba_proporcion$p.value < alpha) {
  print("Se rechaza H0")
} else {
  print("No se rechaza H0")
}
