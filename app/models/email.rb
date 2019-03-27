class Email < Settingslogic
  source "#{Rails.root}/config/email.yml"
  namespace Rails.env
end
