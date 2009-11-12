if APP_CONFIG[:hoptoad]
  HoptoadNotifier.configure do |config|
    config.api_key = ENV['HOPTOAD_KEY']
  end
end