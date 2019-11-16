Rails.application.configure do
  # 關閉後會讓每一次的 request 都重新載入 class 檔案, 行為是 load 檔案, 每次需要執行到 class 檔案就會載入一次, 雖然會變慢但便於開發
  config.cache_classes = false

  # 參考 production 環境的敘述
  config.eager_load = false

  # 將發生錯誤時的Call stack trace資訊給瀏覽器顯示(紅畫面), 開發端使用
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_caching = false

  config.action_mailer.default_url_options = {
    host: "localhost:3000"
  }

  config.action_mailer.delivery_method = :smtp

  config.i18n.available_locales = 'zh-TW'

  # 設定用哪種方法提醒之後有什麼功能會在之後的 rails 版本被棄用
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

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
