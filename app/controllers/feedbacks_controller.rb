class FeedbacksController < ApplicationController
  def index
    flash[:success] = 'Message Sent! Many thanks, all feedback is valuable to us!'
    @feedback = Feedback.new
  end

  def new
    flash.clear
    @feedback = Feedback.new
  end

  def captcha
    if verify_recaptcha(model: @feedback, message: "Oh! It's error with reCAPTCHA! Are you a human?")
      render :json => 1
    else
      render :json => 0
    end
  end

  require 'open-uri'

  def create
    @feedback = Feedback.new(params[:feedback])
    p params
    captcha = "https://www.google.com/recaptcha/api/siteverify?secret=6LcAov4SAAAAABDAy4U-_rXL_1bDx12QrG0-i-LB&response=#{params["g-recaptcha-response"]}"
    response_m = open(captcha).read
    if response_m['true']
      if @feedback.valid?
        # Send the email
        begin
          UserMailer.feedback(params[:feedback])
          flash[:success] = 'Message Sent! Many thanks, all feedback is valuable to us!'
        rescue => ex
          puts ex
          flash[:error] = 'There is some error. Sorry for this inconvenience.'
        end
        redirect_to root_url
      else
        render :action => 'new'
      end
    else
      flash[:error] = "Oh! It's error with reCAPTCHA! Are you a human?"
      render :action => 'new'
      return
    end
  end


end
