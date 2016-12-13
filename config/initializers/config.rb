unless Rails.env.production?
  APP_CONFIG = YAML.load(File.read(Rails.root.join('config/secure.yml')))[Rails.env]
end