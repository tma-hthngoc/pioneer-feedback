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
    flash.clear
    @feedback = Feedback.new(params[:feedback])
    p '------1. create new'
    p @feedback
    # hthngoc - Captcha
    if verify_recaptcha(:model => @feedback, :message => "Please type verification code again")
      p '-----3. captcha is valid'
      if @feedback.valid?
        p '-----4. sending email'
        # dathi - Send email
        begin
          UserMailer.feedback(params[:feedback])
          flash[:success] = "Message Sent! Many thanks, all feedback is valuable to us!"
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
      #flash[:error] = "Please type verification code again"
      render :action => 'new'
    end
  end

end
