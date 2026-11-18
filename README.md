# Proyecto Final: Análisis estadístico inferencial de la satisfacción laboral de desarrolladores

**Asignatura:**Estadística · Ingeniería de Software · Universidad Autónoma de Ciudad Juárez
**Docente:** Dra. Liliana Orizel Martínez Martínez
**Integrantes:** Zyanya Tajani Mireles Gaspar, Rafae; Castillo Villalba

## Descripción del caso

Se analiza la satisfacción laboral de desarrolladores profesionales a partir de la Stack Overflow Annual Developer Survey 2025. Este proyecto da cotinuidad al análisis descriptivo y de estimación realizado anteriormente, incorporando técnicas de estadística inferencial para estudiar la satisfacción laboral y evaluar posibles diferencias según la modalidad de trabajo. 

El análisis incluye estimaciones puntuales, intervalos de confianza, pruebas de hipótesis y un análisis de varianza (ANOVA) de un factor, utilizando R y RStudio. 

## Pregunta del análisis

¿Cómo se comporta la satisfacción laboral (escala 0-10) de los desarrolladores profesionales y qué diferencias se observan según su modalidad de trabajo?

## Conjunto de datos 

- **Datos originales:** 49,191 respuestas y 172 columnas. 
- **Población de estudio:** 22,797 desarrolladores profesionales (`MainBranch` = desarrollador por profesión) que respondieron satisfacción laboral (`JobSat`) y modalidad de trabajo (`RemoteWork`).
- **Muestra:** 1,500 registros, mediante muestreo aleatorio simple sin reemplazo (semilla 2026).
- **Variables principales utilizadas en el análisis:**

| Variable | Descripción | Tipo | Escala |
|---|---|---|---|
| `JobSat` | Satisfacción laboral (0 a 10) | Cuantitativa discreta | Intervalo |
| `modalidad` | Modalidad de trabajo (5 categorías) | Cualitativa | Nominal |

También se conservan `ResponseId`, `Country` y `WorkExp` en `datos_limpios.csv`, aunque no se utilizaron en los análisis presentados. 

## Fuente de los datos 

Stack Overflow Annual Developer Survey 2025, © 2025 Stack Exchange Inc., bajo licencia Apache 2.0 (copia en `resource/data/LICENSE_StackOverflow.txt`).

- **Sitio oficial:** https://survey.stackoverflow.co/
- **Datos originales:** https://github.com/StackExchange/Survey/raw/refs/heads/main/packages/archive/2025/results.csv

Los datos originales (`results.csv`, aproximadamente 134 MB) no se incluyen en el repositorio debido a su tamaño. Los archivos `datos_limpios.csv` y `muestra.csv` contienen los datos preparados y la muestra utilizada en el análisis. 

## Análisis estadísticos realizados

1. **Muestreo:** selección de 1,500 observaciones mediante muestreo aleatorio simple sin reemplazo. 
2. **Análisis descriptivo:** elaboración de tabñas de frecuencias, medidas estadísticas y comparación de la satisfacción laboral según la modalidad de trabajo. 
3. **Estimación:** cálculo de estimaciones puntuales e intervalos de confianza del 95% para la media de satisfacción laboral, la proporción de satisfacción alta y la diferencia de medias entre trabajadores remotos y presenciales. 
4. **Pruebas de hipótesis:**
  - Prueba t de Welch para comparar la satisfacción laboral promedio entre trabajadores remotos y presenciales. 
  - Prueba de una proporción para determinar si más del 50% de los desarrolladores presenta una satisfacción laboral igual o superior a 7.
5. **Análisis inferencial complementario:**
  - Evaluación de normalidad de los residuos mediante Shapiro-Wilk.
  - Evaluación de homogeneidad de varianzas mediante Brown-Forsythe. 
  - ANOVA de un factor para comparar las cinco modalidades de trabajo. 
  - Comparaciones múltiples mediante el método de Tukey.
  
## Principales resultados

A partir de la muestra de 1,500 observaciones, se obtuvieron los siguientes resultados:

| Indicador | Resultado |
|---|---:|
| Media de satisfacción laboral | 7.148 |
| IC del 95% para la media | [7.050, 7.246] |
| Proporción con satisfacción alta (7 a 10) | 70.73% |
| Diferencia de medias (Remoto - Presencial) | 0.242 |

Entre los resultados inferenciales destacan:

