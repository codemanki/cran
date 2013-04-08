require "cran_api"
CRAN_CONFIG = YAML.load_file("#{Rails.root}/config/cran.yml")[Rails.env]