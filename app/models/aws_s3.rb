class AwsS3 < Settingslogic
  source "#{Rails.root}/config/aws_s3.yml"
  namespace Rails.env
end