- La prueba t de Welch no encontró evidencia estadística suficiente de una diferencia entre la satisfacción laboral promedio de trabajadores remotos y presenciales (`p = 0.119`).
- La prueba de una proporción encontró evidencia de que más del 50% de la población de estudio presenta una satisfacción laboral de 7 o más (`p < 0.001`).
- El ANOVA no encontró diferencias estadísticamente significativas entre las cinco modalidades de trabajo (`p = 0.361`).
- Las comparaciones múltiples de Tukey tampoco identificaron diferencias estadísticamente significativas entre los pares de modalidades. 

## Estructura de carpetas 

```text
Proyecto_Final_Zyanya_Rafael/
│
├── README.md
│
├── resource/
│   ├── data/
│   │   ├── LICENSE_StackOverflow.txt
│   │   ├── datos_limpios.csv
│   │   └── muestra.csv
│   │
│   └── result/
│       ├── comparacion_por_modalidad.csv
│       ├── frecuencias_jobsat.csv
│       ├── frecuencias_modalidad.csv
│       ├── ic_media_global.csv
│       ├── ic_media_por_modalidad.csv
│       ├── medidas_jobsat.csv
│       └── representatividad_modalidad.csv
│
├── scr/
│   └── rcode/
│       ├── 01_muestreo.R
│       ├── 02_analisis_descriptivo.R
│       ├── 03_estimacion.R
│       ├── 04_pruebas_hipotesis.R
│       └── 05_analisis_inferencial.R
│
└── .gitignore
```

## Instrucciones para ejecutar el análisis

1. Clonar o descargar el repositorio y abrir el proyecto desde RStudio. 
2. Verificar que los archivos `datos_limpios.csv` y `muestra.csv` se encuentren en `resource/data/`.
3. Ejecutar los scripts en el siguiente orden, desde la raíz del proyecto:

  1. `scr/rcode/01_muestreo.R`: realiza el muestreo aleatorio simple y genera el archivo correspondiente.
  2. `scr/rcode/02_analisis_descriptivo.R`: realiza el análisis descriptivo y genera las tablas correspondientes.
  3. `scr/rcode/03_estimacion.R`: calcula las estimaciones puntuales y los intervalos de confianza.
  4. `scr/rcode/04_pruebas_hipotesis.R`: ejecuta las pruebas de hipótesis planteadas.
  5. `scr/rcode/05_analisis_inferencial.R`: evalúa los supuestos y realiza el análisis ANOVA y las comparaciones múltiples de Tukey.

4. Los resultados generados se almacenan en `resource/result/`.

Se utiliza la semilla aleatoria `set.seed(2026)` para mantener la reproducibilidad del procedimiento de muestreo. 

## Paquetes de R utilizados

El análisis se desarrolla en R y RStudio. La versión de R utilizada para el proyecto es R 4.6.1.

## Limitaciones

- La encuesta es de participación voluntaria, por lo que los resultados describen la población definida a partir de sus participantes y no necesariamente a todos los desarrolladores. 
- La satisfacción laboral es una variable autorreportada y se trató como cuantitativa para relizar los análisis. 
- El estudio es observacional, por lo que no permite establecer relaciones de casualidad. 
- La prueba de Shapiro-Wilk indicó desviaciones de la normalidad de los residuos, por lo que los resultados del ANOVA deben interpretarse considerando esta limitación. 
- Los resultados dependen de la muestra seleccionada y de las respuestas disponibles en la encuesta. 

## Referencias

- Stack Overflow. (2025). *2025 Stack Overflow Developer Survey*. https://survey.stackoverflow.co/
- R Core Team. (2025). *R: A language and environment for statistical computing*. https://www.R-project.org/
- JMP Statistical Discovery. *ANOVA de un factor*. https://www.jmp.com/es/statistics-knowledge-portal/one-way-anova
- Master Statistics. *Test de Levene*. https://master-statistics.com/es/contrastes-hipotesis/test-levene/
- Master Statistics. *Test de normalidad de Shapiro-Wilk*. https://master-statistics.com/es/contrastes-hipotesis/test-shapiro-wilk/
- Minitab. *What is Tukey’s method for multiple comparisons?* https://support.minitab.com/minitab/help-and-how-to/statistical-modeling/anova/supporting-topics/multiple-comparisons/what-is-tukey-s-method

---

**Proyecto académico desarrollado por Zyanya Tajani Mireles Gaspar y Rafael Castillo Villalba.**
Universidad Autónoma de Ciudad Juárez · 2026
