Rails.application.configure do
  # 開啟後會在啟動 server 時就都載入並執行 class 檔案, 行為是 require 檔案, 除非重啟 server, 不然因為已經載入過該路徑的檔案所以即使檔案內容更新都不會再重載, 雖然會變慢但便於開發
  config.cache_classes = true

  # 開啟 eager_load 雖然會造成啟動 server 時因為要先載入很多東西變慢, 但之後整個 app 會節省許多記憶體, 因為所有 threaded web servers 都不用再建立執行緒去處理這些事情, 可以做到 copy on write
  # 注意跑 Rake tasks 不包含在這個 congif 裡面
  config.eager_load = true

  # 將發生錯誤時的Call stack trace資訊給瀏覽器顯示(紅畫面), 正式站不使用
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = true
  config.assets.digest = true

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "cell_web_#{Rails.env}"

  config.action_mailer.perform_caching = false

  config.action_mailer.default_url_options = {
    host: "jspe.com.tw"
  }

  config.action_mailer.delivery_method = :smtp


  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = [I18n.default_locale]
  config.i18n.available_locales = ['en', 'zh-TW']

  # 設定用哪種方法提醒之後有什麼功能會在之後的 rails 版本被棄用
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  config.serve_static_assets = false

  config.paperclip_defaults = {
    storage: :s3,
    preserve_files: true,
    s3_host_name: "s3-#{AwsS3.s3_region}.amazonaws.com",
    s3_credentials: {
      access_key_id: AwsS3.access_key_id,
      secret_access_key: AwsS3.secret_access_key,
      s3_region: AwsS3.s3_region,
    },
    bucket: AwsS3.bucket
  }

  config.action_mailer.smtp_settings = {
    address: Email.address,
    port: Email.port,
    domain: Email.domain,
    authentication: Email.authentication,
    user_name: Email.user_name,
    password: Email.password,
    enable_starttls_auto: true
  }
end
