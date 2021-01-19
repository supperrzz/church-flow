class ApplicationMailer < ActionMailer::Base
  default from: ENV['SENDGRID_MAIL'] || 'contact@churchflow.io'
  layout 'mailer'
end
