
FROM rstudio/plumber

RUN apt-get update -qq && apt-get install -y libssl-dev libcurl4-gnutls-dev libpng-dev pandoc

RUN R -e "install.packages(c('plumber', 'dplyr', 'tidyverse', 'tidymodels'))"

COPY API.R API.R
COPY diabetes_binary_health_indicators_BRFSS2015.csv diabetes_binary_health_indicators_BRFSS2015.csv
COPY RF_wkf.rds RF_wkf.rds

EXPOSE 8000

ENTRYPOINT ["R", "-e", "pr <- plumber::plumb('API.R'); pr$run(host='0.0.0.0', port = 8000)"]