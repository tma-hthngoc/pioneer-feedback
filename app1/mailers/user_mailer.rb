class UserMailer < ActionMailer::Base
  default from: 'feedback@wallem.com',
          to: 'dathi@tma.com.vn'

  def feedback(fb)
    ActionMailer::Base.smtp_settings = {
        :address => 'smtp.gmail.com',
        :port => 587,
        :domain => 'gmail.com',
        :authentication => :plain,
        :user_name => "wallemtmatest@gmail.com",
        :password => "12345678@X",
        :enable_starttls_auto => 1,
        :openssl_verify_mode => 'none'
    }

    @from = fb[:from]
    @subject = fb[:subject]
    @body = fb[:msg]

    if @from && @from.to_s.match(/(?>(?:[0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+)[a-zA-Z]{2,9}/)
      mail(cc: @from,
           subject: @subject).deliver!
    else
      mail(subject: @subject).deliver!
    end

  end
end
