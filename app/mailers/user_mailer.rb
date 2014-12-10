class UserMailer < ActionMailer::Base
  default from: 'pioneer.feedback@gmail.com',
          #to: 'pioneer@wallem.com' # production
          to: 'dathi@tma.com.vn' # develop

  def feedback(fb)
    ActionMailer::Base.smtp_settings = {
        :address => 'smtp.gmail.com',
        :port => 587,
        :domain => 'gmail.com',
        :authentication => :plain,
        :user_name => 'pioneer.feedback@gmail.com',
        :password => '12345678@X',
        :enable_starttls_auto => 1,
        :openssl_verify_mode => 'none'
    }

    @from = fb[:from]
    @subject = fb[:subject]
    @body = fb[:msg]

    mail(cc: @from, subject: @subject).deliver!

  end
end
