unless Rails.env.production?
  APP_CONFIG = YAML.load(Rails.root.join('config/secure.yml'))[Rails.env]
end