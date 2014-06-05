Lobsters::Application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.assets.version = '1.0'
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx
  config.force_ssl = false
  config.log_level = :info
  config.action_mailer.raise_delivery_errors = true
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.action_mailer.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = YAML.load_file('config/email.yml')
  config.middleware.use ExceptionNotification::Rack,
    :email => {
    :email_prefix => "[Resources] ",
    :sender_address => %{"Resources" <noreply@stefanwienert.de>},
    :exception_recipients => %w{info@stefanwienert.de}
  }

end
