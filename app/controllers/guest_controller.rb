class GuestController < ApplicationController
  # GET /guests/new
  # GET /guests/new.json
  def new
    @guest = Guest.new
    @guest.email = params[:email]
    if params[:code] == '2511'
      @guest.save
      redirect_to root_path, notice: ';-)' 
    else
      redirect_to root_path
    end
  end

  def guest_list
    message = Notifier.guest_list(params[:email])   # => Returns a Mail::Message object
    message.deliver
    redirect_to root_path, notice: t("helpers.labels.request_send") 
  end

end
