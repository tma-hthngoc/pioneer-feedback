class FeedbacksController < ApplicationController
  require 'open-uri'

  def index
    #flash[:success] = 'Message Sent! Many thanks, all feedback is valuable to us!'
    @feedback = Feedback.new
  end

  def new
    flash.clear
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    p '------1. create new'
    p @feedback
    # hthngoc - Captcha
    # Double-check at server side for security
    captcha = "https://www.google.com/recaptcha/api/siteverify?secret=6LcAov4SAAAAABDAy4U-_rXL_1bDx12QrG0-i-LB&response=#{params["g-recaptcha-response"]}"
    response_m = open(captcha).read
    p '-----2. captcha & respone' 
    p captcha
    p response_m  
    if response_m['true']
      p '-----3. captcha is valid' 
      if @feedback.valid?
        p '-----4. sending email'
        # dathi - Send email
        begin
          UserMailer.feedback(params[:feedback])
          flash[:success] = 'Message Sent! Many thanks, all feedback is valuable to us!'
        rescue => ex
          puts ex
          flash[:error] = "There is some error. Sorry for this inconvenience."
        end
        redirect_to root_url
      else        
        render :action => 'new'
      end
    else
      p '-----5: captcha is not valid, do nothing' 
      flash[:error] = "Oh! It's error with CAPTCHA! Are you a human?"
      render :action => 'new'
    end
  end


end
